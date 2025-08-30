local blindInfo = {
    key = 'ca_desertation',
    pos = { x = 0, y = 0 },
    atlas = 'ThemedJokersRetriggered_blinds',
    mult = 2,
    dollars = 5,
    discovered=true,
    boss = { min = 1 },
    boss_colour = HEX('4E554A'),
    recalc_debuff = function(self, card, from_blind)
        if card.area ~= G.jokers and not G.GAME.blind.disabled then
            local v = card.base.value
            if v == "Ace" then
                return true
            end
        end
        return false
    end
}
return blindInfo