local pokerhandInfo = {
    key = "patient_zero",
    mult = 2,
    chips = 25,
    l_mult = 1,
    l_chips = 15,
    example = {
        { 'S_A', true, enhancement = 'm_tjr_infected' },
        { 'D_Q', false },
        { 'D_9', false },
        { 'C_4', false },
        { 'D_3', false }
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
        if #infected_cards == 1 then
            return infected_cards
        end
        return {}
    end
}

return pokerhandInfo