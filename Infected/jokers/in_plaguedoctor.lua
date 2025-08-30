local jokerInfo = {   
    key = "in_plaguedoctor",
    pos = { x = 5, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { xmult=1, xmult_per_infected = 0.2, xmult_total=1 } },
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                return true
            end
        end
        return false
    end,
    loc_vars = function(self, info_queue, card)
        local infected_count = 0
        if G.deck then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                    infected_count = infected_count + 1                    
                end
            end
        end
        card.ability.extra.xmult_total = 1 + (infected_count * card.ability.extra.xmult_per_infected)
        return { vars = { card.ability.extra.xmult_per_infected, card.ability.extra.xmult_total } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local infected_count = 0
            if G.deck then
                for _, playing_card in ipairs(G.playing_cards) do
                    if SMODS.has_enhancement(playing_card, 'm_tjr_infected') then
                        infected_count = infected_count + 1                    
                    end
                end
            end
            card.ability.extra.xmult_total = 1 + (infected_count * card.ability.extra.xmult_per_infected)
            return {xmult=card.ability.extra.xmult_total}
        end
    end
}
return jokerInfo
