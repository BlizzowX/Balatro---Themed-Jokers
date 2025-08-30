local jokerInfo = {   
    key = "ju_museum",
    pos = { x = 9, y = 1 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = {extra = {money= 1}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        local money_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
              if  SMODS.has_enhancement(playing_card, 'm_stone') then money_tally = money_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.money, card.ability.extra.money * money_tally } }
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_stone'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end,
    calc_dollar_bonus = function(self, card)
        local money_tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then money_tally = money_tally + 1 end
        end
        return money_tally > 0 and card.ability.extra.money * money_tally or nil
    end
}
return jokerInfo
