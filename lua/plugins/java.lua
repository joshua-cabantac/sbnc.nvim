return {
  {
    'nvim-java/nvim-java',
    ft = 'java',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'mfussenegger/nvim-dap',
      {
        'JavaHello/spring-boot.nvim',
        commit = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
      },
    },
    config = function()
      local function path_join(...)
        return table.concat({ ... }, package.config:sub(1, 1))
      end

      local function path_separator()
        return vim.fn.has 'win32' == 1 and ';' or ':'
      end

      local function executable(path)
        return path and path ~= '' and vim.fn.executable(path) == 1
      end

      local function normalize_java_home(home)
        if not home or home == '' then
          return nil
        end

        home = vim.fn.fnamemodify(vim.fn.expand(home), ':p:h')
        local java_bin = vim.fn.has 'win32' == 1 and 'java.exe' or 'java'
        if executable(path_join(home, 'bin', java_bin)) then
          return home
        end
      end

      local function java_home_from_executable(java_bin)
        if not java_bin or java_bin == '' then
          return nil
        end

        local real_java = vim.uv.fs_realpath(java_bin) or java_bin
        return normalize_java_home(vim.fn.fnamemodify(real_java, ':h:h'))
      end

      local function java_home()
        local env_home = normalize_java_home(vim.fn.getenv 'JAVA_HOME')
        if env_home then
          return env_home
        end

        if executable '/usr/libexec/java_home' then
          local home = vim.fn.systemlist({ '/usr/libexec/java_home', '-v', '21' })[1]
          home = normalize_java_home(home)
          if home then
            return home
          end

          home = vim.fn.systemlist({ '/usr/libexec/java_home' })[1]
          home = normalize_java_home(home)
          if home then
            return home
          end
        end

        local java_bin = vim.fn.has 'win32' == 1 and vim.fn.exepath 'java.exe' or vim.fn.exepath 'java'
        return java_home_from_executable(java_bin)
      end

      local function attach_java_debugger(opts)
        local dap = require 'dap'

        if not dap.adapters.java then
          vim.notify('Java DAP is not ready yet; open a Java file and wait for JDTLS to finish.', vim.log.levels.WARN)
          return
        end

        local main_class = opts and opts.args and opts.args ~= '' and opts.args or 'me.sbnc.suite.measurablestore.SbncSuiteMeasurableStoreApplication'

        vim.ui.input({ prompt = 'Java debug port: ', default = '5005' }, function(input)
          if not input or input == '' then
            return
          end

          local port = tonumber(input)
          if not port then
            vim.notify('Invalid debug port: ' .. input, vim.log.levels.ERROR)
            return
          end

          dap.run {
            type = 'java',
            request = 'attach',
            name = 'Attach Java debugger',
            hostName = '127.0.0.1',
            port = port,
            mainClass = main_class,
          }
        end)
      end

      vim.api.nvim_create_user_command('JavaDebugAttach', attach_java_debugger, {
        desc = 'Attach Java debugger to localhost',
        nargs = '?',
      })
      vim.keymap.set('n', '<leader>da', attach_java_debugger, {
        desc = 'Debug: Attach Java',
      })

      require('java').setup {
        -- The project already has a working JDK; avoid nvim-java's OpenJDK
        -- installer path, which is incompatible with the pinned Mason version.
        java_debug_adapter = {
          enable = true,
        },
        java_test = {
          enable = true,
        },
        spring_boot_tools = {
          enable = true,
        },
        jdk = {
          auto_install = false,
        },
      }
      vim.lsp.config('jdtls', {
        filetypes = { 'java' },
        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, {
            'mvnw',
            'pom.xml',
            'gradlew',
            'settings.gradle',
            'settings.gradle.kts',
            'build.gradle',
            'build.gradle.kts',
            '.git',
          })
          on_dir(root or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
        end,
        capabilities = require('blink.cmp').get_lsp_capabilities(),
        cmd_env = (function()
          local home = java_home()
          if not home then
            return nil
          end

          return {
            JAVA_HOME = home,
            PATH = path_join(home, 'bin') .. path_separator() .. vim.fn.getenv 'PATH',
          }
        end)(),
        handlers = {
          -- JDTLS sends long Maven download/status messages here; fidget already
          -- handles useful LSP progress without forcing "Press ENTER" prompts.
          ['language/status'] = function() end,
        },
      })
      vim.lsp.enable 'jdtls'
    end,
  },
}
