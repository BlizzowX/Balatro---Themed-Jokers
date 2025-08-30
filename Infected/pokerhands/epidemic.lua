local pokerhandInfo = {
    key = "epidemic",
    mult = 5,
    chips = 50,
    l_mult = 1,
    l_chips = 25,
    example = {
        { 'S_A', true, enhancement = 'm_tjr_infected' },
        { 'D_Q', true, enhancement = 'm_tjr_infected' },
        { 'D_9', true, enhancement = 'm_tjr_infected' },
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
        if #infected_cards == 3 then
            return infected_cards
        end
        return {}
    end
}
return pokerhandInfo
