TJR.funcs = {
 destroyCard = function(card, sound, after)
        G.E_MANAGER:add_event(Event({
            func = function()
                card.T.r = -0.2
                card:juice_up(0.3, 0.4)
                card.states.drag.is = true
                card.children.center.pinch.x = true
                play_sound(sound, 1.0, 0.8)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    blockable = false,
                    func = function()
                        card:remove()
                        if after and type(after) == "function" then
                            after()
                        end
                        return true
                    end
                }))
                return true
            end
        }))
    end,


shakecard = function(card)
    G.E_MANAGER:add_event(Event({
        func = function()
            card:juice_up(0.5, 0.5)
            return true
        end
    }))
end,

--Sends a message without the need for a return in the calculate function
fakemessage = function(_message,_card,_colour)
    G.E_MANAGER:add_event(Event({ trigger = 'after',delay = 0.15,       
        func = function() card_eval_status_text(_card, 'extra', nil, nil, nil, {message = _message, colour = _colour, instant=true}); return true
        end}))
    return
end,
--Sets random edition with animation
random_edition = function(card, seed, overwrite)
    -- If overwrite is nil, only change cards without editions
    -- If overwrite is anything else, force change the edition regardless
    if overwrite == nil and card:get_edition() ~= nil then return nil end
    
    local edition = poll_edition(seed or 'tjr_random_edition' .. G.GAME.round_resets.ante, nil, true, true)
    
             G.E_MANAGER:add_event(Event({
             delay = 0.2,
             trigger = 'before', 
             func = function()
                 play_sound('card1', 0.85)
                 card:juice_up(0.3, 0.4)
                 card:set_edition(edition, true)
                 return true 
             end
         }))
     end,

--changes rank with animation
changerank = function(card, seed, rank)
    if rank == nil then
        local rank_seed = seed or 'tjr_random_rank' .. G.GAME.round_resets.ante
        local new_rank = pseudorandom_element(SMODS.Ranks, pseudoseed(rank_seed)).key
        rank = new_rank
    end        
    sendDebugMessage('CHANGERANK ' .. rank)
    SMODS.change_base(card, nil, rank)

    G.E_MANAGER:add_event(Event({
        delay = 0.2,
        trigger = 'after', 
        func = function()
            play_sound('card1', 0.85)
            card:juice_up(0.3, 0.4)
            return true 
        end
    }))
end,

--Sets ability with animation
set_ability = function(card, ability, overwrite, trigger)
    if overwrite == nil and next(SMODS.get_enhancements(scored_card)) ~= nil then return nil end
    
    G.E_MANAGER:add_event(Event({
        delay = 0.2,
        trigger = trigger or 'after', 
        func = function()
            play_sound('card1', 0.85)
            card:juice_up(0.3, 0.4)
            card:set_ability(ability, nil, true)
            sendDebugMessage('SET ABILITY ' .. ability)
            return true 
        end
    }))
end,


SpreadInfection = function(card, contaigon)
    local non_infected_cards ={}
    for _, deck_card in ipairs(G.deck.cards) do
        if not SMODS.has_enhancement(deck_card, 'm_tjr_infected') then
            table.insert(non_infected_cards, deck_card)
        end
    end
    if non_infected_cards then
        local _card = pseudorandom_element(non_infected_cards, pseudoseed('infected'))
        if _card then
            _card:set_ability('m_tjr_infected', nil, true)         
            if contaigon==true then
                if card.edition then
                    _card:set_edition(card.edition, true)
                end
                if card.seal then
                    _card:set_seal(card.seal)
                end
            end
        return { message = localize('k_infected_spread'), colour = G.C.GREEN, card=card }
        end
    end
end
}


