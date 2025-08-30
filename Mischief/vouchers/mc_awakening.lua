local voucherInfo = {
    key = "mc_awakening",
    pos = {x=1,y=0},
    atlas = 'ThemedJokersRetriggered_vouchers',
    discovered = true,
    unlocked = true,
    in_pool = function(self, args)
        return false
    end,
    redeem = function(self)
        SMODS.add_card({key='j_tjr_mc_jimbo'})
    end
}
return voucherInfo