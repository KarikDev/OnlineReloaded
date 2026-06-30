fx_version 'cerulean'
game 'gta5'

author 'OnlineReloaded Team.'
description 'OnlineReloaded'
version 'pre-a0.0.1'

-- Load order matters: modules first, then the core that starts them.
server_scripts {
    'server/main.lua',
    'modules/economy/server/server.lua'
}

client_scripts {
    'modules/player/player-data/server/server.lua'
    'modules/economy/client/client.lua',
}