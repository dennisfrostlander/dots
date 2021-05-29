local ts_config = require("nvim-treesitter.configs")

ts_config.setup {
    ensure_installed = {
        "typescript",
        "javascript",
        "html",
        "css",
        "bash",
        "cpp",
        "rust",
        "lua"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    }
}
