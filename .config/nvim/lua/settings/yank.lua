-- TODO: Need a way to know if clip.exe is on the system
-- WSL Yank Support
-- vim.api.nvim_exec([[
-- let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
-- if executable(s:clip)
--     augroup WSLYank
--         autocmd!
--         autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
--     augroup END
-- endif
-- ]], true)
--
--
-- set clipboard+=unnamedplus
--
--
vim.api.nvim_exec(
[[
set clipboard+=unnamedplus
]], true)
