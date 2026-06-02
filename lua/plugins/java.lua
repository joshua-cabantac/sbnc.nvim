return {
  {
    'nvim-java/nvim-java',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'mfussenegger/nvim-dap',
      {
        'JavaHello/spring-boot.nvim',
        commit = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
      },
    },
    config = function()
      local function java_home()
        local home = vim.fn.systemlist({ '/usr/libexec/java_home', '-v', '21' })[1]
        if vim.v.shell_error == 0 and home and home ~= '' then
          return home
        end

        home = vim.fn.systemlist({ '/usr/libexec/java_home' })[1]
        if vim.v.shell_error == 0 and home and home ~= '' then
          return home
        end
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
        jdk = {
          auto_install = false,
        },
      }
      vim.lsp.config('jdtls', {
        root_markers = {
          { 'mvnw', 'pom.xml', 'gradlew', 'settings.gradle', 'settings.gradle.kts', 'build.gradle', 'build.gradle.kts' },
          { '.git' },
        },
        capabilities = require('blink.cmp').get_lsp_capabilities(),
        cmd_env = (function()
          local home = java_home()
          if not home then
            return nil
          end

          return {
            JAVA_HOME = home,
            PATH = home .. '/bin:' .. vim.fn.getenv 'PATH',
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
