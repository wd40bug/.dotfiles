---@alias SystemType
---| 'ubuntu'
---| 'windows'
---| 'termux'
---| 'msys-work'

---@type SystemType
System = "ubuntu"
local system_env = os.getenv("SYSTEM")
if system_env ~= "" then
  System = system_env
end

require('opts')
require('plug')
require('theme')
require('treesitter')
require('keys')
require('lsp.lsp')
