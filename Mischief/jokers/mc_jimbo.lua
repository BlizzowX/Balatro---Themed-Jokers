local jokerInfo = {   
    key = "mc_jimbo",
    pos = { x = 5, y = 3 },
    soul_pos = { x = 6, y = 3 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {extra = {}},
    set_ability = function(self, card, initial)
        card:set_edition("e_negative", true)
    end,
    loc_vars = function(self, info_queue, card)      
        return { vars = { } }
    end,
    in_pool = function(self, args) 
        return false
    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound('tjr_clown_laugh')
    end,
    calculate = function(self, card, context)
        
    end
}
return jokerInfo
