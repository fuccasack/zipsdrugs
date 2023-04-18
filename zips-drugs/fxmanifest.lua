fx_version 'cerulean'
games {'gta5'}

lua54 'yes'
name         'zipsdrugs'
version      '1.0.0'
description  'Drugs System'
author       'ZIPS#0001'

dependancies {
    "ox_inventory",
    "ox_target",
    "zips-markers",
}

client_scripts {
    "functions.lua",
    "config.lua",
    "client.lua",
    "@zips-markers/client.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config.lua",

    "server.lua",
}
