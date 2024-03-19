--- STEAMODDED HEADER
--- MOD_NAME: Themed Jokers
--- MOD_ID: ThemedJokers
--- MOD_AUTHOR: [Blizzow]
--- MOD_DESCRIPTION: A bunch of themed Jokers. WIP

----------------------------------------------
------------MOD CODE -------------------------

local localization = {
    combatacesoldier = {
        name = "Combat Ace - Soldier",
        text = {
            "Played {C:attention}Aces{} in",
			"scored hand",
			"add {C:chips}+#1#{} Chips",
			"{C:inactive}(---)"
        }
    },
	    combatacepromotion = {
        name = "Combat Ace - Promotion",
        text = {
			"Played {C:attention}Aces{} have a",
			"{C:green}#1# in #2#{} chance to",
			"become a random edition",
			"{C:inactive}(---)"
        }
    },
    combatacerecruiter = {
        name = "Combat Ace - Recruiter",
        text = {
            "Discarded cards have",
			"{C:green}#1# in #2#{} chance to",
			"become an {C:attention}Ace{}",
			"{C:inactive}(---)"
        }
    },
    combatacegeneral = {
        name = "Combat Ace - General",
        text = {
            "{C:attention}\"Combat Ace Jokers\"{}",
            "each give {X:mult,C:white} X#1# {} Mult",
			"Also counts itself",
			"{C:inactive}(---)"
        }
    },
}

local jokers = {
	combatacesoldier = SMODS.Joker:new(
        "Combat Ace - Soldier", "",
		{extra={chips=35}},
        {}, "",
        1, 4, true, true, true, true
    ),
	combatacepromotion = SMODS.Joker:new(
        "Combat Ace - Promotion", "",
        {extra={odds = 6}},
        {}, "",
        3, 12, true, true, false, true
    ),
    combatacerecruiter = SMODS.Joker:new(
        "Combat Ace - Recruiter", "",
        {extra={odds = 8}},
        {}, "",
        3, 12, true, true, false, true
    ),
    combatacegeneral = SMODS.Joker:new(
        "Combat Ace - General", "",
        {extra={xmult = 1.5}},
        {}, "",
        2, 8, true, true, true, true
    ),
}

local jokerBlacklists = {
    j_combatacerecruiter = false,
    j_combatacegeneral = false,
	j_combatacesoldier = false,
	j_combatacepromotion = false
}

function SMODS.INIT.ThemedJokers() 
    init_localization()


	for k, v in pairs(jokers) do
        if not jokerBlacklists[k] then
            v.slug = "j_" .. k
            v.loc_txt = localization[k]
            v.spritePos = { x = 0, y = 0 }
            v:register()
            SMODS.Sprite:new(v.slug, SMODS.findModByID("ThemedJokers").path, v.slug..".png", 71, 95, "asset_atli"):register()
        end
    end

    --- Joker abilities ---
	
	
	
	
	---Combat Ace General:---
    SMODS.Jokers.j_combatacegeneral.calculate = function(self, context)
        if context.other_joker and context.other_joker then
            if string.match(context.other_joker.ability.name, "Combat Ace") then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                return {
                    message = localize{type='variable',key='a_xmult',vars={self.ability.extra.xmult}},
                    Xmult_mod = self.ability.extra.xmult
                }
            end
        end
    end
	
	---Combat Ace Soldier:---
    SMODS.Jokers.j_combatacesoldier.calculate = function(self, context)
      if self.ability.set == "Joker" and not self.debuff then	
		if context.individual then
            if context.cardarea == G.play then				
                for i = 1, #context.scoring_hand do                    
					local card=context.scoring_hand[i]
					if card:get_id() ~= 14 then return nil end
					return {
					 message = localize{type='variable',key='a_chips',vars={self.ability.extra.chips}},
                      chips = self.ability.extra.chips,
                      card = self
                    }
				end
				end				
            end
        end
    end
	
	---Combat Ace Promotion:---
    SMODS.Jokers.j_combatacepromotion.calculate = function(self, context)
	if self.ability.set == "Joker" and not self.debuff then	
		if context.individual then
            if context.cardarea == G.play then	
				for i = 1, #context.scoring_hand do
					local card=context.scoring_hand[i]
					if pseudorandom('promotion') < G.GAME.probabilities.normal / self.ability.extra.odds and card:get_id()==14 then						
						if card:get_edition() ~= nil then return nil end
						local edition = poll_edition('promotion', nil, true, true)
						G.E_MANAGER:add_event(Event({
							func = (function()
								card:set_edition(edition, true)
								return true
							end)
						}))
						local color = G.C.MULT
						if edition ~= nil and edition.foil then color = G.C.CHIPS end
						return {
							extra = { message = localize('k_promotion'), colour = color },
							colour = color,
							card = self
						}   
						end			
					end
				end
			end
		end
	end
	
	---Combat Ace Recruiter:---
    SMODS.Jokers.j_combatacerecruiter.calculate = function(self, context)
        if context.discard and not context.other_card.debuff and
        pseudorandom('recruiter') < G.GAME.probabilities.normal/self.ability.extra.odds then
            local card=context.other_card
            local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
			local rank_suffix='A'
			if context.other_card:get_id() == 14 then return nil end
            card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
            return {
                message = localize('k_recruit'),
                card = card,
                colour = G.C.CHIPS
            }
        end
    end


	---localization texts:---
    G.localization.misc.dictionary.k_recruit = "Recruited!"
	G.localization.misc.dictionary.k_promotion = "Promoted!"	
