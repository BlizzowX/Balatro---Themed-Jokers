local jokerInfo = {   
    key = "ca_supplies",
    pos = { x = 1, y = 0 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config =  {extra={dollars=3, counter=3}},  
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.counter } }
    end,
    calculate = function(self, card, context)
    if context.discard and not context.other_card.debuff and context.other_card:get_id()==14 then        
        TJR.funcs.shakecard(card)
        if not context.blueprint then
            card.ability.extra.counter=card.ability.extra.counter-1
        end     
        if card.ability.extra.counter==0 then
            card.ability.extra.counter=3
            ease_dollars(card.ability.extra.dollars)
            if not context.blueprint then
                card.ability.extra.dollars=card.ability.extra.dollars+1
            end
            return {
                message = localize('k_supplydrop'),
                card = card,
                colour = G.C.YELLOW
                    }          
            else
            return {
            message = localize('k_supplies_up'),
            card = card,
            colour = G.C.YELLOW
            }
        end
    end
end, 
    }
return jokerInfo