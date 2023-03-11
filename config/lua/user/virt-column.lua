local status_ok, configs = pcall(require, "virt-column")
if not status_ok then
	return
end

-- Debounce fixes this being overwritten by something..
vim.schedule(function()
    configs.setup({char = "║"})
end)
