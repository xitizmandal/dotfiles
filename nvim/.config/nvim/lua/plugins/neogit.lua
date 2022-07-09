local neogit = require('neogit')

neogit.setup {
    disable_commit_confirmation = true,
    integrations = {
        diffview = true
    },
    sections = {
        unstaged = {
            folded = false,
        },
        staged = {
            folded = false,
        },
        untracked = {
            folded = false,
        },
        stashes = {
            folded = true,
        },
        unpulled = {
            folded = true,
        },
        unmerged = {
            folded = true,
        },
        recent = {
            folded = true,
        }
    }
}
