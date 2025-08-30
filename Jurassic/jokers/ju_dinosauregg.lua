local jokerInfo = {   
    key = "ju_dinosauregg",
    pos = { x = 11, y = 1 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    config = { extra = {hatchtime = 3, rounds=0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "tt_trex", set = "Other"}
        info_queue[#info_queue+1] = {key = "tt_mosasaurus", set = "Other"}
        info_queue[#info_queue+1] = {key = "tt_brachiosaurus", set = "Other"}
        info_queue[#info_queue+1] = {key = "tt_quetzalcoatlus", set = "Other"}
        info_queue[#info_queue+1] = {key = "tt_dinosauregg_fossil", set = "Other"}
        
        return { vars = { card.ability.extra.hatchtime, card.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)      
     
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds >= card.ability.extra.hatchtime then
                TJR.funcs.fakemessage(localize('k_dinosauregg_hatch'), card, G.C.YELLOW)
                SMODS.destroy_cards(card)    
                SMODS.add_card({set='tjr_pool_dinosauregg'})
            end
        end
    end    
}
return jokerInfo
