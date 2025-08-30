local backInfo = {
    key = "ju_debug",
    atlas = 'ThemedJokersRetriggered_backs',
    pos = { x = 1, y = 0 },
    unlocked = true,
 config = { vouchers = {'v_tjr_mc_ritual'}, jokers = {'j_tjr_ju_excavation'},dollars=2000 ,hand_size=10, hands = 50, discards = 50, booster_rerolls = 500 },
 apply = function(self, back)
    add_booster_rerolls(self.config.booster_rerolls)
end
}

return backInfo