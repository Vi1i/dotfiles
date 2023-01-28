local config = {
    -- set vim options here (vim.<first_key>.<second_key> = value)
    options = {
        opt = {
            -- set to true or false etc.
            relativenumber = true, -- sets vim.opt.relativenumber
            number = true, -- sets vim.opt.number
            spell = false, -- sets vim.opt.spell
            signcolumn = "auto", -- sets vim.opt.signcolumn to auto
            wrap = false, -- sets vim.opt.wrap
            tabstop = 2,
            shiftwidth = 2,
            softtabstop = 2,
            expandtab = true,
        },
        bo = {
            softtabstop = 2,
        },
        g = {
            mapleader = " ", -- sets vim.g.mapleader
            autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
            cmp_enabled = true, -- enable completion at start
            autopairs_enabled = true, -- enable autopairs at start
            diagnostics_enabled = true, -- enable diagnostics at start
            status_diagnostics_enabled = true, -- enable diagnostics in statusline
            icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
            ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        },
    },

    header = {
        "▓██   ██▓ ▄▄▄██▀▀▀▒█████   ██▀███   ███▄    █ ",
        " ▒██  ██▒   ▒██  ▒██▒  ██▒▓██ ▒ ██▒ ██ ▀█   █ ",
        "  ▒██ ██░   ░██  ▒██░  ██▒▓██ ░▄█ ▒▓██  ▀█ ██▒",
        "  ░ ▐██▓░▓██▄██▓ ▒██   ██░▒██▀▀█▄  ▓██▒  ▐▌██▒",
        "  ░ ██▒▓░ ▓███▒  ░ ████▓▒░░██▓ ▒██▒▒██░   ▓██░",
        "   ██▒▒▒  ▒▓▒▒░  ░ ▒░▒░▒░ ░ ▒▓ ░▒▓░░ ▒░   ▒ ▒ ",
        " ▓██ ░▒░  ▒ ░▒░    ░ ▒ ▒░   ░▒ ░ ▒░░ ░░   ░ ▒░",
        " ▒ ▒ ░░   ░ ░ ░  ░ ░ ░ ▒    ░░   ░    ░   ░ ░ ",
        " ░ ░      ░   ░      ░ ░     ░              ░ ",
        " ░ ░                                          ",
        "       ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓      ",
        "       ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒      ",
        "      ▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░      ",
        "      ▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██       ",
        "      ▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒      ",
        "      ░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░      ",
        "      ░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░      ",
        "         ░   ░ ░     ░░   ▒ ░░      ░         ",
        "               ░      ░   ░         ░         ",
        "                     ░                        ",
    },

    lsp = {
        servers = {
            "pyright",
        },
        ["server-settings"] = {
            pyright = {
                single_filesupport = false,
            },
        },
    },

    plugins = {
        ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
            local null_ls = require "null-ls"
            config.sources = {
                null_ls.builtins.formatting.isort,
                null_ls.builtins.diagnostics.pylint,
            }
            return config -- return final config table
        end,
    },

    -- Default theme configuration
    default_theme = {
        plugins = {
            aerial = true,
            beacon = false,
            bufferline = true,
            cmp = true,
            dashboard = true,
            highlighturl = true,
            hop = false,
            indent_blankline = true,
            lightspeed = false,
            ["neo-tree"] = true,
            notify = false,
            ["nvim-tree"] = false,
            ["nvim-web-devicons"] = true,
            rainbow = true,
            symbols_outline = false,
            telescope = true,
            treesitter = true,
            vimwiki = false,
            ["which-key"] = true,
        },
    },
}

return config
