--- STEAMODDED HEADER
--- MOD_NAME: Themed Jokers
--- MOD_ID: ThemedJokers
--- MOD_AUTHOR: [Blizzow]
--- MOD_DESCRIPTION: A bunch of themed Jokers. WIP

----------------------------------------------
------------MOD CODE -------------------------

---UTILITY METHODS---
function destroyCard(self,sound)
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound(sound, math.random()*0.2 + 0.9,0.5)
            self.T.r = -0.2
            self:juice_up(0.3, 0.4)
            self.states.drag.is = true
            self.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                func = function()
                        G.jokers:remove_card(self)
                        self:remove()
                        self = nil
                    return true; end})) 
            return true
        end
    })) 
    self.gone = true
end




local localization = {
    combatacesoldier = {
        name = "Combat Ace - Soldier",
        text = {
            "Each scored {C:attention}Ace{}",			
			"adds {C:chips}+#1#{} Chips",
			"{C:inactive}(Being a soldier is hard. Survived #2# rounds.)"
        }
    },
    combatacemercenary = {
        name = "Combat Ace - Mercenary",
        text = {
            "Scored {C:attention}Aces{} each give {X:mult,C:white} X#1# {} Mult",			
            "At the end of a {C:attention}round{} pay {C:money}$5{},",
            "If you cannot, {C:red}destroy this joker{}",
			"{C:inactive}(Firepower, but at what cost?)"
        }        
    },
	    combatacepromotion = {
        name = "Combat Ace - Promotion",
        text = {
			"Played {C:attention}Aces{} have a",
			"{C:green}#1# in #2#{} chance to",
			"become a random edition",
			"{C:inactive}(Time for a promotion!)"
        }
    },
    combatacerecruiter = {
        name = "Combat Ace - Recruiter",
        text = {
            "Discarded cards have a",
			"{C:green}#1# in #2#{} chance to",
			"become an {C:attention}Ace{}",
			"{C:inactive}(Are you interested in joining the ACES?)"
        }
    },
    combatacegeneral = {
        name = "Combat Ace - General",
        text = {
            "{C:attention}\"Combat Ace Jokers\"{}",
            "each give {X:mult,C:white} X#1# {} Mult",
			"Also counts itself",
			"{C:inactive}(Aces = Power!)"
        }
    },
    combataceveteran = {
        name = "Combat Ace - Veteran",
        text = {            
            "Each scored {C:attention}Ace{}",			
			"repeats and adds {C:chips}+#3#{} Chips",
            "This bonus increases by {C:chips}10{} every round",
			"{C:inactive}(The peak of the ACES. Survived #2# rounds.)"
        }
    },
}

local jokers = {
	combatacesoldier = SMODS.Joker:new(
        "Combat Ace - Soldier", "",
		{extra={chips=35, counter=0}},
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
        {extra={x_mult = 1.5}},
        {}, "",
        2, 8, true, true, true, true
    ),
    combatacemercenary = SMODS.Joker:new(
        "Combat Ace - Mercenary", "",
        {extra={x_mult = 1.5}},
        {}, "",
        1, 5, true, true, true, true
    ),
    combataceveteran = SMODS.Joker:new(
        "Combat Ace - Veteran", "",
		{extra={chips=50, counter=0, bonustotal=50}},
        {}, "",
        4, 45, true, true, true, true
    ),
}

