local waywall = require("waywall")
local helpers = require("waywall.helpers")

local Scene = require("waywork.scene")
local Modes = require("waywork.modes")
local Keys = require("waywork.keys")
local Processes = require("waywork.processes")

local resources_folder = os.getenv("HOME") .. "/.config/waywall/resources"
local eye_overlay_path = resources_folder .. "/images/measuring_overlay.png"
local ninbot_path = resources_folder .. "/jars/Ninjabrain-Bot-1.5.2.jar"

local normal_sens = 6.28511007
local tall_sens = 0.42398977

local keys = {
    thin = "*-Grave",
    tall = "*-Z",
    wide = "*-M5",
    toggle_ninbot = "*-F2",
    fullscreen = "F11",
}

local function read_file(name)
    local file = io.open(name, "r")
    if not file then return end
    local data = file:read("*a")
    file:close()
    return data
end

local function shader(name)
    return {
        vertex = read_file(resources_folder .. "/shaders/general.vert"),
        fragment = read_file(resources_folder .. "/shaders/frag/" .. name .. ".frag"),
    }
end

local config = {
    input = {
        layout = "gb",
        repeat_rate = 80,
        repeat_delay = 175,
        remaps = { ["M3"] = "F3" },
        sensitivity = normal_sens,
    },
    theme = {
        background = "#000000",
        ninb_anchor = "topright",
        ninb_opacity = 0.7,
        cursor_theme = "Adwaita",
        cursor_icon = "crosshair",
        cursor_size = 20,
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = false,
        scene_add_text = true,
    },
    shaders = {
        pie_chart = shader("pie_chart"),
        spawn = shader("spawner"),
        spawn_bg = shader("spawner_bg"),
        text = shader("text"),
        text_bg = shader("text_bg"),
    },
}

local scene = Scene.SceneManager.new(waywall)

local function register_mirror(name, src, dst, group, shader_name, depth)
    scene:register(name, {
        kind = "mirror",
        options = {
            src = src,
            dst = dst,
            shader = shader_name,
            depth = depth,
        },
        groups = { group },
    })
end

local function register_image(name, path, dst, group, depth)
    scene:register(name, {
        kind = "image",
        path = path,
        options = { dst = dst },
        groups = { group },
        depth = depth,
    })
end

for i = 0, 3 do
    local src = { x = 1827, y = 859 + 8 * i, w = 33, h = 9 }

    helpers.res_mirror({
        src = src,
        dst = { x = 1630, y = 720, w = 231, h = 63 },
        depth = 3,
        shader = "spawn",
    }, 0, 0)

    helpers.res_mirror({
        src = src,
        dst = { x = 1637, y = 727, w = 231, h = 63 },
        depth = 2,
        shader = "spawn_bg",
    }, 0, 0)
end

local function register_text_pair(name, src, dst)
    register_mirror(name, src, dst, "thin", "text")
    register_mirror(name .. "_shadow", src, {
        x = dst.x + 5, y = dst.y + 5, w = dst.w, h = dst.h
    }, "thin", "text_bg")
end

register_text_pair("c_e_counter",
    { x = 1, y = 28, w = 64, h = 18 },
    { x = 1150, y = 500, w = 320, h = 90 })

register_text_pair("o_counter",
    { x = 45, y = 154, w = 64, h = 10 },
    { x = 1150, y = 590, w = 320, h = 50 })

local pie_configs = {
    thin = {
        percentage_src = { x = 247, y = 859, w = 33, h = 25 },
        percentage_dst = { x = 894, y = 900, w = 132, h = 100, }
    },
    tall = {
        src = { x = 44, y = 15978, w = 340, h = 178 },
        percentage_src = { x = 291, y = 16163, w = 33, h = 25 },
        percentage_dst = { x = 894, y = 930, w = 132, h = 100, }
    },
}

