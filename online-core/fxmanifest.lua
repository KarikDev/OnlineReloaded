fx_version 'cerulean'
game 'gta5'

author 'OnlineReloaded Team.'
description 'OnlineReloaded'
version 'pre-a0.0.1'

-- Load order matters: modules first, then the core that starts them.
server_scripts {
    'server/main.lua',  -- Main server controller handler.
    'modules/player/player-data/server/server.lua', -- player data module
    'modules/economy/server/server.lua', -- economy module
}

client_scripts {
    'modules/ui/loadingscreen/client/client.lua', -- loading screen
    'modules/economy/client/client.lua', -- economy client display handler
    'modules/player/inputmultiplayerinfohandler/client/client.lua', -- multiplayer info handler (Z)
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
    'modules/ui/loadingscreen/client/index.html',
    'modules/ui/loadingscreen/client/bg.png',
}

loadscreen 'modules/ui/loadingscreen/client/index.html'
