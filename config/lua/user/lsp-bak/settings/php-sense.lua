local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.phpsense then
  configs.phpsense = {
    default_config = {
      cmd = {'php-sense'};
      filetypes = {'php', 'sense'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
      end;
      settings = {};
    };
  }
end

return {}
