local jokerInfo = {   
    key = "ju_trex",
    pos = { x = 1, y = 1 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { ['tjr_pool_dinosaur'] = true, ['tjr_pool_dinosauregg'] = true },
    config = { extra = { odds = 12, chips_bonus = 5, mult_bonus = 2 } },
    in_pool = function(self, args) 
        if G.GAME.pool_flags.tjr_rex_extinct then
            return false
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'tjr_rex_extinct' .. G.GAME.round_resets.ante)
        return { vars = { card.ability.extra.chips_bonus, card.ability.extra.mult_bonus, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'tjr_rex_extinct', 1, card.ability.extra.odds) then
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
                G.GAME.pool_flags.tjr_rex_extinct = true
                return {
                    message = localize('k_extinction')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        
        if context.scoring_hand then
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 13 or SMODS.has_enhancement(context.other_card, 'm_stone') then
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips_bonus
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                    context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult_bonus

                    return {
                        extra = { message = localize('k_upgrade_ex'), colour = G.C.ATTENTION },
                        card = card
                    }
                end
            end
        end
    end    
}
return jokerInfo
