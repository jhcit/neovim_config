vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    
    -- These commands will now work perfectly across ALL your programming languages
    vim.api.nvim_buf_create_user_command(bufnr, 'Err', vim.diagnostic.open_float, {})
    vim.api.nvim_buf_create_user_command(bufnr, 'Fix', vim.lsp.buf.code_action, {})
    vim.api.nvim_buf_create_user_command(bufnr, 'Doc', vim.lsp.buf.hover, {})
    vim.api.nvim_buf_create_user_command(bufnr, 'Ren', vim.lsp.buf.rename, {})
  end,
})

