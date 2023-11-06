-- TODO investigate patterns
return {
  "echasnovski/mini.pairs",
  opts = {
    mappings = {
      ["("] = { action = "open", pair = "()", neigh_pattern = ".[%W]" },
      ["["] = { action = "open", pair = "[]", neigh_pattern = ".[%W]" },
      ["{"] = { action = "open", pair = "{}", neigh_pattern = ".[%W]" },
      ["`"] = { action = "closeopen", pair = "``", neigh_pattern = ".[%W]", register = { cr = false } },
      ['"'] = { action = "closeopen", pair = '""', neigh_pattern = ".[%W]", register = { cr = false } },
      ["'"] = { action = "closeopen", pair = "''", neigh_pattern = ".[%W]", register = { cr = false } },
    },
  },
}
