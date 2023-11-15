local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
	return
end

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neotree.setup({
	close_if_last_window = true,

	git_status = {
		symbols = {
			unstaged = "",
			staged = "S",
			unmerged = "",
			renamed = "➜",
			deleted = "",
			untracked = "U",
			ignored = "◌",
		},
	},
	window = {
		position = "left",
		mappings = {
			["h"] = "close_node",
			["l"] = "open",
		},
	},
	-- event_handlers = {
	--
	-- 	{
	-- 		event = "file_opened",
	-- 		handler = function(file_path)
	-- 			--auto close
	-- 			neotree.close_all()
	-- 		end,
	-- 	},
	-- },
})
