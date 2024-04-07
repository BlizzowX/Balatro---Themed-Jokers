--- STEAMODDED HEADER
--- MOD_NAME: Themed Tarots
--- MOD_ID: ThemedTarots
--- MOD_AUTHOR: [Blizzow]
--- MOD_DESCRIPTION: Adds Tarot cards to get TJ Jokers more reliable

----------------------------------------------
------------MOD CODE -------------------------

----------------------------------------------
-------------------UTIL-----------------------

function addjoker(joker,negative)
    local card = create_card('Joker', G.jokers, nil, 0, nil, nil, joker, nil)
    if negative~=nil then
        card:set_edition({negative = true})
    end
    card:add_to_deck()
    G.jokers:emplace(card)
    G.GAME.used_jokers[joker] = true
end

function getjokerfromlist(list)
    return math.random(1,#list)
end

function checkforcosmic()
    for i= 1, #G.jokers.cards do
        other_joker = G.jokers.cards[i]
        if string.match(other_joker.ability.name, "Cosmic -") and other_joker.ability.extra.tokens~=nil then
            return true
        end        
    end
    return false
end

local contractjoker ={
    'j_combatacesoldier',
    'j_combatacemercenary',
    'j_combatacegeneral',
    'j_combatacesupplies',
    'j_combatacesecretagent',
    'j_combatacepromotion'
}
local cosmosjoker ={
    'j_cosmiccapricorn',
    'j_cosmicpisces',
    'j_cosmicaquarius',
    'j_cosmicleo',
    'j_cosmicgemini',
    'j_cosmiclibra',
    'j_cosmicscorpio',
    'j_cosmictaurus',
    'j_cosmicaries',
    'j_cosmiccancer',
    'j_cosmicvirgo',
    'j_cosmicsagittarius'
}
local mischiefjoker ={
    'j_firstpieceofthemischievousone',
    'j_secondpieceofthemischievousone',
    'j_thirdpieceofthemischievousone',
    'j_fourthpieceofthemischievousone',
    'j_cultistofthemischievousone'
}

-- SMODS.Tarot:new(name, slug, config, pos, loc_txt, cost, cost_mult, effect, consumeable, discovered, atlas)

local tarots = {
    mischief = {
        name = "Mischief",
        text = {
            "Creates a {C:attention}Piece of the Mischievous One",
            "or {C:attention}Cultist of the Mischievous One",
            "{C:inactive}(Must have room)"
		},
		config = {},
		pos = { x = 0, y = 1 },
        cost = 3,
        cost_mult = 1,
        effect=nil,
        consumable=true,
        discovered=true,
        can_use = function() 
            if  #G.jokers.cards < G.jokers.config.card_limit then
                return true
            end          
        end,
        use = function(self, area, copier)
            if self.ability.name == 'Mischief' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    addjoker(mischiefjoker[getjokerfromlist(mischiefjoker)])
                    self:juice_up(0.3, 0.5)
                    return true end }))
                delay(0.6)
            end
        end      
	},
    contract = {
        name = "The Contract",
        text = {
            "Creates a random",
            "{C:attention}Combat Ace Joker{}.",
            "{C:inactive}(Must have room)"
		},
		config = {},
		pos = { x = 0, y = 2 },
        cost = 3,
        cost_mult = 1,
        effect=nil,
        consumable=true,
        discovered=true,
        can_use = function() 
            if  #G.jokers.cards < G.jokers.config.card_limit then
                return true
            end          
        end,
        use = function(self, area, copier)
            if self.ability.name == 'The Contract' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    addjoker(contractjoker[getjokerfromlist(contractjoker)])
                    self:juice_up(0.3, 0.5)
                    return true end }))
                delay(0.6)
            end
        end      
	},
    cosmos = {
        name = "The Cosmos",
        text = {
            "Creates a random",
            "{C:purple}Cosmic Joker{}.",
            "{C:inactive}(Must have room)"
		},
		config = {},
		pos = { x = 1, y = 0 },
        cost = 3,
        cost_mult = 1,
        effect=nil,
        consumable=true,
        discovered=true,
        can_use = function() 
            if  #G.jokers.cards < G.jokers.config.card_limit then
                return true
            end          
        end,
        use = function(self, area, copier)    
            if self.ability.name == 'The Cosmos' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    addjoker(cosmosjoker[getjokerfromlist(cosmosjoker)])
                    self:juice_up(0.3, 0.5)
                    return true end }))
                delay(0.6)
            end            
        end      
	},
    constellation = {
        name = "The Constellation",
        text = {            
            "Up to 3 selected cards gain",
            "{C:chips}+15{} Chips permanently",
            "All {C:purple}Cosmic Jokers{} gain",
            "{C:purple}+5 Cosmic-Tokens{}.",
		},
		config = {max_highlighted = 3},
		pos = { x = 0, y = 0 },
        cost = 4,
        cost_mult = 1,
        effect=nil,
        consumable=true,
        discovered=true,
        can_use = function(self) 
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if self.ability.consumeable.max_highlighted then
                    if self.ability.consumeable.mod_num >= #G.hand.highlighted and #G.hand.highlighted >= (self.ability.consumeable.min_highlighted or 1) then
                        return true
                    end
                end
            end         
        end,
        use = function(self, area, copier)    
            if self.ability.name == 'The Constellation' then
                addtokentoallcosmic(5) 
                for i= 1, #G.hand.highlighted do
                    card = G.hand.highlighted[i]
                    card.ability.perma_bonus = card.ability.perma_bonus or 0
                    card.ability.perma_bonus=card.ability.perma_bonus+15
                    shakecard(card)
                    fakemessage(localize('k_c_upgrade'),card,G.C.PURPLE)                                    
                end             
            end            
        end,
        loc_def=function(center, info_queue)
            info_queue[#info_queue+1] = { set = 'Other', key = 'cosmic_token' }
            return {}
        end      
	},
    sign = {
        name = "The Sign",
        text = {
            "All {C:purple}Cosmic Jokers{} gain {C:purple}+10 Cosmic-Tokens{}.",
            "If you have more than 150",
            "{C:purple}Cosmic-Token{} on your Jokers,",
            "create a negative {C:legendary}Cosmic Ophiuchus."
		},
		config = {},
		pos = { x = 2, y = 0 },
        cost = 5,
        cost_mult = 1,
        effect=nil,
        consumable=true,
        discovered=true,
        can_use = function() 
            if  checkforcosmic() and not checkforcosmicophiuchus() then
                return true
            end          
        end,
        use = function(self, area, copier)    
            if self.ability.name == 'The Sign' then
                addtokentoallcosmic(10) 
                if countcosmictokens()>150 then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    addjoker('j_cosmicophiuchus',true)
                    self:juice_up(0.3, 0.5)
                    return true end }))
                delay(0.6)   
                end             
            end            
        end,
        loc_def=function(center, info_queue)
            info_queue[#info_queue+1] = { set = 'Other', key = 'cosmic_token' }
            info_queue[#info_queue+1] = { set = 'Other', key = 'ophiuchus' }
            return {}
        end      
	},
}

