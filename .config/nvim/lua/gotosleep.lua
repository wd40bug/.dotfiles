---@type integer?
local sleep_window_handle
local keep_sleep_window_handle

---@type vim.SystemObj
local sleep_timer_handle
---@type vim.SystemObj
local keep_timer_handle

Strict = true
SleepTime = '23:55'
WakeTime = '00:05'
sleep_time = SleepTime -- local, since sleep_time is changed locally

vim.api.nvim_set_hl(0, 'SleepWindowButton', { bg = 'white', fg = 'green' })

function sleep_window()
  local sleep_buf = vim.api.nvim_create_buf(false, true)
  local ui = vim.api.nvim_list_uis()[1]

  local width = 50
  local height = 10

  if sleep_window_handle then
    vim.api.nvim_win_close(sleep_window_handle, false)
    sleep_window_handle = nil
  end

  vim.api.nvim_buf_set_lines(sleep_buf, 2, 8, false,
    {
      -- TODO: There are some bugs with the lua-language-server and versioning
      -- this luaJIT version doesn't support table.unpack, but no warning
      -- doumentation links to 5.4 regardless of version
      'Your go to sleep timer has gone off!',
      "It's past " .. sleep_time .. ', go to sleep!',
      '', '',
      'GIVE ME MORE TIME           EXIT NVIM'
    })

  local buf_ns = vim.api.nvim_create_namespace('SleepExtmakrs')
  local more_time_id = vim.api.nvim_buf_set_extmark(sleep_buf, buf_ns, 5, 0, {
    end_col = 17,
    hl_group = 'SleepWindowButton'
  })
  local exit_id = vim.api.nvim_buf_set_extmark(sleep_buf, buf_ns, 5, 28, {
    end_col = 37,
    hl_group = 'SleepWindowButton'
  })

  sleep_window_handle = vim.api.nvim_open_win(sleep_buf, true, {
    relative = 'editor',
    anchor = 'NW',
    width = width,
    height = height,
    focusable = true,
    style = 'minimal',
    border = 'single',
    title = 'GO TO SLEEP!',
    title_pos = 'center',
    row = (ui.height - height) / 2,
    col = (ui.width - width) / 2
  })

  vim.api.nvim_set_current_win(sleep_window_handle)
  vim.cmd.center({ range = { 2, 6 }, args = { width } })

  vim.keymap.set('n', '<CR>', function()
    if vim.fn.win_getid() ~= sleep_window_handle then
      return
    end
    local cp_y, cp_x = unpack(vim.api.nvim_win_get_cursor(sleep_window_handle))
    print(cp_x, cp_y)

    local more_ext = vim.api.nvim_buf_get_extmark_by_id(sleep_buf, buf_ns, more_time_id, { details = true })
    local more_y = more_ext[1]
    local more_1 = more_ext[2]
    local more_2 = more_ext[3].end_col

    local exit_ext = vim.api.nvim_buf_get_extmark_by_id(sleep_buf, buf_ns, exit_id, { details = true })
    local exit_y = exit_ext[1]
    local exit_1 = exit_ext[2]
    local exit_2 = exit_ext[3].end_col

    if cp_y ~= more_y + 1 or more_y ~= exit_y then
      return
    elseif cp_x > more_1 and cp_x < more_2 then
      vim.api.nvim_win_close(sleep_window_handle, false)
      sleep_window_handle = nil
      local default = 5
      vim.ui.input({ prompt = 'How much more time(in minutes?)' }, function(val)
        val = tonumber(val)
        if val == nil then
          val = default
        end
        sleep_time = add_time(val)
        create_sleep_window_callback(Strict)
        print('Ok, giving you ' ..
          val .. ' more minutes.' .. (Strict and ' Once the time is up, neovim WILL close without saving[Strict]' or ''))
      end)
    elseif cp_x > exit_1 and cp_x < exit_2 then
      vim.cmd('qa!') --EXIT
    else
      return
    end
  end, { desc = 'Select ui element in SleepWindow' })

  vim.api.nvim_set_option_value('modifiable', false, { buf = sleep_buf })

  vim.api.nvim_create_autocmd({ 'WinClosed' }, {
    pattern = tostring(sleep_window_handle),
    desc = 'Invalidate sleep_window_handle on WinClosed',
    callback = function(opts)
      if tonumber(opts.file) == sleep_window_handle then
        sleep_window_handle = nil
        return true -- Delete this autocommand
      end

      return false
    end,

  })
