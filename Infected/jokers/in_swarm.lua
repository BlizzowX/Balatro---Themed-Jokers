local jokerInfo = {   
    key = "in_swarm",
    pos = { x = 4, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = {repetitions = 1} },
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
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_tjr_infected') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}
return jokerInfo
