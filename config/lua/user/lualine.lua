local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local palette = require('melange.palettes.dark')

  -- a = {
  --   bg = "#292522",
  --   com = "#C1A78E",
  --   fg = "#ECE1D7",
  --   float = "#34302C",
  --   sel = "#403A36",
  --   ui = "#867462"
  -- },
  -- b = {
  --   blue = "#A3A9CE",
  --   cyan = "#89B3B6",
  --   green = "#85B695",
  --   magenta = "#CF9BC2",
  --   red = "#D47766",
  --   yellow = "#EBC06D"
  -- },
  -- c = {
  --   blue = "#7F91B2",
  --   cyan = "#7B9695",
  --   green = "#78997A",
  --   magenta = "#B380B0",
  --   red = "#BD8183",
  --   yellow = "#E49B5D"
  -- },
  -- d = {
  --   blue = "#273142",
  --   cyan = "#253333",
  --   green = "#233524",
  --   magenta = "#422741",
  --   red = "#7D2A2F",
  --   yellow = "#8B7449"
  -- }


local astyle = {
  bg = palette.a.float,
  fg = palette.a.ui,
}

local bstyle = {
  bg = palette.a.float,
}

local cstyle = {
  bg = palette.a.float,
  fg = palette.c.yellow,
  gui = 'bold,underline',
}

local fname = require('lualine.components.filename'):extend()
local highlight = require'lualine.highlight'
function fname:init(options)
  options.path = 1
  options.symbols = { modified = '', readonly = ' [-]', unnamed = '', }
  fname.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(astyle, '', self.options),
    modified = highlight.create_component_highlight_group(cstyle, '', self.options),
  }
end

function fname:update_status()
  local data = fname.super.update_status(self)
  return highlight.component_format_highlight(vim.bo.modified
    and self.status_colors.modified
    or self.status_colors.saved) .. data
end

local colors = {
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = {
      normal = {
        a = astyle,
        b = bstyle,
        c = astyle,

        x = astyle,
        y = bstyle,
        z = astyle,
      },
    },
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  colors = {
    percentage  = colors.cyan,
    title  = colors.cyan,
    message  = colors.cyan,
    spinner = colors.cyan,
    lsp_client_name = colors.magenta,
    use = true,
  },
  sections = {
    lualine_a = {
      {
        'lsp_progress',
        display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
        colors = {
          percentage = colors.cyan,
          title = colors.cyan,
          message = colors.cyan,
          spinner = colors.cyan,
          lsp_client_name = colors.magenta,
          use = true,
        },
        separators = {
          component = ' ',
          progress = ' | ',
          message = { pre = '(', post = ')'},
          percentage = { pre = '', post = '%% ' },
          title = { pre = '', post = ': ' },
          lsp_client_name = { pre = '[', post = ']' },
          spinner = { pre = '', post = '' },
          -- message = { commenced = 'In Progress', completed = 'Completed' },
        },
        timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
        spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
      },
    },
    lualine_b = {
      fname
    },
    lualine_c = {},
    lualine_x = {
      'encoding',
      {'filetype', colored = false},
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {},
  tabline = {
    lualine_a = {
      'lsp_progress2',
    },
    -- Did the :Taboo (tab-rename) plugin broke these tabs?
    lualine_b = {
      {'tabs', mode = 0,
        tabs_color = {
        -- Same values as the general color option can be used here.
        active = cstyle,
        inactive = astyle,
      },
      },
    },
    lualine_x = {
      'diagnostics',
      'branch',
    },
  },
  extensions = {},
}
