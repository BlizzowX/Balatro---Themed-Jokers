-- Theme-based item loading configuration
local themeItems = {
    ["Combat Ace"] = {
        Back = {
            'ca_debug',
        },
        Blind = {
            'ca_desertation',
        },
        Joker = {
            'ca_soldier',
            'ca_supplies',
            'ca_mercenary',
            'ca_promotion',
            'ca_recruiter',
            'ca_general',
            'ca_veteran',
        },
    },
    ["Jurassic"] = {
        Back = {
            'ju_debug',
        },
        Joker = {
            'ju_quetzalcoatlus',
            'ju_trex',
            'ju_mosasaurus',
            'ju_brachiosaurus',
            'ju_fossil_quetz',
            'ju_fossil_rex',
            'ju_fossil_mosa',
            'ju_fossil_brachio',
            'ju_paleontologist',
            'ju_excavation',
            'ju_museum',
            'ju_dinosauregg',
            'ju_fossil_egg',
        },
    },
    ["Infected"] = {
        Enhancement = {
            'infected',
        },
        Consumable = {
            'in_miasma',
        },
        Pokerhand = {
            'patient_zero',
            'outbreak',
            'epidemic',
            'plague',
            'global_pandemic',
        },
        Joker = {
            'in_mutation',
            'in_potency',
            'in_joker',
            'in_contaigon',
            'in_swarm',
            'in_plaguedoctor',
            'in_corruptedjoker',
            'in_superspreadder',
            'in_pulcinella',
        },
        Back = {
            'in_debug',
        },
    },
    ["Mischief"] = {
        Joker = {
            'mc_piece1',
            'mc_piece2',
            'mc_piece3',
            'mc_piece4',
            'mc_jimbo',
            'mc_cultist',
        },
        Voucher = {
            'mc_ritual',
            'mc_awakening',
        },
    }
}


-- Function to load items from a specific theme folder
local function loadThemeItems(themeName, themeConfig)
    for item_type, items in pairs(themeConfig) do
        for _, item_key in ipairs(items) do
            local item_path
            if themeName == "Global" then
                -- Global items stay in the main items folder
                item_path = "items/" .. string.lower(item_type) .. "s/" .. item_key .. ".lua"
            else
                -- Theme-specific items go in theme folders
                item_path = themeName .. "/" .. string.lower(item_type) .. "s/" .. item_key .. ".lua"
            end
            
            local item_init, item_error = SMODS.load_file(item_path)
            
            if item_error then
                sendDebugMessage("[TJR] Error loading " .. themeName .. " " .. item_type:lower() .. ": " .. item_key .. " - " .. item_error)
            else
                local item_data = item_init and item_init()
                if item_data then
                    -- Register the item based on its type
                    if item_type == "Joker" then
                        SMODS.Joker(item_data)
                    elseif item_type == "Pokerhand" then
                        SMODS.PokerHand(item_data)
                    elseif item_type == "Consumable" then
                        SMODS.Consumable(item_data)
                    elseif item_type == "Back" then
                        SMODS.Back(item_data)
                    elseif item_type == "Voucher" then
                        SMODS.Voucher(item_data)
                    elseif item_type == "Tag" then
                        SMODS.Tag(item_data)
                    elseif item_type == "Enhancement" then
                        SMODS.Enhancement(item_data)
                    elseif item_type == "Edition" then
                        SMODS.Edition(item_data)
                    elseif item_type == "Blind" then
                        SMODS.Blind(item_data)
                    elseif item_type == "Challenge" then
                        SMODS.Challenge(item_data)
                    elseif item_type == "Stake" then
                        SMODS.Stake(item_data)
                    end
                    sendDebugMessage("[TJR] Loaded " .. themeName .. " " .. item_type:lower() .. ": " .. item_key)
                end
            end
        end
    end
end

-- Load items from all themes
for themeName, themeConfig in pairs(themeItems) do
    loadThemeItems(themeName, themeConfig)
end

return function()
    return themeItems
end