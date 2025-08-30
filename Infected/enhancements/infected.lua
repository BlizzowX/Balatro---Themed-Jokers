local enhancementInfo = {
    key = 'infected',
    pos = {x = 0, y = 0},
    atlas = 'ThemedJokersRetriggered_enhancements',
    config = {x_mult=2, bonus=5, hold_x_chips=2, hold_negative_x_chips=0.90, contaigon=false },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)     
        info_queue[#info_queue+1] = {key = "tt_infection", set = "Other"}
        info_queue[#info_queue+1] = {key = "tt_infected_pokerhand", set = "Other"}
        return { vars = {card.ability.hold_x_chips, card.ability.hold_negative_x_chips } }
    end,
    calculate = function(self, card, context, effect)
        local infected_cards = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then infected_cards = infected_cards + 1 end
            end
            card.bonus=infected_cards or 0
        end

        if context.main_scoring and context.cardarea == G.hand then
            if next(context.poker_hands["tjr_patient_zero"]) or next(context.poker_hands["tjr_outbreak"]) or next(context.poker_hands["tjr_epidemic"]) or next(context.poker_hands["tjr_plague"]) or next(context.poker_hands["tjr_global_pandemic"]) then
                return {xchips=card.ability.hold_x_chips}
            else
                return {xchips=card.ability.hold_negative_x_chips}
            end
        end
        if context.end_of_round and context.game_over == false then
            if G.deck.cards then
                TJR.funcs.SpreadInfection(card, TJR.contaigon)
                return {message=localize('k_infected_spread'), colour=G.C.GREEN, card=card}
            end
        end
    end
}

return enhancementInfo