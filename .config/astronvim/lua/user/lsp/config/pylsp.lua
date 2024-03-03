return {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'E501' },
          maxLineLength = 120
        },
        flake8 = {
          enabled = false,
          ignore = { 'E501' },
          maxLineLength = 120
        }
      }
    }
  }
}
