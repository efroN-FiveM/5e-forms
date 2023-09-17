LogsPicture = 'https://cdn.discordapp.com/attachments/1072127728209367040/1152307723195645993/5E-Devs_Logo_V2.png'

local Links = {
    LSPD = '',
    BurgerShot = '',
}

local Colors = {
    default = 14423100,
    blue = 255,
    red = 16711680,
    green = 65280,
    white = 16777215,
    black = 0,
    orange = 16744192,
    yellow = 16776960,
    pink = 16761035,
    lightgreen = 65309,
}

function format_int(number)
	local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction
end

function SendWebHook(whLink, color, message, title)
    local embedMsg = {}
    timestamp = os.date("%c")
    embedMsg = {
        {
            ["color"] = Colors[color],
            ["author"] = {
                name = "5E-Devs | Join Form",
                icon_url = LogsPicture
            },
            ["title"] = title,
            ["description"] =  ""..message.."",
            ["footer"] ={
                ["text"] = timestamp.." (Server Time).",
                icon_url = LogsPicture,
            },
        }
    }
    PerformHttpRequest(whLink,
    function(err, text, headers)end, 'POST', json.encode({username = 'Join Form', avatar_url= LogsPicture ,embeds = embedMsg}), { ['Content-Type']= 'application/json' })
end

RegisterServerEvent('5e-forms:sendlog')
AddEventHandler('5e-forms:sendlog', function(data, location)
    local src = source
    local result = false
    local title = location..' Form: Sender - '..GetPlayerName(src)..'('..src..')'
    local message = ""
    for key, value in pairs(data) do
        for k, v in pairs(value) do
            message = message..'**['..k..']: **\n'..v..'\n\n'
        end
    end
    SendWebHook(Links[location], 'green', message, title)
end)