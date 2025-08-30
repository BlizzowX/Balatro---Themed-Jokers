local pokerhandInfo = {
    key = "global_pandemic",
    mult = 10,
    chips = 85,
    l_mult = 1,
    l_chips = 35,
    example = {
        { 'S_A', true, enhancement = 'm_tjr_infected' },
        { 'D_Q', true, enhancement = 'm_tjr_infected' },
        { 'D_9', true, enhancement = 'm_tjr_infected' },
        { 'C_4', true, enhancement = 'm_tjr_infected' },
        { 'D_3', true, enhancement = 'm_tjr_infected' }
    },
    above_hand = "Straight Flush",
    visible = false,
    evaluate = function(parts, hand)
        local infected_cards = {}
        for _, card in ipairs(hand) do
            if SMODS.has_enhancement(card, 'm_tjr_infected') then
                table.insert(infected_cards, card)
            end
        end
        if #infected_cards >= 5 then
            return infected_cards
        end
        return {}
    end
}

return pokerhandInfo
