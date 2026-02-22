return {
    "rasulomaroff/reactive.nvim",
    config = function()
        local reactive = require("reactive")

        reactive.add_preset({
            name = "tokyonight",
            modes = {
                n = {
                    winhl = {
                        CursorLineNr = { fg = "#7aa2f7", bold = true },
                    },
                },
                no = {
                    operators = {
                        d = {
                            winhl = {
                                CursorLineNr = { fg = "#f7768e", bold = true },
                            },
                        },
                        y = {
                            winhl = {
                                CursorLineNr = { fg = "#e0af68", bold = true },
                            },
                        },
                        c = {
                            winhl = {
                                CursorLineNr = { fg = "#7dcfff", bold = true },
                            },
                        },
                    },
                    winhl = {
                        CursorLineNr = { fg = "#ff9e64", bold = true },
                    },
                },
                i = {
                    winhl = {
                        CursorLineNr = { fg = "#9ece6a", bold = true },
                    },
                },
                [{ "v", "V", "\x16" }] = {
                    winhl = {
                        CursorLineNr = { fg = "#bb9af7", bold = true },
                    },
                },
                R = {
                    winhl = {
                        CursorLineNr = { fg = "#f7768e", bold = true },
                    },
                },
                c = {
                    winhl = {
                        CursorLineNr = { fg = "#ff9e64", bold = true },
                    },
                },
            },
        })

        reactive.add_preset({
            name = "rosepine",
            lazy = true,
            modes = {
                n = {
                    winhl = {
                        CursorLineNr = { fg = "#c4a7e7", bold = true },
                    },
                },
                no = {
                    operators = {
                        d = {
                            winhl = {
                                CursorLineNr = { fg = "#eb6f92", bold = true },
                            },
                        },
                        y = {
                            winhl = {
                                CursorLineNr = { fg = "#f6c177", bold = true },
                            },
                        },
                        c = {
                            winhl = {
                                CursorLineNr = { fg = "#9ccfd8", bold = true },
                            },
                        },
                    },
                    winhl = {
                        CursorLineNr = { fg = "#f6c177", bold = true },
                    },
                },
                i = {
                    winhl = {
                        CursorLineNr = { fg = "#9ccfd8", bold = true },
                    },
                },
                [{ "v", "V", "\x16" }] = {
                    winhl = {
                        CursorLineNr = { fg = "#ea9a97", bold = true },
                    },
                },
                R = {
                    winhl = {
                        CursorLineNr = { fg = "#eb6f92", bold = true },
                    },
                },
                c = {
                    winhl = {
                        CursorLineNr = { fg = "#f6c177", bold = true },
                    },
                },
            },
        })

        reactive.setup({})
    end,
}
