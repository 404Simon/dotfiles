local M = {}

M.terminal_bufnr = nil
M.terminal_job_id = nil
M.terminal_ready = false

-- Close the existing terminal if it's running.
function M.close_terminal()
  if M.terminal_bufnr and vim.api.nvim_buf_is_valid(M.terminal_bufnr) then
    vim.api.nvim_buf_delete(M.terminal_bufnr, { force = true })
  end
  M.terminal_bufnr = nil
  M.terminal_job_id = nil
  M.terminal_ready = false
end

-- Start the terminal running "php artisan tinker"
function M.start_terminal()
  M.close_terminal() -- Ensure no old instance is running

  -- Open a horizontal split for the terminal.
  vim.cmd 'botright 15split | terminal php artisan tinker'
  M.terminal_bufnr = vim.api.nvim_get_current_buf()
  M.terminal_job_id = vim.b.terminal_job_id

  -- Check if the shell started correctly.
  vim.defer_fn(function()
    if not vim.api.nvim_buf_is_valid(M.terminal_bufnr) then
      return
    end
    local lines = vim.api.nvim_buf_get_lines(M.terminal_bufnr, 0, -1, false)
    local content = table.concat(lines, '\n')
    if content:match 'Psy Shell' or content:match 'php artisan tinker' then
      M.terminal_ready = true
    else
      M.close_terminal()
      print 'Error: Artisan Tinker shell did not start correctly.'
    end
  end, 1000)

  vim.cmd 'startinsert'
end

-- Open a scratchpad for writing Artisan Tinker commands.
function M.open_scratchpad()
  -- Start the terminal if it's not already running.
  M.start_terminal()

  -- Open a vertical split with a new empty buffer for the scratchpad.
  vim.cmd 'vnew'
  local bufnr = vim.api.nvim_get_current_buf()

  -- Configure the scratchpad buffer.
  vim.bo.bufhidden = 'wipe'
  vim.bo.buftype = 'nofile'
  vim.bo.filetype = 'php'

  -- Map <Leader>w to send the current line.
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>w', ":lua require('artisan_tinker').send_command()<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<Leader>w', "<Esc>:lua require('artisan_tinker').send_command()<CR>", { noremap = true, silent = true })

  -- Map <Leader>r to restart the Tinker shell.
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>r', ":lua require('artisan_tinker').restart_tinker()<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<Leader>r', "<Esc>:lua require('artisan_tinker').restart_tinker()<CR>", { noremap = true, silent = true })

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

-- Restart the Tinker shell.
function M.restart_tinker()
  M.start_terminal()
  print 'Tinker shell restarted.'
end

-- Setup Neovim command.
function M.setup()
  vim.cmd "command! ArtisanTinker lua require('artisan_tinker').open_scratchpad()"
end

return M
