local jokerInfo = {   
    key = "mc_piece2",
    pos = { x = 1, y = 3 },
    atlas = 'ThemedJokersRetriggered',
    rarity = 1,
    cost = 0,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    pools = { 
       ['tjr_pool_mischief'] = true,
       Tarot = true,
       Spectral = true,
       Planet = true,     
    },
    config = {extra = {}},
    set_ability = function(self, card, initial)
        card:set_edition("e_negative", true)
    end,
    loc_vars = function(self, info_queue, card)      
        return { vars = { G.GAME.pool_flags.tjr_mischief_pieces or 0} }
    end,
    in_pool = function(self, args) 
        return (G.GAME.pool_flags.tjr_mischief_active and (G.GAME.pool_flags.tjr_mischief_pieces or 0) == 1)
    end,
    add_to_deck = function(self, card, from_debuff)
        play_sound('tjr_clown_laugh_short')
        TJR.funcs.fakemessage(localize('k_mischief_piece_add'), card, G.C.RED)
        SMODS.destroy_cards(card)
    end,
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME.pool_flags.tjr_mischief_pieces then
            G.GAME.pool_flags.tjr_mischief_pieces=G.GAME.pool_flags.tjr_mischief_pieces+1
            if G.GAME.pool_flags.tjr_mischief_pieces >= 4 then
                local voucher_card = SMODS.create_card({area = G.play, key = 'v_tjr_mc_awakening'})
                voucher_card:start_materialize()
                voucher_card.cost = 0
                G.play:emplace(voucher_card)            
                delay(0.8)            
                voucher_card:redeem()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        voucher_card:start_dissolve()                
                        return true
                    end
                }))
            end
        else
            G.GAME.pool_flags.tjr_mischief_pieces=1
        end
    end
}
return jokerInfo