for group, pie in pairs(pie_configs) do
    if pie.src then
        register_mirror("pie_" .. group, pie.src,
            { x = 825, y = 666, w = 270, h = 272 },
            group, "pie_chart", 2)
    end

    register_mirror("percentages_" .. group, pie.percentage_src,
        pie.percentage_dst, group, "text")

    register_mirror("percentages_shadow_" .. group, pie.percentage_src, {
        x = pie.percentage_dst.x + 3,
        y = pie.percentage_dst.y + 3,
        w = pie.percentage_dst.w,
        h = pie.percentage_dst.h,
    }, group, "text_bg")
end

register_mirror("eye_measure",
    { x = 177, y = 7902, w = 30, h = 580 },
    { x = 30, y = 340, w = 700, h = 400 },
    "tall")

register_image("eye_overlay", eye_overlay_path,
    { x = 30, y = 340, w = 700, h = 400 },
    "tall")

local pie_dst_2 = { x = 1811, y = 1013, w = 98, h = 53 }
local pie_dst_2_sh = { x = 1803, y = 1005, w = 113, h = 68 }
local pie_dst_1 = { x = 1698, y = 1013, w = 98, h = 53 }
local pie_dst_1_sh = { x = 1691, y = 1005, w = 113, h = 68 }

local function register_pie_mirrors(dst, shadow, color, depth)
    for i = 0, 6 do
        local y = 860 + 8 * i

        helpers.res_mirror({
            src = { x = 1590, y = y, w = 13, h = 7 },
            dst = dst,
            depth = depth,
            color_key = { input = color, output = color },
        }, 0, 0)

        helpers.res_mirror({
            src = { x = 1590, y = y, w = 1, h = 1 },
            dst = shadow,
            depth = depth - 1,
            color_key = { input = color, output = "#000000" },
        }, 0, 0)
    end
end

local pie_colors = {
    { "#6543CA", 3 },
    { "#63cbc2", 3 },
    { "#e145c2", 5 },
    { "#c4c46d", 5 },
}

for _, color in ipairs(pie_colors) do
    register_pie_mirrors(pie_dst_2, pie_dst_2_sh, color[1], color[2])
end

register_pie_mirrors(pie_dst_1, pie_dst_1_sh, "#c2cbc2", 5)
register_pie_mirrors(pie_dst_1, pie_dst_1_sh, "#63cbc2", 3)
register_pie_mirrors(pie_dst_1, pie_dst_1_sh, "#e145c2", 5)

local mode_manager = Modes.ModeManager.new(waywall)

mode_manager:define("thin", {
    width = 340,
    height = 1080,
    on_enter = function() scene:enable_group("thin", true) end,
    on_exit = function() scene:enable_group("thin", false) end,
})

mode_manager:define("tall", {
    width = 384,
    height = 16384,
    toggle_guard = function() return not waywall.get_key("F3") end,
    on_enter = function()
        scene:enable_group("tall", true)
        if not (waywall.get_key("RIGHTSHIFT") or waywall.get_key("LEFTSHIFT")) then
            waywall.set_sensitivity(tall_sens)
        end
    end,
    on_exit = function()
        scene:enable_group("tall", false)
        waywall.set_sensitivity(normal_sens)
    end,
})

mode_manager:define("wide", {
    width = 1920,
    height = 300,
    on_enter = function() scene:enable_group("wide", true) end,
    on_exit = function() scene:enable_group("wide", false) end,
})

local ninb_running = false

local exec_ninb = function()
    local handle = io.popen("pgrep -f 'Ninjabrain.*jar'")
    local result = handle:read("*l")
    handle:close()

    if result == nil then
        waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. ninbot_path)
    end

    ninb_running = true
end

config.actions = Keys.actions({
    [keys.thin] = function() return mode_manager:toggle("thin") end,
    [keys.tall] = function() return mode_manager:toggle("tall") end,
    [keys.wide] = function() return mode_manager:toggle("wide") end,
    [keys.fullscreen] = waywall.toggle_fullscreen,

    [keys.toggle_ninbot] = function()
        if not ninb_running then
            exec_ninb()
            waywall.show_floating(true)
        else
            helpers.toggle_floating()
        end
    end,

    ["*-C"] = function()
        if waywall.get_key("F3") then
            waywall.show_floating(true)
        end
        return false
    end,
})

return config