fx_version 'cerulean'
game 'gta5'

author 'OnlineReloaded Team.'
description 'OnlineReloaded'
version 'pre-a0.0.1'

-- Load order matters: modules first, then the core that starts them.
server_scripts {
    'server/main.lua',
    'modules/player/player-data/server/server.lua',
    'modules/economy/server/server.lua',
}

client_scripts {
    'modules/economy/client/client.lua',
    'modules/player/inputmultiplayerinfohandler/client/client.lua',
}




-- Chat Theme Module Handling
files {
    'modules/other/chat/style.css',
    'modules/other/chat/shadow.js',
}

chat_theme 'gtao' {
    styleSheet = 'modules/other/chat/style.css',
    script = 'modules/other/chat/shadow.js',
    msgTemplates = {
        default = '<b>{0}</b><span>[ALL]</span><span>{1}</span>'
    }
}

-- Loading Screen Module Handling

files {
    'modules/ui/loadingscreen/index.html',
}

loadscreen 'modules/ui/loadingscreen/index.html'