end	
	
	
	
	
	
	-- UIBox garbage / Copied from LushMod. Thanks luscious!
local generate_UIBox_ability_tableref = Card.generate_UIBox_ability_table
function Card.generate_UIBox_ability_table(self)
    local card_type, hide_desc = self.ability.set or "None", nil
    local loc_vars = nil
    local main_start, main_end = nil, nil
    local no_badge = nil

    if self.config.center.unlocked == false and not self.bypass_lock then    -- For everyting that is locked
    elseif card_type == 'Undiscovered' and not self.bypass_discovery_ui then -- Any Joker or tarot/planet/voucher that is not yet discovered
    elseif self.debuff then
    elseif card_type == 'Default' or card_type == 'Enhanced' then
    elseif self.ability.set == 'Joker' then
        local customJoker = false
		--ADD ALL MODDED JOKERS HERE--
        if self.ability.name == 'Combat Ace - Recruiter' or self.ability.name == 'Combat Ace - General' or self.ability.name == 'Combat Ace - Promotion' or self.ability.name == 'Combat Ace - Soldier' then
            customJoker = true
        end
		--EXTRA ABILITIES:--
        if self.ability.name == 'Combat Ace - General'then
            loc_vars = {self.ability.extra.xmult}
		--ODDS ABILITIES:--
        elseif self.ability.name == 'Combat Ace - Recruiter' or self.ability.name == 'Combat Ace - Promotion' then loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds}
        --CHIPS ABILITIES:--
		elseif self.ability.name == 'Combat Ace - Soldier' then
		loc_vars = {self.ability.extra.chips}
		end
        if customJoker then
            local badges = {}
            if (card_type ~= 'Locked' and card_type ~= 'Undiscovered' and card_type ~= 'Default') or self.debuff then
                badges.card_type = card_type
            end
            if self.ability.set == 'Joker' and self.bypass_discovery_ui and (not no_badge) then
                badges.force_rarity = true
            end
            if self.edition then
                if self.edition.type == 'negative' and self.ability.consumeable then
                    badges[#badges + 1] = 'negative_consumable'
                else
                    badges[#badges + 1] = (self.edition.type == 'holo' and 'holographic' or self.edition.type)
                end
            end
            if self.seal then
                badges[#badges + 1] = string.lower(self.seal) .. '_seal'
            end
            if self.ability.eternal then
                badges[#badges + 1] = 'eternal'
            end
            if self.pinned then
                badges[#badges + 1] = 'pinned_left'
            end

            if self.sticker then
                loc_vars = loc_vars or {};
                loc_vars.sticker = self.sticker
            end

            local center = self.config.center
            return generate_card_ui(center, nil, loc_vars, card_type, badges, hide_desc, main_start, main_end)
        end
    end
    return generate_UIBox_ability_tableref(self)
end



----------------------------------------------
------------MOD CODE END----------------------
