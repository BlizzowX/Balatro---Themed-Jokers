local jokerInfo = {   
    key = "ju_fossil_egg",
    pos = { x = 11, y = 1 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_dinosauregg'] = true },
    config = {extra = {dollars = 3}},
    loc_vars = function(self, info_queue, card)        
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.dollars } }
    end,
    in_pool = function(self, args) 
        return false
    end,
    calculate = function(self, card, context)      
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end    
}
return jokerInfo
