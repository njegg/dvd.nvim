--[[--------------------------
⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡀
⠀⢠⣿⣿⡿⠀⠀⠈⢹⣿⣿⡿⣿⣿⣇⠀⣠⣿⣿⠟⣽⣿⣿⠇⠀⠀⢹⣿⣿⣿
⠀⢸⣿⣿⡇⠀⢀⣠⣾⣿⡿⠃⢹⣿⣿⣶⣿⡿⠋⢰⣿⣿⡿⠀⠀⣠⣼⣿⣿⠏
⠀⣿⣿⣿⣿⣿⣿⠿⠟⠋⠁⠀⠀⢿⣿⣿⠏⠀⠀⢸⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣸⣟⣁⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⣠⣴⣶⣾⣿⣿⣻⡟⣻⣿⢻⣿⡟⣛⢻⣿⡟⣛⣿⡿⣛⣛⢻⣿⣿⣶⣦⣄⡀⠀
⠉⠛⠻⠿⠿⠿⠷⣼⣿⣿⣼⣿⣧⣭⣼⣿⣧⣭⣿⣿⣬⡭⠾⠿⠿⠿⠛⠉⠀
]]----------------------------

local logo_str = "⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡀⠀⢠⣿⣿⡿⠀⠀⠈⢹⣿⣿⡿⣿⣿⣇⠀⣠⣿⣿⠟⣽⣿⣿⠇⠀⠀⢹⣿⣿⣿⠀⢸⣿⣿⡇⠀⢀⣠⣾⣿⡿⠃⢹⣿⣿⣶⣿⡿⠋⢰⣿⣿⡿⠀⠀⣠⣼⣿⣿⠏⠀⣿⣿⣿⣿⣿⣿⠿⠟⠋⠁⠀⠀⢿⣿⣿⠏⠀⠀⢸⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣸⣟⣁⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣶⣾⣿⣿⣻⡟⣻⣿⢻⣿⡟⣛⢻⣿⡟⣛⣿⡿⣛⣛⢻⣿⣿⣶⣦⣄⡀⠀⠉⠛⠻⠿⠿⠿⠷⣼⣿⣿⣼⣿⣧⣭⣼⣿⣧⣭⣿⣿⣬⡭⠾⠿⠿⠿⠛⠉⠀"

local logo = {}

local utf = require("utf8")

local logo_code_i = 1
for _, c in utf.codes(logo_str) do
    logo[logo_code_i] = c;
    logo_code_i = logo_code_i + 1
end

local config_dvd = {
    fps = 20,
    name = 'dvd',
}

local w
local h

local pos
local dvd = { w = 29, h = 6 }
local vel = { x = 2, y = 1 }

-- init function is invoked only once at the start
 config_dvd.init = function (grid)
    h = #grid
    w = #(grid[1])

    pos = { x = math.random(w - dvd.w), y = math.random(h - dvd.h) }

    for i = 1, #grid do
        for j = 1, #(grid[i]) do
            grid[i][j] =  { char = " " }
        end
    end
 end

config_dvd.update = function (grid)
    clear_dvd(grid);

    if pos.x + vel.x + dvd.w > w or pos.x + vel.x <= 0 then
        vel.x = -vel.x
    end

    if pos.y + vel.y + dvd.h > h or pos.y + vel.y <= 0 then
        vel.y = -vel.y
    end

    pos.x = pos.x + vel.x
    pos.y = pos.y + vel.y

    draw_dvd(grid)

    return true
end

function draw_dvd(grid)
    local logo_i = 1

    for i = pos.y, dvd.h + pos.y do
        for j = pos.x, dvd.w + pos.x do
            grid[i][j] = { char = logo[logo_i] }

            logo_i = logo_i + 1
        end
    end
end

function clear_dvd(grid)
    for i = pos.y, dvd.h + pos.y do
        for j = pos.x, dvd.w + pos.x do
            grid[i][j] = { char =  " " }
        end
    end
end

function get_utf_char(str, i)
    local byte1 = string.byte(str, i)

    if byte1 < 128 then
        return string.char(byte1)
    end

    local numBytes = 2

    if byte1 >= 192 and byte1 < 224 then
        numBytes = 2
    elseif byte1 >= 224 and byte1 < 240 then
        numBytes = 3
    elseif byte1 >= 240 and byte1 < 248 then
        numBytes = 4
    end

    local charBytes = {string.byte(str, i, i + numBytes - 1)}
    return string.char(unpack(charBytes))
end


require("cellular-automaton").register_animation(config_dvd)