function SMODS.INIT.ThemedTarots()    
    G.localization.descriptions.Other["cosmic_token"] = {
        name = "Cosmic-Token",
        text = {
            "{C:purple}Cosmic Jokers{} gain",
            "{X:purple,C:white}Cosmic-Tokens{} to",
            "buff themself or",
            "other jokers."
        }
    }
    G.localization.descriptions.Other["ophiuchus"] = {
        name = "Ophiuchus",
        text = {
            "Does not create",
            "a Joker if you",
            "already have a",
            "{C:legendary}Cosmic - Ophiuchus."
        }
    }
    init_localization()

    for k, v in pairs(tarots) do
        local tarot = SMODS.Tarot:new(v.name, k, v.config, v.pos, { name = v.name, text = v.text }, v.cost, v.cost_mult, v.effect, v.consumable, v.discovered, "ThemedTarots")
        -- SMODS.Tarot:new(name, slug, config, pos, loc_txt, cost, cost_mult, effect, consumeable, discovered, atlas)
        tarot:register()
        SMODS.Tarots[tarot.slug].use=v.use
        SMODS.Tarots[tarot.slug].can_use=v.can_use
        if(v.loc_def ~= nil) then
            SMODS.Tarots[tarot.slug].loc_def=v.loc_def
        end

    end
    SMODS.Sprite:new("ThemedTarots", SMODS.findModByID("ThemedTarots").path, "ThemedTarots.png", 71, 95, "asset_atli"):register()

 

end
----------------------------------------------
------------MOD CODE END----------------------
