fx_version 'cerulean'

game 'gta5'

author 'B14ck / BlackDark0'
description 'Origen Business Notify'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
    'config.lua',
    'custom/server.lua'
}

client_scripts {
    'custom/client.lua'
}

escrow_ignore {
    'config.lua'
}