local jokerInfo = {   
    key = "ju_brachiosaurus",
    pos = { x = 3, y = 1 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config = { extra = { odds = 12, mult = 8 } },
    pools = { ['tjr_pool_dinosaur'] = true, ['tjr_pool_dinosauregg'] = true },
    in_pool = function(self, args) 
        if G.GAME.pool_flags.tjr_brachio_extinct then
            return false
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        local jacks_and_stones = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 11 or SMODS.has_enhancement(playing_card, 'm_stone') then jacks_and_stones = jacks_and_stones + 1 end
            end
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'tjr_brachio_extinct' .. G.GAME.round_resets.ante)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult*jacks_and_stones, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'tjr_brachio_extinct', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                G.GAME.pool_flags.tjr_brachio_extinct = true
                return {
                    message = localize('k_extinction')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        
        if context.joker_main then
            -- Calculate mult for Jacks and Stone Cards in deck
            local jacks_and_stones = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 11 or SMODS.has_enhancement(playing_card, 'm_stone') then
                    jacks_and_stones = jacks_and_stones + 1                    
                end
            end
            if jacks_and_stones > 0 then            
                return {
                    mult = card.ability.extra.mult*jacks_and_stones
                }
            end
        end
    end    
}
return jokerInfo
