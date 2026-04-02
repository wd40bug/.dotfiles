-- Bedtime Enforcer
local function enforce_bedtime()
    local current_hour = tonumber(os.date("%H"))
    
    -- Check if the time is between 00:00 (Midnight) and 05:00 AM
    if current_hour >= 0 and current_hour < 6 then
        -- Save all buffers so you don't lose your school project progress
        vim.cmd("wall") 
        
        -- Force quit Neovim
        vim.cmd("qa!") 
    end
end

-- 1. Check immediately on startup (prevents you from opening it past midnight)
vim.api.nvim_create_autocmd("VimEnter", {
    callback = enforce_bedtime,
})

-- 2. Create a background timer to check the time every minute (60000 ms)
local timer = vim.uv.new_timer() -- Note: Use vim.loop.new_timer() if on Neovim < 0.10
timer:start(0, 60000, vim.schedule_wrap(enforce_bedtime))
