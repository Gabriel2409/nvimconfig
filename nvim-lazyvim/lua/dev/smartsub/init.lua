-- lua/dev/smartsub/init.lua
local M = {}

local function cap(w)
  return w:sub(1, 1):upper() .. w:sub(2)
end
local function upper(ws)
  return vim.tbl_map(string.upper, ws)
end
local function title(ws)
  return vim.tbl_map(cap, ws)
end

-- "monMot" / "MON_MOT" / "mot-mot" / "MotMot" -> {"mon", "mot"}
local function split_words(s)
  s = s:gsub('([%l%d])(%u)', '%1 %2') -- bosse camelCase : eP -> e P
  s = s:gsub('(%u+)(%u%l)', '%1 %2') -- acronyme : HTTPServer -> HTTP Server
  s = s:gsub('[_%- ]+', ' ') -- séparateurs snake/kebab
  local out = {}
  for w in s:gmatch '%S+' do
    out[#out + 1] = w:lower()
  end
  return out
end

-- chaque style : { mode, renderer }
--   mode 'sep'  -> séparateurs (_ ou -), frontière = non [%w_]
--   mode 'case' -> camel/Pascal, frontière sensible aux bosses de casse
local styles = {
  {
    'sep',
    function(ws)
      return table.concat(ws, '_')
    end,
  }, -- snake
  {
    'sep',
    function(ws)
      return table.concat(upper(ws), '_')
    end,
  }, -- SCREAMING
  {
    'sep',
    function(ws)
      return table.concat(title(ws), '_')
    end,
  }, -- Title_Snake
  {
    'sep',
    function(ws)
      return table.concat(ws, '-')
    end,
  }, -- kebab
  {
    'sep',
    function(ws)
      return table.concat(upper(ws), '-')
    end,
  }, -- SCREAMING-KEBAB
  {
    'sep',
    function(ws)
      return table.concat(title(ws), '-')
    end,
  }, -- Title-Kebab
  {
    'case',
    function(ws) -- camel
      local o = {}
      for i, w in ipairs(ws) do
        o[i] = (i == 1) and w or cap(w)
      end
      return table.concat(o)
    end,
  },
  {
    'case',
    function(ws)
      return table.concat(title(ws), '')
    end,
  }, -- Pascal
}

-- M._map : forme_du_motif -> { to = forme_du_remplacement, mode = 'sep'|'case' }
M._map = {}

local function build(pat, rep)
  local pw = split_words(pat)
  local rw = split_words(rep)
  M._map = {}
  local any = false
  for _, st in ipairs(styles) do
    local mode, render = st[1], st[2]
    local from = render(pw)
    local to = (#rw > 0) and render(rw) or ''
    if from ~= '' and M._map[from] == nil then
      M._map[from] = { to = to, mode = mode }
      any = true
    end
  end
  return any
end

local function parse(args)
  if args == '' then
    return nil, nil
  end
  local sep = args:sub(1, 1)
  local parts = vim.split(args:sub(2), sep, { plain = true })
  return parts[1], parts[2] or ''
end

-- frontière valide pour une occurrence [s..e] (1-based, e inclusif) de `from`
local function boundary_ok(line, s, e, mode, from)
  local before = (s > 1) and line:sub(s - 1, s - 1) or ''
  local after = line:sub(e + 1, e + 1)
  if mode == 'sep' then
    local lok = before == '' or not before:match '[%w_]'
    local rok = after == '' or not after:match '[%w_]'
    return lok and rok
  else -- 'case'
    local first_upper = from:sub(1, 1):match '%u' ~= nil
    -- gauche : début / non-mot, ou bosse (minuscule|digit -> Majuscule)
    local lok
    if before == '' or not before:match '[%w_]' then
      lok = true
    elseif first_upper and before:match '[%l%d]' then
      lok = true
    else
      lok = false
    end
    -- droite : fin / non-mot, ou bosse (suivi d'une Majuscule)
    local rok
    if after == '' or not after:match '[%w_]' then
      rok = true
    elseif after:match '%u' then
      rok = true
    else
      rok = false
    end
    return lok and rok
  end
end

-- occurrences entières des formes sur une ligne, triées, sans chevauchement.
-- 0-based : { s = start_col, e = end_col(exclusif), to = remplacement }
local function find_matches(line)
  local matches = {}
  for from, info in pairs(M._map) do
    local init = 1
    while true do
      local s, e = string.find(line, from, init, true)
      if not s then
        break
      end
      if boundary_ok(line, s, e, info.mode, from) then
        matches[#matches + 1] = { s = s - 1, e = e, to = info.to }
      end
      init = e + 1
    end
  end
  table.sort(matches, function(a, b)
    if a.s == b.s then
      return (a.e - a.s) > (b.e - b.s)
    end -- plus long d'abord
    return a.s < b.s
  end)
  local out, last_e = {}, -1
  for _, m in ipairs(matches) do
    if m.s >= last_e then
      out[#out + 1] = m
      last_e = m.e
    end
  end
  return out
end

-- reconstruit une ligne. preview=true : si to=='' on garde la source (highlight-only).
-- renvoie new_line, spans  (spans 0-based dans new_line : {s, e, hl})
local function transform_line(line, preview)
  local matches = find_matches(line)
  if #matches == 0 then
    return nil, nil
  end
  local parts, spans = {}, {}
  local prev, newlen = 0, 0
  for _, m in ipairs(matches) do
    local pre = line:sub(prev + 1, m.s) -- segment [prev, m.s)
    parts[#parts + 1] = pre
    newlen = newlen + #pre
    local seg, hl
    if m.to == '' then
      if preview then
        seg, hl = line:sub(m.s + 1, m.e), 'IncSearch' -- garde la source, surligne
      else
        seg, hl = '', nil -- exécution : supprime
      end
    else
      seg, hl = m.to, 'Substitute'
    end
    if hl then
      spans[#spans + 1] = { newlen, newlen + #seg, hl }
    end
    parts[#parts + 1] = seg
    newlen = newlen + #seg
    prev = m.e
  end
  parts[#parts + 1] = line:sub(prev + 1)
  return table.concat(parts), spans
end

function M.subvert(pat, rep, l1, l2)
  if not build(pat, rep) then
    return
  end
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, l1 - 1, l2, false)
  local changed = false
  for i, line in ipairs(lines) do
    local nl = transform_line(line, false)
    if nl then
      lines[i] = nl
      changed = true
    end
  end
  if changed then
    vim.api.nvim_buf_set_lines(buf, l1 - 1, l2, false, lines)
  end
end

local function preview(opts, ns, _)
  local pat, rep = parse(opts.args)
  if not pat or pat == '' then
    return 0
  end
  if not build(pat, rep) then
    return 0
  end

  local buf = vim.api.nvim_get_current_buf()
  local l1, l2
  if opts.range > 0 then
    l1, l2 = opts.line1, opts.line2
  else
    local cur = vim.api.nvim_win_get_cursor(0)[1]
    l1, l2 = cur, cur
  end

  local shown = false
  for lnum = l1, l2 do
    local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
    if line then
      local nl, spans = transform_line(line, true)
      if nl then
        if nl ~= line then
          vim.api.nvim_buf_set_lines(buf, lnum - 1, lnum, false, { nl })
        end
        for _, sp in ipairs(spans) do
          vim.api.nvim_buf_set_extmark(buf, ns, lnum - 1, sp[1], {
            end_col = sp[2],
            hl_group = sp[3],
          })
        end
        shown = true
      end
    end
  end
  return shown and 2 or 0
end

vim.api.nvim_create_user_command('S', function(o)
  local pat, rep = parse(o.args)
  if not pat then
    return
  end
  local l1, l2
  if o.range > 0 then
    l1, l2 = o.line1, o.line2
  else
    local cur = vim.api.nvim_win_get_cursor(0)[1]
    l1, l2 = cur, cur
  end
  M.subvert(pat, rep, l1, l2)
end, { range = true, nargs = 1, preview = preview })

M._split_words = split_words
M._build = build
M._find_matches = find_matches
M._transform_line = transform_line
M._preview = preview

return M
