local jokerInfo = {   
    key = "in_superspreadder",
    pos = { x = 7, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { odds = 4} },
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'tjr_superspreadder' .. G.GAME.round_resets.ante)
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_tjr_infected') and
        SMODS.pseudorandom_probability(card, 'tjr_superspreadder' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds) then
            TJR.funcs.SpreadInfection(context.other_card, TJR.contaigon)
            return {message=localize('k_infected_spread'), colour=G.C.GREEN, card=card}
        end
    end
}
return jokerInfo
