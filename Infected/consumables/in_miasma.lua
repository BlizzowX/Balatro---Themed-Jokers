local consumableInfo = {
    key = 'in_miasma',
    set = 'Spectral',
    atlas = 'ThemedJokersRetriggered_spectrals',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,    
    use = function(self, card, area, copier)
        if G.playing_cards then
            for i=1, 5 do
            TJR.funcs.SpreadInfection(card, TJR.contaigon)
            end
        end
    end,
        
    can_use = function(self, card)
       if G.playing_cards then
        return true
       end
       return false
    end
}

return consumableInfo