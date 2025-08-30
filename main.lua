
TJR = {
    funcs = {}
}

-- Debugging functions
function sendDebugMessage(msg)
    print("[TJR DEBUG]: " .. tostring(msg))
end

function sendErrorMessage(msg)
    print("[TJR ERROR] " .. tostring(msg))
end

-- List of modules to be loaded
local includes = {
    'assets',
    'items',
	'utilities',
	'objects',
}

-- Load modules
for _, include in ipairs(includes) do
    local success, error_msg = pcall(function()
        local init, error = SMODS.load_file("includes/" .. include .. ".lua")
        if error then
            sendErrorMessage("Failed to load " .. include .. " with error: " .. error)
        else
            if init then init() end
            sendDebugMessage("Loaded module: " .. include)
        end
    end)
    if not success then
        sendErrorMessage("Error in module " .. include .. ": " .. error_msg)
    end
end
