fx_version 'bodacious'
game 'gta5'

server_script "server.lua"

client_script "client.lua"

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}