function SMODS.INIT.ThemedJokers() 
init_localization()


	for k, v in pairs(jokers) do        
        v.slug = "j_" .. k
        v.loc_txt = localization[k]
        v.spritePos = { x = 0, y = 0 }
        v:register()
        SMODS.Sprite:new(v.slug, SMODS.findModByID("ThemedJokers").path, v.slug..".png", 71, 95, "asset_atli"):register()
    end

    --- Joker abilities ---	
	---Combat Ace General:---
    SMODS.Jokers.j_combatacegeneral.calculate = function(self, context)
        if context.other_joker then
            if string.match(context.other_joker.ability.name, "Combat Ace") then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                })) 
                return {
                    message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
                    Xmult_mod = self.ability.extra.x_mult
                }
            end
        end
    end
	
	---Combat Ace Soldier:---
    SMODS.Jokers.j_combatacesoldier.calculate = function(self, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14) then
            return {
            message = localize{type='variable',key='a_chips',vars={self.ability.extra.chips}},
            chips = self.ability.extra.chips,
            card = self
            }
        end
        if context.setting_blind then
            
        end
        if context.end_of_round and not (context.individual or context.repetition) then
            self.ability.extra.counter=self.ability.extra.counter+1
            if self.ability.extra.counter>=2 then
                local edition = self:get_edition()
                destroyCard(self,'holo1')
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_combataceveteran', nil)
                card.set_edition=edition
                card:add_to_deck()
                G.jokers:emplace(card)
                card:start_materialize()
                G.GAME.used_jokers['j_combataceveteran'] = true  
                return {
                message = localize('k_promotion'),
                colour = G.C.RED,
                card = self
                }
            end      
        end
    end
	---Combat Ace Veteran:---
	SMODS.Jokers.j_combataceveteran.calculate = function(self, context)
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14) then
            return {
            message = localize{type='variable',key='a_chips',vars={self.ability.extra.bonustotal}},
            chips = self.ability.extra.bonustotal,
            card = self
            }
        end
        
        if context.repetition and context.cardarea == G.Play and (context.other_card:get_id() == 14) then            
                return {
                    message = localize('k_again_ex'),
                    repetitions = self.ability.extra,
                    card = self
                }
            end

        if context.end_of_round and not (context.individual or context.repetition) then
            self.ability.extra.counter=self.ability.extra.counter+1
            self.ability.extra.bonustotal=self.ability.extra.chips+self.ability.extra.counter*10
            return {
                message = localize('k_agedup'),
                colour = G.C.CHIPS,
                card = self
            }                    
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
						return {
							message = localize('k_promotion'),
							colour = G.C.RED,
							card = self
						}   
						end			
					end
				end
			end
		end
	end
	
    	---Combat Ace Mercenary:---
    SMODS.Jokers.j_combatacemercenary.calculate = function(self, context)
        --if played card is an ace add x1.5 mult   
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 14) then           
            return {
                message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
                x_mult = self.ability.extra.x_mult 
            }
        end
        if context.end_of_round and not (context.individual or context.repetition) then
            if G.GAME.dollars>5 then
                ease_dollars(-5)
                return {
                    message = localize('k_mercenary_pay'),
                    colour = G.C.RED,
                    card = self
                } 
            else
               destroyCard(self,'glass5')
               return {
                message = localize('k_mercenary_destroy'),
                colour = G.C.RED,
                card = self
            }          
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
			if card:get_id() == 14 then return nil end
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.5, 0.5)
                    return true
                end
            }))
            card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
            return {
                message = localize('k_recruit'),
                card = card,
                colour = G.C.CHIPS
            }
            end
        end
    end


	---localization texts:---
    G.localization.misc.dictionary.k_agedup = "Aged up!"
    G.localization.misc.dictionary.k_recruit = "Recruited!"
	G.localization.misc.dictionary.k_promotion = "Promoted!"
    G.localization.misc.dictionary.k_mercenary_pay = "Payday!"
    G.localization.misc.dictionary.k_mercenary_destroy = "Mercenary has left the party!"


	
	
	
	

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
		
        
        --ADD ALL MODDED JOKERS HERE:--   
        --Combat Aces:--
        if string.match(self.ability.name, "Combat Ace") then
            customJoker = true
            if self.ability.name == 'Combat Ace - General' then
                loc_vars = {self.ability.extra.x_mult}

            elseif self.ability.name == 'Combat Ace - Mercenary' then
                loc_vars = {self.ability.extra.x_mult}

            elseif self.ability.name == 'Combat Ace - Promotion' then
                loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds}

            elseif self.ability.name == 'Combat Ace - Recruiter' then
                loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds}

            elseif self.ability.name == 'Combat Ace - Soldier' then
                loc_vars = {self.ability.extra.chips, self.ability.extra.counter}

            elseif self.ability.name == 'Combat Ace - Veteran' then
                loc_vars = {self.ability.extra.chips, self.ability.extra.counter, self.ability.extra.bonustotal}

            end
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
