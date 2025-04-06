local M = {}

-- Module state.
M.terminal_bufnr = nil
M.terminal_job_id = nil
M.terminal_win = nil
M.terminal_ready = false

-- Helper: Check if a buffer is valid.
local function is_buf_valid(bufnr)
  return bufnr and vim.api.nvim_buf_is_valid(bufnr)
end

-- Helper: Check if a window is valid.
local function is_win_valid(winid)
  return winid and vim.api.nvim_win_is_valid(winid)
end

-- Local helper to check the shell's startup after a delay.
local function check_shell()
  if not is_buf_valid(M.terminal_bufnr) then
    return
  end
  local lines = vim.api.nvim_buf_get_lines(M.terminal_bufnr, 0, -1, false)
  local content = table.concat(lines, '\n')
  if content:match 'Psy Shell' or content:match 'php artisan tinker' then
    M.terminal_ready = true
  else
    M.terminal_ready = false
    print 'Error: Artisan Tinker shell did not start correctly.'
  end
end

-- Close and reset the terminal.
function M.close_terminal()
  if is_buf_valid(M.terminal_bufnr) then
    vim.api.nvim_buf_delete(M.terminal_bufnr, { force = true })
  end
  M.terminal_bufnr = nil
  M.terminal_job_id = nil
  M.terminal_ready = false
  M.terminal_win = nil
end

-- Start the terminal running "php artisan tinker" in a bottom split.
-- This is used when opening the scratchpad for the first time.
function M.start_terminal_initial()
  vim.cmd 'botright 15split | terminal php artisan tinker'
  M.terminal_bufnr = vim.api.nvim_get_current_buf()
  M.terminal_job_id = vim.b.terminal_job_id
  M.terminal_win = vim.api.nvim_get_current_win()
  M.terminal_ready = false

  vim.defer_fn(check_shell, 1000)
  vim.cmd 'startinsert'
end

-- Restart the Tinker shell without affecting your scratchpad.
-- It reuses the stored terminal window, then returns focus to your scratchpad.
function M.restart_tinker()
  local scratch_win = vim.api.nvim_get_current_win() -- store current window (scratchpad)
  if not is_win_valid(M.terminal_win) then
    -- If for some reason the terminal window is gone, recreate it.
    M.start_terminal_initial()
    return
  end

  vim.api.nvim_win_call(M.terminal_win, function()
    if is_buf_valid(M.terminal_bufnr) then
      vim.cmd('bdelete! ' .. M.terminal_bufnr)
    end
    vim.cmd 'terminal php artisan tinker'
    M.terminal_bufnr = vim.api.nvim_get_current_buf()
    M.terminal_job_id = vim.b.terminal_job_id
    M.terminal_ready = false
    vim.cmd 'startinsert'
  end)
  vim.defer_fn(check_shell, 1000)
  vim.api.nvim_set_current_win(scratch_win) -- restore focus to scratchpad

  print 'Tinker shell restarted.'
end

-- Helper: Map key in a buffer.
local function map_buf_key(bufnr, mode, key, command)
  vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, { noremap = true, silent = true })
end

-- Open a scratchpad for writing Artisan Tinker commands.
function M.open_scratchpad()
  if not is_buf_valid(M.terminal_bufnr) then
    M.start_terminal_initial()
  end

  -- Open a new vertical split for the scratchpad.
  vim.cmd 'vnew'
  local bufnr = vim.api.nvim_get_current_buf()

  -- Configure the scratchpad buffer.
  -- Changed from "wipe" to "hide" so the buffer persists.
  vim.bo[bufnr].bufhidden = 'hide'
  vim.bo[bufnr].buftype = 'nofile'
  vim.bo[bufnr].filetype = 'php'

  -- Map keys for sending commands and restarting the terminal.
  map_buf_key(bufnr, 'n', '<Leader>w', ":lua require('artisan_tinker').send_command()<CR>")
  map_buf_key(bufnr, 'i', '<Leader>w', "<Esc>:lua require('artisan_tinker').send_command()<CR>")
  map_buf_key(bufnr, 'n', '<Leader>r', ":lua require('artisan_tinker').restart_tinker()<CR>")
  map_buf_key(bufnr, 'i', '<Leader>r', "<Esc>:lua require('artisan_tinker').restart_tinker()<CR>")

  print 'Scratchpad opened. Use <Leader>w to send a line. Use <Leader>r to restart the shell.'
end

-- Sends the command from the current line to the terminal.
function M.send_command()
  local line = vim.api.nvim_get_current_line()
  local cleaned_line = line:gsub('^%s*>%s*', '')
  if cleaned_line == '' then
    print 'No command on the current line!'
    return
  end

  if not (M.terminal_job_id and M.terminal_ready) then
    print 'Terminal not ready. Please wait for initialization.'
    return
  end

  vim.fn.chansend(M.terminal_job_id, cleaned_line .. '\n')
  print('Sent command: ' .. cleaned_line)
end

-- Setup Neovim command.
function M.setup()
  vim.cmd "command! ArtisanTinker lua require('artisan_tinker').open_scratchpad()"
end

return M
