local jokerInfo = {   
    key = "in_pulcinella",
    pos = { x = 8, y = 2 },
    soul_pos = { x = 9, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = {repetitions = 0} },
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.poker_hands then
            if next(context.poker_hands["tjr_patient_zero"]) or next(context.poker_hands["tjr_outbreak"]) or next(context.poker_hands["tjr_epidemic"]) or next(context.poker_hands["tjr_plague"]) or next(context.poker_hands["tjr_global_pandemic"]) then
                local infected_cards = 0
                for _, held_card in ipairs(G.hand.cards) do
                    if SMODS.has_enhancement(held_card, 'm_tjr_infected') then
                        infected_cards = infected_cards + 1
                    end
                end
                if infected_cards > 0 then
                    return {
                        repetitions = infected_cards
                    }
                end
            end
        end
    end




    
}
return jokerInfo
