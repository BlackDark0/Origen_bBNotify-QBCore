fx_version 'cerulean'
game 'gta5'

author 'B14ck / BlackDark0'
description 'Sistema de blips para negocios abiertos/cerrados con origen notify'
version '1.0.0'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'server.lua'
}

dependencies {
    'origen_notify',
    'ox_lib'
}

lua54 'yes'
