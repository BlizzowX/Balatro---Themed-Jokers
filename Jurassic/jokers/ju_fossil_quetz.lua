local jokerInfo = {   
    key = "ju_fossil_quetz",
    pos = { x = 4, y = 1 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_fossil'] = true },
    config = {extra = {xmult = 1.5}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = { card.ability.extra.xmult } }
    end,
    in_pool = function(self, args) 
        return G.GAME.pool_flags.tjr_quetz_extinct
    end,
    calculate = function(self, card, context)      
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 or SMODS.has_enhancement(context.other_card, 'm_stone') then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end    
}
return jokerInfo
