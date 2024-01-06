-- TODO investigate patterns
return {
  -- disabled for now as it seems to conflict with copilot
  "echasnovski/mini.pairs",
  enabled = false,
  -- opts = {
  --   mappings = {
  --     ["("] = { action = "open", pair = "()", neigh_pattern = ".[%W]" },
  --     ["["] = { action = "open", pair = "[]", neigh_pattern = ".[%W]" },
  --     ["{"] = { action = "open", pair = "{}", neigh_pattern = ".[%W]" },
  --     ["`"] = { action = "closeopen", pair = "``", neigh_pattern = ".[%W]", register = { cr = false } },
  --     ['"'] = { action = "closeopen", pair = '""', neigh_pattern = ".[%W]", register = { cr = false } },
  --     ["'"] = { action = "closeopen", pair = "''", neigh_pattern = ".[%W]", register = { cr = false } },
  --   },
  -- },
}
