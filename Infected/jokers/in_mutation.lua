local jokerInfo = {   
    key = "in_mutation",
    pos = { x = 0, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { infected_xmult=1.2 } },  
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_tjr_infected
        return { vars = { card.ability.extra.infected_xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card and SMODS.has_enhancement(context.other_card, 'm_tjr_infected') then
            context.other_card.ability.x_mult = card.ability.extra.infected_xmult
        end
        if context.before and context.main_eval and not context.blueprint then
            local enhanced_cards = 0
            for _, c in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(c, 'm_tjr_infected') then
                    c.ability.x_mult = card.ability.extra.infected_xmult
                end
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, c in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(c, 'm_tjr_infected') then
                c.ability.x_mult = 1
            end
        end
    end  
}
return jokerInfo