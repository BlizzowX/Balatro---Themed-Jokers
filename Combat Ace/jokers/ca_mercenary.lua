local jokerInfo = {   
    key = "ca_mercenary",
    pos = { x = 2, y = 0 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    config =  {extra={xmult=1.5, cost=6}},  
    loc_vars = function(self, info_queue, card)
        
        return { vars = { card.ability.extra.xmult, card.ability.extra.cost } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14) then         
            return { 
                xmult = card.ability.extra.xmult 
            }            
        end
        if context.end_of_round and context.cardarea == G.jokers then
           -- TJR.funcs.shakecard(card)
            if G.GAME.dollars>=card.ability.extra.cost then
                ease_dollars(-card.ability.extra.cost)
                return {
                    message = localize('k_mercenary_pay'),
                    colour = G.C.RED,
                    card = card
                }
            else
                ease_dollars(-G.GAME.dollars)
                TJR.funcs.fakemessage(localize('k_mercenary_destroy'), card, G.C.RED)
                SMODS.destroy_cards(card)
            end 
        end
    end
}
return jokerInfo