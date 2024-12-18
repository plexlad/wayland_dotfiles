return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function ()
    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/org/org/**/*",
      org_default_notes_file = "~/org/org/refile.org",
    })
  end
}
