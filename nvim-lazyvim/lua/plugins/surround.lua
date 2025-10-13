return {
  'nvim-mini/mini.surround',
  opts = {
    custom_surroundings = {
      ['('] = { output = { left = '( ', right = ' )' } },
      ['['] = { output = { left = '[ ', right = ' ]' } },
      ['{'] = { output = { left = '{ ', right = ' }' } },
      ['<'] = { output = { left = '< ', right = ' >' } },
    },
    mappings = {
      add = 'ys',
      delete = 'ds',
      find = '',
      find_left = '',
      highlight = '',
      replace = 'cs',
      update_n_lines = '',
    },
    search_method = 'cover_or_next',
  },
}
