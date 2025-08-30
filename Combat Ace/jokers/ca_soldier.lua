local jokerInfo = {   
    key = "ca_soldier",
    pos = { x = 0, y = 0 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { chips = 35 } },  
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14) then
            return {                
                chips = card.ability.extra.chips,
                }
        end
    end    
    }
return jokerInfo