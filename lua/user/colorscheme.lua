local colorscheme = "monokai_pro"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found")
else
    -- fix italic issues of windows terminal
    vim.cmd[[
        hi Identifier gui=NONE
        hi Type gui=None
    ]]
end