end -- TODO: Display function name at end of functions?

---Exit neovim with :qa!
---Own function so I can come back later and change it if necessary
local function exit_nvim()
  vim.cmd('qa!')
end

function keep_sleep_window()
  local keep_sleep_buf = vim.api.nvim_create_buf(false, true)
  local ui = vim.api.nvim_list_uis()[1]

  local width = 50
  local height = 10

  if keep_sleep_window_handle then
    vim.api.nvim_win_close(keep_sleep_window_handle, false)
    sleep_window_handle = nil
  end

  vim.api.nvim_buf_set_lines(keep_sleep_buf, 5, 9, false,
    { "It's time to sleep", 'you can code again at ' .. WakeTime, '', 'Closing NVIM' })
  keep_sleep_window_handle = vim.api.nvim_open_win(keep_sleep_buf, false, {
    relative = 'editor',
    anchor = 'NW',
    width = width,
    height = height,
    focusable = false,
    style = 'minimal',
    border = 'single',
    title = 'TIME TO SLEEP',
    title_pos = 'center',
    row = (ui.height - height) / 2,
    col = (ui.width - width) / 2
  })

  vim.api.nvim_set_current_win(keep_sleep_window_handle)
  vim.cmd.center({ range = { 2, 5 }, args = { width } })

  vim.api.nvim_set_option_value('modifiable', false, { buf = keep_sleep_buf })
  keep_timer_handle = sleep_then(15, exit_nvim)
end

---Returns the time difference in seconds between now and the time given
---@param time string
---@param tomorrow boolean?
---@return integer
function time_diff_from_now(time, tomorrow)
  -- Weird bug here, function `uv.clock_gettime` is unrecognized maybe figure it out later
  -- TODO: Make work on windows
  ---@diagnostic disable-next-line: undefined-field
  local now = vim.uv.clock_gettime('realtime').sec
  if tomorrow then
    time = 'tomorrow ' .. time
  end
  local fut = vim.system { 'date', '--date=' .. time, '+%s' }:wait().stdout
  local diff = fut - now
  return diff
end

--These are separated into functions for cross-compatability later

---Returns a string representing addition plus the current time
---HH:MM
---@param addition integer time in minutes
---@return string?
function add_time(addition)
  return vim.system({ 'date', '--date=+' .. addition .. ' minutes', '+%H:%M' }):wait().stdout
end

---Execute function after a set amount of time
---@param time integer time to sleep in seconds
---@param fn fun() function to run after sleep
---@return vim.SystemObj
local function sleep_then(time, fn)
  return vim.system({ 'sleep', tostring(time) }, {}, function(out)
    if out.signal == 0 then
      vim.schedule(fn)
    end
  end)
end

function create_sleep_window_callback(strict)
  local diff_sleep = time_diff_from_now(sleep_time)

  if diff_sleep < 0 then -- If sleep time is negative, set the timer for tomorrows sleep_time
    diff_sleep = time_diff_from_now(sleep_time, true)
  end

  sleep_timer_handle = sleep_then(diff_sleep, function()
    if strict then
      exit_nvim()
    else
      print('SLEEP_CALLBACK')
      sleep_window()
    end
  end)
end

-- When it starts, don't start Strict, b/c that will close without a warning
create_sleep_window_callback()

local diff_sleep = time_diff_from_now(sleep_time)
local diff_wake = time_diff_from_now(WakeTime)

if diff_wake < diff_sleep then
  --This checks if the day change 00:00 lies in the middle of the sleep period,
  --b/c that reqires a different calculation
  if diff_sleep < 0 or diff_wake > 0 then
    -- In sleep period
    keep_sleep_window()
  end
elseif diff_sleep < 0 and diff_wake > 0 then
  keep_sleep_window()
end

vim.api.nvim_create_user_command('SleepExitCancel', function()
  if sleep_timer_handle then
    sleep_timer_handle:kill('sigint')
    sleep_time = SleepTime
    print("Canceled the exit")
  end

end, {})

vim.api.nvim_create_user_command('KeepExitCancel', function()
  if keep_timer_handle then
    keep_timer_handle:kill('sigint')
    print("Cancelled the exit")
  end

end, {})
