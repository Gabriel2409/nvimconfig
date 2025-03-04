-- by default lazyvim does not use pytest_discover_instances, which allows to use
-- pytest mark parametrize
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-python',
  },
  opts = {
    adapters = {
      ['neotest-python'] = {
        pytest_discover_instances = true,
      },
    },
  },
}
