local jokerInfo = {   
    key = "in_contaigon",
    pos = { x = 3, y = 2 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = {} },
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
    add_to_deck = function(self, card, from_debuff)
        TJR.contaigon = true
    end,
    remove_from_deck = function(self, card, from_debuff)
        TJR.contaigon = false
    end
}
return jokerInfo
