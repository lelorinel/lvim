-- return { "nvim-java/nvim-java" }
local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
local launcher_jar = vim.fn.glob(jdtls_path .. "plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = jdtls_path .. "config_linux"
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

return {
  "mfussenegger/nvim-jdtls",
  config = function()
    -- Ensure the current buffer is a Java file
    if vim.bo.filetype ~= "java" then
      return
    end

    -- Define the command to start jdtls
    local java_cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      launcher_jar,
      "-configuration",
      config_path,
      "-data",
      workspace_dir,
    }

    -- Start or attach to the JDTLS server
    require("jdtls").start_or_attach({
      cmd = java_cmd,
      root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", ".git", "mvnw", "gradlew" }),
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "automatic",
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          format = {
            enabled = true,
          },
        },
      },
      flags = {
        allow_incremental_sync = true,
      },
      init_options = {
        bundles = {},
      },
    })
  end,
}
