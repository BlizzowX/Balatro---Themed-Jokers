local jokerInfo = {   
    key = "in_potency",
    pos = { x = 1, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { } },  
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and context.poker_hands then
            if next(context.poker_hands["tjr_patient_zero"]) or next(context.poker_hands["tjr_outbreak"]) or next(context.poker_hands["tjr_epidemic"]) or next(context.poker_hands["tjr_plague"]) or next(context.poker_hands["tjr_global_pandemic"]) then
                return {
                    level_up = true,
                    message = localize('k_potency_level_up')
                }
            end
        end
    end
}
return jokerInfo