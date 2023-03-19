local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
--local gps = require("nvim-gps")

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

local winbar_components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local colors = {
  bg = '#282828',
  black = '#282828',
  yellow = '#d8a657',
  cyan = '#89b482',
  oceanblue = '#45707a',
  green = '#a9b665',
  orange = '#e78a4e',
  violet = '#d3869b',
  magenta = '#c14a4a',
  white = '#a89984',
  fg = '#a89984',
  skyblue = '#7daea3',
  red = '#ea6962',
}

local vi_mode_colors = {
  NORMAL = 'green',
  OP = 'green',
  INSERT = 'red',
  CONFIRM = 'red',
  VISUAL = 'skyblue',
  LINES = 'skyblue',
  BLOCK = 'skyblue',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'green',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

force_inactive.buftypes = {
  'terminal'
}


-- vi-mode
-- components.active[1][1] = {
--   provider = ' NV-IDE ',
--   hl = function()
--     local val = {}
--
--     val.bg = vi_mode_utils.get_mode_color()
--     val.fg = 'black'
--     val.style = 'bold'
--
--     return val
--   end,
--   right_sep = ' '
-- }

-- vi-symbol
-- components.active[1][2] = {
--   provider = function()
--     return vi_mode_text[vi_mode_utils.get_vim_mode()]
--   end,
--   hl = function()
--     local val = {}
--     val.fg = vi_mode_utils.get_mode_color()
--     val.bg = 'bg'
--     val.style = 'bold'
--     return val
--   end,
--   right_sep = ' '
-- }

local vi_mode_text = {
    n       = "NORMAL",
    i       = "INSERT",
    v       = "VISUAL",
    ['']  = "V-BLOCK",
    V       =	"V-LINE",
    c       =	"COMMAND",
    no      =	"UNKNOWN",
    s       =	"UNKNOWN",
    S		    =	"UNKNOWN",
    ic			=	"UNKNOWN",
    R			  =	"REPLACE",
    Rv			=	"UNKNOWN",
    cv			=	"UNKWON",
    ce			=	"UNKNOWN",
    r			  =	"REPLACE",
    rm			=	"UNKNOWN",
    t			  =	"INSERT"
}

-- common components
-- git stuff

-- diffAdd
local common_gitdiff_add = {
  provider = 'git_diff_added',
  hl = {
    fg = 'green',
    bg = 'bg',
    style = 'bold'
  }
}

-- diffModfified
local common_gitdiff_changed = {
  provider = 'git_diff_changed',
  hl = {
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
}

-- diffRemove
local common_gitdiff_removed = {
  provider = 'git_diff_removed',
  hl = {
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  },
}

-- file stuff

-- icon
local common_fileinfo_icon = {
  provider = function()
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon == nil then
      icon = ''
    end
    return icon
  end,
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}

local common_fileinfo_type = {
  provider = 'file_type',
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}

-- ACTIVE

-- left

table.insert(components.active[1], {
    provider = function()
      local current_text = ' '..vi_mode_text[vim.fn.mode()]..' '
      return current_text
    end,
    priority = 2,
    hl = function()
        local val = {
            name = vi_mode_utils.get_mode_highlight_name(),
            fg = colors.bg,
            bg = vi_mode_utils.get_mode_color(),
            style = 'bold'
        }
        return val
    end,
   rep_sep = ' '
})

-- table.insert(components.active[1], {
--     provider = 'file_info',
--     hl = {
--       fg = colors.skyblue,
--       style = 'bold'
--     }
-- })

--filename
table.insert(components.active[1], {
  provider = function()
    return vim.fn.expand("%:F")
  end,
  priority = 2,
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  left_sep=' ',
  right_sep=' ',
})

-- MID

-- gitBranch
table.insert(components.active[2], {
  provider = 'git_branch',
  priority = 0,
  truncate_hide = true,
  hl = {
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  }
})

-- diffAdd
table.insert(components.active[2], common_gitdiff_add)

-- diffModfified
table.insert(components.active[2], common_gitdiff_changed)

-- diffRemove
table.insert(components.active[2], common_gitdiff_removed)

-- RIGHT

-- fileIcon
table.insert(components.active[3], common_fileinfo_icon)
-- fileType
table.insert(components.active[3], common_fileinfo_type)
-- fileSize
components.active[3][3] = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- fileFormat
components.active[3][4] = {
  provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- fileEncode
components.active[3][5] = {
  provider = 'file_encoding',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
components.active[3][6] = {
  provider = 'position',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- linePercent
components.active[3][7] = {
  provider = 'line_percentage',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- scrollBar
components.active[3][8] = {
  provider = 'scroll_bar',
  hl = {
    fg = 'yellow',
    bg = 'bg',
  },
}

-- INACTIVE

-- left
-- filename
table.insert(components.inactive[1], {
  provider = function()
    return vim.fn.expand("%:F")
  end,
  hl = {
    fg = 'oceanblue',
    bg = 'bg',
    style = 'bold'
  },
  left_sep = ' '
})

-- mid

-- diffAdd
table.insert(components.inactive[2], common_gitdiff_add)

-- diffModfified
table.insert(components.inactive[2], common_gitdiff_changed)

-- diffRemove
table.insert(components.inactive[2], common_gitdiff_removed)

-- right
-- fileIcon
table.insert(components.inactive[3], common_fileinfo_icon)
-- fileType
table.insert(components.inactive[3], common_fileinfo_type)

local options = {
  theme = colors,
  default_bg = bg,
  default_fg = fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
}

return options


-- local lsp = require 'feline.providers.lsp'
-- local vi_mode_utils = require 'feline.providers.vi_mode'
-- local cursor = require 'feline.providers.cursor'
-- --local gps = require("nvim-gps")
--
--
--
-- -- REFERENCES: 
-- -- https://github.com/6cdh/dotfiles/blob/62959d27344dade28d6dd638252cd82accb309ab/nvim/.config/nvim/lua/statusline.lua
--
-- local force_inactive = {
--   filetypes = {},
--   buftypes = {},
--   bufnames = {}
-- }
--
-- local winbar_components = {
--   active = {{}, {}, {}},
--   inactive = {{}, {}, {}},
-- }
--
-- local components = {
--   active = {{}, {}, {}},
--   inactive = {{}, {}, {}},
-- }
--
-- local colors = {
--   bg = '#282828',
--   black = '#282828',
--   yellow = '#d8a657',
--   cyan = '#89b482',
--   oceanblue = '#45707a',
--   green = '#a9b665',
--   orange = '#e78a4e',
--   violet = '#d3869b',
--   magenta = '#c14a4a',
--   white = '#a89984',
--   fg = '#a89984',
--   skyblue = '#7daea3',
--   red = '#ea6962',
-- }
--
-- local vi_mode_colors = {
--   NORMAL = 'green',
--   OP = 'green',
--   INSERT = 'red',
--   CONFIRM = 'red',
--   VISUAL = 'skyblue',
--   LINES = 'skyblue',
--   BLOCK = 'skyblue',
--   REPLACE = 'violet',
--   ['V-REPLACE'] = 'violet',
--   ENTER = 'cyan',
--   MORE = 'cyan',
--   SELECT = 'orange',
--   COMMAND = 'green',
--   SHELL = 'green',
--   TERM = 'green',
--   NONE = 'yellow'
-- }
--
-- --local vi_mode_text = {
-- --  NORMAL = 'NORMAL',
-- --  OP = 'OP',
-- --  INSERT = 'INSERT',
-- --  VISUAL = 'VISUAL',
-- --  LINES = 'V-LINE',
-- --  BLOCK = 'V-BLOCK',
-- --  REPLACE = 'REPLACE',
-- --  ['V-REPLACE'] = 'V-REPLACE',
-- --  ENTER = 'ENTER',
-- --  MORE = 'ENTER',
-- --  SELECT = 'SELECT',
-- --  COMMAND = 'COMMAND',
-- --  SHELL = 'SHELL',
-- --  TERM = 'TERM',
-- --  NONE = 'NONE',
-- --  CONFIRM = 'CONFIRM'
-- --}
--
-- local vi_mode_text = {
--     n = "NORMAL",
--     i = "INSERT",
--     v = "VISUAL",
--     ['']= "V-BLOCK",
--     V = "V-LINE",
--     c = "COMMAND",
--     no = "UNKNOWN",
--     s = "UNKNOWN",
--     S = "UNKNOWN",
--     ic = "UNKNOWN",
--     R = "REPLACE",
--     Rv = "UNKNOWN",
--     cv = "UNKWON",
--     ce = "UNKNOWN",
--     r = "REPLACE",
--     rm = "UNKNOWN",
--     t = "INSERT"
-- }
--
-- -- ACTIVE STATUS LINES
-- -- vi-mode
-- table.insert(components.active[1], {
--     provider = function()
--       local current_text = ' '..vi_mode_text[vim.fn.mode()]..' '
--       return current_text
--     end,
--     hl = function()
--         local val = {
--             name = vi_mode_utils.get_mode_highlight_name(),
--             fg = colors.bg,
--             bg = vi_mode_utils.get_mode_color(),
--             style = 'bold'
--         }
--         return val
--     end
-- --    rep_sep = ' '
-- })
--
-- -- filename
-- table.insert(components.active[1], {
--     provider = 'file_info',
--     hl = {
--       fg = colors.skyblue,
--       style = 'bold'
--     }
-- })
--
-- -- INACTIVE STATUS LINES
-- table.insert(components.inactive[1], {
--     provider = 'file_info',
--     hl = {
--       fg = colors.oceanblue,
--       style = 'bold'
--     }
-- })
--
-- -- STATUSLINE
-- -- LEFT
--
-- -- vi-mode
-- -- components.active[1][1] = {
-- --   provider = ' NV-IDE ',
-- --   hl = function()
-- --     local val = {}
-- -- 
-- --     val.bg = vi_mode_utils.get_mode_color()
-- --     val.fg = 'black'
-- --     val.style = 'bold'
-- -- 
-- --     return val
-- --   end,
-- --   right_sep = ' '
-- -- }
-- -- 
-- -- -- vi-symbol
-- -- components.active[1][2] = {
-- --   provider = function()
-- --     return vi_mode_text[vi_mode_utils.get_vim_mode()]
-- --   end,
-- --   hl = function()
-- --     local val = {}
-- --     val.fg = vi_mode_utils.get_mode_color()
-- --     val.bg = 'bg'
-- --     val.style = 'bold'
-- --     return val
-- --   end,
-- --   right_sep = ' '
-- -- }
-- -- -- filename
-- -- components.active[1][3] = {
-- --   provider = function()
-- --     return vim.fn.expand("%:F")
-- --   end,
-- --   hl = {
-- --     fg = 'white',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- -- MID
-- -- 
-- -- -- gitBranch
-- -- components.active[2][1] = {
-- --   provider = 'git_branch',
-- --   hl = {
-- --     fg = 'yellow',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- -- diffAdd
-- -- components.active[2][2] = {
-- --   provider = 'git_diff_added',
-- --   hl = {
-- --     fg = 'green',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- -- diffModfified
-- -- components.active[2][3] = {
-- --   provider = 'git_diff_changed',
-- --   hl = {
-- --     fg = 'orange',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- -- diffRemove
-- -- components.active[2][4] = {
-- --   provider = 'git_diff_removed',
-- --   hl = {
-- --     fg = 'red',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   },
-- -- }
-- -- 
-- -- -- RIGHT
-- -- 
-- -- -- fileIcon
-- -- components.active[3][1] = {
-- --   provider = function()
-- --     local filename = vim.fn.expand('%:t')
-- --     local extension = vim.fn.expand('%:e')
-- --     local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
-- --     if icon == nil then
-- --       icon = ''
-- --     end
-- --     return icon
-- --   end,
-- --   hl = function()
-- --     local val = {}
-- --     local filename = vim.fn.expand('%:t')
-- --     local extension = vim.fn.expand('%:e')
-- --     local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
-- --     if icon ~= nil then
-- --       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
-- --     else
-- --       val.fg = 'white'
-- --     end
-- --     val.bg = 'bg'
-- --     val.style = 'bold'
-- --     return val
-- --   end,
-- --   right_sep = ' '
-- -- }
-- -- -- fileType
-- -- components.active[3][2] = {
-- --   provider = 'file_type',
-- --   hl = function()
-- --     local val = {}
-- --     local filename = vim.fn.expand('%:t')
-- --     local extension = vim.fn.expand('%:e')
-- --     local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
-- --     if icon ~= nil then
-- --       val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
-- --     else
-- --       val.fg = 'white'
-- --     end
-- --     val.bg = 'bg'
-- --     val.style = 'bold'
-- --     return val
-- --   end,
-- --   right_sep = ' '
-- -- }
-- -- -- fileSize
-- -- components.active[3][3] = {
-- --   provider = 'file_size',
-- --   enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
-- --   hl = {
-- --     fg = 'skyblue',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   },
-- --   right_sep = ' '
-- -- }
-- -- -- fileFormat
-- -- components.active[3][4] = {
-- --   provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
-- --   hl = {
-- --     fg = 'white',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   },
-- --   right_sep = ' '
-- -- }
-- -- -- fileEncode
-- -- components.active[3][5] = {
-- --   provider = 'file_encoding',
-- --   hl = {
-- --     fg = 'white',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   },
-- --   right_sep = ' '
-- -- }
-- -- components.active[3][6] = {
-- --   provider = 'position',
-- --   hl = {
-- --     fg = 'white',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   },
-- --   right_sep = ' '
-- -- }
-- -- -- linePercent
-- -- components.active[3][7] = {
-- --   provider = 'line_percentage',
-- --   hl = {
-- --     fg = 'white',
-- --     bg = 'bg',
-- --     style = 'bold'
-- --   },
-- --   right_sep = ' '
-- -- }
-- -- -- scrollBar
-- -- components.active[3][8] = {
-- --   provider = 'scroll_bar',
-- --   hl = {
-- --     fg = 'yellow',
-- --     bg = 'bg',
-- --   },
-- -- }
-- -- 
-- -- -- INACTIVE
-- -- 
-- -- -- fileType
-- -- components.inactive[1][1] = {
-- --   provider = 'file_type',
-- --   hl = {
-- --     fg = 'black',
-- --     bg = 'cyan',
-- --     style = 'bold'
-- --   },
-- --   left_sep = {
-- --     str = ' ',
-- --     hl = {
-- --       fg = 'NONE',
-- --       bg = 'cyan'
-- --     }
-- --   },
-- --   right_sep = {
-- --     {
-- --       str = ' ',
-- --       hl = {
-- --         fg = 'NONE',
-- --         bg = 'cyan'
-- --       }
-- --     },
-- --     ' '
-- --   }
-- -- }
--
-- -- WINBAR
-- -- LEFT
--
-- -- nvimGps
-- --winbar_components.active[1][1] = {
-- --  provider = function() return gps.get_location() end,
-- --  enabled = function() return gps.is_available() end,
-- --  hl = {
-- --    fg = 'orange',
-- --    style = 'bold'
-- --  }
-- --}
--
-- -- MID
--
-- -- RIGHT
--
-- -- LspName
-- -- winbar_components.active[3][1] = {
-- --   provider = 'lsp_client_names',
-- --   hl = {
-- --     fg = 'yellow',
-- --     style = 'bold'
-- --   },
-- --   right_sep = ' '
-- -- }
-- -- -- diagnosticErrors
-- -- winbar_components.active[3][2] = {
-- --   provider = 'diagnostic_errors',
-- --   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
-- --   hl = {
-- --     fg = 'red',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- -- diagnosticWarn
-- -- winbar_components.active[3][3] = {
-- --   provider = 'diagnostic_warnings',
-- --   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
-- --   hl = {
-- --     fg = 'yellow',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- -- diagnosticHint
-- -- winbar_components.active[3][4] = {
-- --   provider = 'diagnostic_hints',
-- --   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
-- --   hl = {
-- --     fg = 'cyan',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- -- diagnosticInfo
-- -- winbar_components.active[3][5] = {
-- --   provider = 'diagnostic_info',
-- --   enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
-- --   hl = {
-- --     fg = 'skyblue',
-- --     style = 'bold'
-- --   }
-- -- }
-- -- 
-- -- -- INACTIVE
-- -- 
-- -- -- fileType
-- -- winbar_components.inactive[1][1] = {
-- --   provider = 'file_type',
-- --   hl = {
-- --     fg = 'black',
-- --     bg = 'cyan',
-- --     style = 'bold'
-- --   },
-- --   left_sep = {
-- --     str = ' ',
-- --     hl = {
-- --       fg = 'NONE',
-- --       bg = 'cyan'
-- --     }
-- --   },
-- --   right_sep = {
-- --     {
-- --       str = ' ',
-- --       hl = {
-- --         fg = 'NONE',
-- --         bg = 'cyan'
-- --       }
-- --     },
-- --     ' '
-- --   }
-- -- }
--
-- require('feline').setup({
--   theme = colors,
--   default_bg = bg,
--   default_fg = fg,
--   vi_mode_colors = vi_mode_colors,
--   components = components,
--   force_inactive = force_inactive,
-- })
--
-- --require('feline').winbar.setup({
-- --  components = winbar_components,
-- --  force_inactive = force_inactive,
-- --})
