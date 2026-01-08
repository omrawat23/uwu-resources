fx_version "cerulean"
lua54 "yes"
games { "gta5" }

ui_page "build/index.html"

files {
  "stream/*.ytd",
  "build/index.html",
    'build/dui.html',
    'build/employeedui.html',
    'build/menudui.html',
  "build/**/*",
}


dependencies {
  'crux_lib',
  'ox_lib',
}

shared_scripts {
  "shared/*.lua",
  "locales/*.lua",
  '@crux_lib/init.lua',
  '@ox_lib/init.lua',
}

client_scripts {
  "client/*.lua",
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "server/*.lua"
}


