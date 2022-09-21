--LANGUAGE SERVER SETTINGS

local rtp = vim.split(package.path, ';')
table.insert(rtp, 'lua/?.lua')
table.insert(rtp, 'lua/?/init.lua')

_G.TabCompletion = function()
    local substr = vim.fn.strpart(vim.fn.getline('.'), -1, vim.fn.col('.')+1)
    local matched = vim.fn.matchstr(substr, "[^ \t]*$")
    if vim.fn.strlen(matched) == 0 or vim.fn.col('.') == 1 then
        return t'<tab>'
    else
        return t'<C-X><C-O>'
    end
end
imap('<tab>', '<c-r>=v:lua.TabCompletion()<CR>',{noremap = true, silent = true})

-- java setup
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/home/nico/workspace/' .. project_name
require('lspconfig').jdtls.setup {
    on_attach = on_attach,
    single_file_support = true,
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-noverify',
        '-Xmx1G',
        '-jar', os.getenv("JDTLS_HOME")..'/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', os.getenv("JDTLS_HOME") ..'/config_linux',
        '-data', vim.fn.expand('~/.cache/jdtls-workspace')..workspace_dir
    },
}

