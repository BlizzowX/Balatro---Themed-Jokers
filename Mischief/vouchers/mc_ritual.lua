local voucherInfo = {
    key = "mc_ritual",
    pos = {x=0,y=0},
    atlas = 'ThemedJokersRetriggered_vouchers',
    discovered = true,
    unlocked = true,
    redeem = function(self)
        G.GAME.pool_flags.tjr_mischief_active = true
    end
}
return voucherInfo