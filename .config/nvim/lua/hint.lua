---@type integer?
HintWindow = nil
local max_width = 50

---Determines if string begins with start
---@param test string
---@param start string
---@return boolean
local function starts_with(test, start)
  return (string.sub(test, 1,#start) == start)
end

---Get all keymaps starting with the values
---@param ... string
---@return Iter
local function all_keymaps_starting_with(...)
  local keys_global = vim.api.nvim_get_keymap('n') -- List of keybinds
  local keys_buf = vim.api.nvim_buf_get_keymap(0, 'n')
  local keys = table.move(keys_buf, 1, #keys_buf, #keys_global, keys_global)
  local arg = {...}
  local keymap_iter = vim.iter(keys):filter(function(value)  -- only get keybinds starting with lead
    for _, start in ipairs(arg) do
      if starts_with(value.lhs, start) then
        return true
      end
    end
    return false
  end)
  return keymap_iter
end

---returns the name, replacing it with the special name if one's listed
---@param name string
---@return string
local function map_special_names(name)
  for start, map in pairs(SpecialNames) do
    if starts_with(name, start) then
      local change, _ = name:gsub(start:gsub('[%(%)%.%%%+%-%*%?%[%]%^%$]', '%%%0'), map) 
      return change
    end
  end
  return name
end


---Creates a window showing hint dialogue for a given key with a given title
---Only works for normal mode keymaps
---@param lead string
function CreateWindow(lead)
  local hint_buf = vim.api.nvim_create_buf(false, true)
  local ui = vim.api.nvim_list_uis()[1]
  local keymap_iter = all_keymaps_starting_with(lead):map(function(v) v.lhs = map_special_names(v.lhs); return v end) 

  local longest_lhs = keymap_iter:fold(0, function(acc, val)
    return math.max(acc, #val.lhs)
  end)
  
  local mark_namespace = vim.api.nvim_create_namespace("Hints")

  local keymap_strings = keymap_iter:map( -- Add desc to text
    function(value)
      local str = value.lhs .. string.rep(' ', 3 + longest_lhs - #value.lhs) .. tostring(value.desc)
      value.str_len = #str
      if value.str_len > max_width - 3 then
        str = string.sub(str, 1,max_width-(10 + longest_lhs)) .. "... :Hint ".. value.lhs
      end
      value.str = str
      return value
    end
  )

  local keymap_table = keymap_strings:totable()
  vim.api.nvim_buf_set_lines(hint_buf, 0, #keymap_table, false, keymap_strings:fold({}, function (acc, val)
    acc[#acc+1] = val.str
    return acc
  end))
  for i, key in ipairs(keymap_table) do
    if key.str_len > max_width - 3 then
      vim.api.nvim_buf_add_highlight(hint_buf, -1, "Tag", i-1, max_width - (longest_lhs + 6), -1)
    end
   
  end

  local max_len = keymap_strings:map(function(value)  -- get size of text
    return string.len(value.str)
  end):fold(0, function(acc, value)
    acc = math.max(value, acc)
    return acc
  end)

  if HintWindow then
    vim.api.nvim_win_close(HintWindow, false)
    HintWindow = nil
  end
  local title = map_special_names(lead) .. ' Hints'
  max_len = math.min(math.max(max_len, #title), max_width)
  HintWindow = vim.api.nvim_open_win(hint_buf, false, {
    relative = 'editor',
    anchor = 'SE',
    width = max_len,
    height = #keymap_table,
    -- focusable = false,
    focusable = true,
    style = 'minimal',
    border = 'single',
    title = title,
    title_pos = 'left',
    row = ui.height - 2,
    col = ui.width,
  })
end

local hintleader = 'f'

SpecialNames = { [" "] = '<Space>' }
local hint_keys = { vim.g.mapleader, 't', hintleader, '<F1>' }

vim.keymap.set('n', hintleader .. '/', function()
  if HintWindow then
    vim.api.nvim_win_close(HintWindow, false)
    HintWindow = nil
  end
end, { desc = 'Clear hint text' })

---Add a key to get hints for
---@param key string
function AddHintKey(key)
  vim.keymap.set('n', hintleader .. key, function()
    CreateWindow(key)
  end, { desc = 'Hints for ' .. key .. ' key'})

end

for _, key in ipairs(hint_keys) do
  AddHintKey(key)
end

vim.api.nvim_create_user_command("Hint", function (value)
  all_keymaps_starting_with(value.fargs[1]):map(function (val)
    print("'"..val.lhs.."'   "..tostring(val.desc))
  end)
end, {desc = "Show description of keymap", nargs = 1, complete = function (argLead,_,_)
  return all_keymaps_starting_with(argLead):totable() 
end })
