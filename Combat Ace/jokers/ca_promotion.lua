local jokerInfo = {   
    key = "ca_promotion",
    pos = { x = 3, y = 0 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {extra = {odds = 6}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,'tjr_promotion' .. G.GAME.round_resets.ante)
        return { vars = { numerator, denominator } }
    end,
         calculate = function(self, card, context)
         if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14 and context.other_card:get_edition() == nil) then
             if SMODS.pseudorandom_probability(card, 'tjr_promotion' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds) then
                local played_card = context.other_card
                TJR.funcs.fakemessage(localize('k_promotion_success'), card, G.C.CHIPS)
                TJR.funcs.random_edition(played_card, 'tjr_promotion' .. G.GAME.round_resets.ante)
                
             end
         end
     end
}
return jokerInfo
