local jokerInfo = {   
    key = "ca_recruiter",
    pos = { x = 4, y = 0 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {extra = {odds = 10}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'tjr_recruiter' .. G.GAME.round_resets.ante)
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.discard then
             if SMODS.pseudorandom_probability(card, 'tjr_recruiter' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds) then
                TJR.funcs.changerank(context.other_card, 'tjr_recruiter_rank' .. G.GAME.round_resets.ante, 'Ace')                
                TJR.funcs.fakemessage(localize('k_recruiter_success'), card, G.C.ATTENTION)                
             end
         end
    end
}
return jokerInfo
