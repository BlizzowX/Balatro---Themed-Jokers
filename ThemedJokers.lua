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

function shakecard(self)
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

function randomFromTable(source)
    local keys = {} 

    for k in pairs(source) do
        table.insert(keys, k)
    end

    --G.P_Tags Tags
    --G.P_Cards
    --G.P_Seals
    local choiceIndex = math.random(1,#keys) 
    local choiceKey = keys[choiceIndex] 
    local choice = source[choiceKey]
    return {key = choiceKey, value = choice}
end

function addcountertocosmo()
    for i= 1, #G.jokers.cards do
        other_joker = G.jokers.cards[i]
        if other_joker.ability.name=="Cosmic - Virgo" then
            other_joker.ability.extra.counter=other_joker.ability.extra.counter+1
            shakecard(other_joker)
        end        
    end
end       


local seals={"Gold", "Purple", "Blue", }



local localization = {
    combatacesoldier = {
        name = "Combat Ace - Soldier",
        text = {
            "Each scored {C:attention}Ace{}",			
			"adds {C:chips}+#1#{} Chips",
			"{C:inactive}(Being a soldier is hard. Survived #2# rounds.)"
        }
    },
    combatacesecretagent = {
        name = "Combat Ace - Secret Agent",
        text = {
            "Copies the effect of the {C:attention}Combat Ace{}",			
			"to it's right.",
            "{C:green}#1#{}",
            "{C:inactive}(An enigma of the ACES)",
        }
    },
    combatacesupplies = {
        name = "Combat Ace - Supplies",
        text = {
            "For every {C:red}3 discarded{} ",			
			"{C:attention}Aces{} get {C:yellow}#1#${}. This bonus ",
            "increases by {C:yellow}$1{} every time it activates",
			"{C:inactive}(Sustain is important! Next supply drop in: #2#)"
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
            " {C:red}Discarded cards{} have a",
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

    cosmiclibra = {
        name = "Cosmic - Libra",
        text = {            
            "Scored Cards add half of their",
            "{C:chips}Chips{} value as {C:red}Mult{}",
            "Retrigger played {C:attention}10{} cards.",				
			"{C:inactive}(Libra brings balance to all)"
        }        
    },
    cosmicgemini = {
        name = "Cosmic - Gemini",
        text = {            
            "Every 2 scored cards of",
            "the same rank add {X:mult,C:white} X#1# {} Mult",
            "Retrigger played {C:attention}6{} cards.",				
            "{C:inactive}(Two are better than one.)"
        }
    },
    cosmicleo = {
        name = "Cosmic - Leo",
        text = {
            "When a played card is retriggered",
			"by another {C:attention}\"Cosmic\" Joker{},",
            "{C:green}#1# in #2#{} chance to retrigger it again.",
            "Retrigger played {C:attention}King{} cards.",	
			"{C:inactive}(The mighty Leo rules over them.)"
        }
    },
    cosmicvirgo = {
        name = "Cosmic - Virgo",
        text = {
            "When {C:attention}\"Cosmic\" Joker{} retrigger played cards,",
			"add {X:purple,C:white}Cosmic-Tokens{} to this card.",
            "Retrigger played {C:attention}Queen{} cards.",	
            "{C:inactive}({C:purple}Cosmic-Tokens{}{C:inactive}: #1#)",
			"{C:inactive}(Like a guardian angel, Virgo keeps you safe.)"
        }
    },
    cosmicsagittarius = {
        name = "Cosmic - Sagittarius",
        text = {
            "When you beat a {C:attention}Blind{},",
			"add 5 {X:purple,C:white}Cosmic-Tokens{} to this card.",
            "Gains {X:mult,C:white}X0.01{} Mult for every {C:purple}Cosmic-Tokens{} on your Jokers", 
            "Retrigger played {C:attention}Jack{} cards.",	
            "{C:inactive}({C:purple}Total Cosmic-Tokens{}{C:inactive}: #2# = {X:mult,C:white} X#1#{} Mult)",
			"{C:inactive}(His arrows will blot out the sun. )"
        }
    },
}
--2 > Aquarius
--3 > Pisces
--4 > Aries
--5 > Scorpion
--6 > Gemini DONE!
--7 > Cancer
--8 > Capricorn
--9 > Taurus
--10 > Libra DONE!
--J > Sagittarius
--Q > Virgo
--K > Leo DONE!
--A > 

local jokers = {
	combatacesoldier = SMODS.Joker:new(
        "Combat Ace - Soldier", "",
		{extra={chips=35, counter=0}},
        {}, "",
        1, 4, true, true, true, true
    ),
    combatacesupplies = SMODS.Joker:new(
        "Combat Ace - Supplies", "",
		{extra={dollars=3, counter=3}},
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
        2, 8, true, true, false, true
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
        1, 4, true, true, true, true
    ),
    combataceveteran = SMODS.Joker:new(
        "Combat Ace - Veteran", "",
		{extra={chips=50, counter=0, bonustotal=50}},
        {}, "",
        4, 45, true, true, true, true
    ),
    combatacesecretagent = SMODS.Joker:new(
        "Combat Ace - Secret Agent", "",
        {extra={name = ""}},
        {}, "",
        2, 8, true, true, true, true
    ),
    cosmiclibra = SMODS.Joker:new(
        "Cosmic - Libra", "",
        {extra=""},
        {}, "",
        3, 12, true, true, true, true
    ),
    cosmicgemini = SMODS.Joker:new(
        "Cosmic - Gemini", "",
        {extra={x_mult = 1.1,pairsplayed={}}},
        {}, "",
        2, 8, true, true, true, true
    ),
    cosmicleo = SMODS.Joker:new(
        "Cosmic - Leo", "",
        {extra={odds = 3}},
        {}, "",
        2, 8, true, true, true, true
    ),
    cosmicvirgo = SMODS.Joker:new(
        "Cosmic - Virgo", "",
        {extra={counter=0}},
        {}, "",
        2, 8, true, true, true, true
    ),
    cosmicsagittarius = SMODS.Joker:new(
        "Cosmic - Sagittarius", "",
        {extra={x_mult = 1.0,counter=0, counter_total=0}},
        {}, "",
        3, 12, true, true, true, true
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
    ---Cosmic:---
    ---Cosmic - Libra---
    SMODS.Jokers.j_cosmiclibra.calculate = function(self, context)
        if  context.repetition and context.cardarea == G.play and (context.other_card:get_id() == 10) then 
            addcountertocosmo(context.other_card)          
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
            }
        end       
        if context.individual and context.cardarea == G.play then
            local cardvalue=context.other_card:get_chip_bonus()/2
            return {
            message = localize('k_balanced'),
            mult = cardvalue,
            card = self
            }
        end 
    end

     ---Cosmic - Virgo---
     SMODS.Jokers.j_cosmicvirgo.calculate = function(self, context)
        if  context.repetition and context.cardarea == G.play and (context.other_card:get_id() == 12) then
            addcountertocosmo(context.other_card)                               
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
            }
        end
    end

         ---Cosmic - Sagittarius---
         SMODS.Jokers.j_cosmicsagittarius.calculate = function(self, context)
            if context.other_joker == self then
                return {
                    message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
                    Xmult_mod = self.ability.extra.x_mult
                }
            end
            if  context.repetition and context.cardarea == G.play and (context.other_card:get_id() == 11) then
                addcountertocosmo(context.other_card)                               
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.other_card
                }
            end
            if context.end_of_round and not (context.individual or context.repetition) then
                self.ability.extra.counter=self.ability.extra.counter+5
                return {
                    message = "+5 Cosmic",
                    colour=G.C.PURPLE,
                    card = self
                }
            end
            local count=0
            for i= 1, #G.jokers.cards do
                other_joker = G.jokers.cards[i]
                if other_joker and string.match(other_joker.ability.name,"Cosmic -") and other_joker.ability.extra.counter~=nil then
                    count=count+other_joker.ability.extra.counter
                end
            end
            self.ability.extra.counter_total=count
            self.ability.extra.x_mult=1+(count*0.01)  
        end

    ---Cosmic - Leo---
    SMODS.Jokers.j_cosmicleo.calculate = function(self, context)
        if  context.repetition and context.cardarea == G.play and (context.other_card:get_id() == 13) then
            addcountertocosmo(context.other_card)                
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
            }
        end
        if  context.repetition then
            for i= 1, #G.jokers.cards do
                other_joker = G.jokers.cards[i]
                if other_joker and other_joker ~= self and string.match(other_joker.ability.name,"Cosmic -")  then
                    context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                    context.blueprint_card = context.blueprint_card or self
                    if context.blueprint > #G.jokers.cards + 1 then return end
                    if pseudorandom('leo') < G.GAME.probabilities.normal / self.ability.extra.odds then
                        local other_joker_ret = other_joker:calculate_joker(context)
                        if other_joker_ret then 
                            other_joker_ret.card = context.blueprint_card or self
                            other_joker_ret.colour = G.C.Yellow
                            return other_joker_ret
                        end
                    end
                end
            end
        end
    end

    
    ---Cosmic - Gemini---
    SMODS.Jokers.j_cosmicgemini.calculate = function(self, context)
        if  context.repetition and context.cardarea == G.play and (context.other_card:get_id() == 6) then 
            addcountertocosmo(context.other_card)              
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
            }
        end       
        if context.individual and context.cardarea == G.play then
            local cardrank=context.other_card:get_id()
            self.ability.extra.pairsplayed[cardrank]=self.ability.extra.pairsplayed[cardrank]+1
            if self.ability.extra.pairsplayed[cardrank]==2 then                
                self.ability.extra.pairsplayed[cardrank]=0
                return {
                    message = localize{type='variable',key='a_xmult',vars={self.ability.extra.x_mult}},
                    x_mult = self.ability.extra.x_mult
                }
            end
        end
        if (context.cardarea == G.play and not context.individual) or context.setting_blind then
            for i=1,14 do
                self.ability.extra.pairsplayed[i]=0
            end        
        end       
    end






	---Combat Ace General:---
    SMODS.Jokers.j_combatacegeneral.calculate = function(self, context)
        if context.other_joker then
            if string.match(context.other_joker.ability.name, "Combat Ace") then
                shakecard(context.other_joker)
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
        if context.end_of_round and not (context.individual or context.repetition) and not context.blueprint then
            self.ability.extra.counter=self.ability.extra.counter+1
            if self.ability.extra.counter>=15 then
                destroyCard(self,'holo1')
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, 'j_combataceveteran', nil)
                card:set_edition({negative = true})
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
        
        if  context.repetition and context.cardarea == G.play and (context.other_card:get_id() == 14) then            
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = context.other_card
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
        if context.individual and context.cardarea == G.play and context.other_card:get_id()==14 then		
			local card=context.other_card
			if pseudorandom('promotion') < G.GAME.probabilities.normal / self.ability.extra.odds then						
				if card:get_edition() ~= nil then return nil end
				local edition = poll_edition('promotion', nil, true, true)
                shakecard(card)
                card:set_edition(edition)
                return {
                    message = localize('k_agedup'),
                    colour = G.C.CHIPS,
                    card = card
                }       
				
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
            shakecard(self)
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
    
                            

    ---Combat Ace Supplies:---
    SMODS.Jokers.j_combatacesupplies.calculate = function(self, context)
        if context.discard and not context.other_card.debuff and context.other_card:get_id()==14 then        
            local card=context.other_card
            shakecard(self)
            self.ability.extra.counter=self.ability.extra.counter-1            
            if self.ability.extra.counter==0 then
                self.ability.extra.counter=3
                ease_dollars(self.ability.extra.dollars)
                self.ability.extra.dollars=self.ability.extra.dollars+1
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
    end


    ---Combat Ace Secret Agent:---
    SMODS.Jokers.j_combatacesecretagent.calculate = function(self, context)
        if self.ability.set == "Joker" and not self.debuff then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == self then other_joker = G.jokers.cards[i+1] end
            end
            if other_joker and other_joker ~= self and string.match(other_joker.ability.name, "Combat Ace") then
                self.ability.extra.name= other_joker.ability.name
                context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
                context.blueprint_card = context.blueprint_card or self
                if context.blueprint > #G.jokers.cards + 1 then return end
                local other_joker_ret = other_joker:calculate_joker(context)
                if other_joker_ret then 
                    other_joker_ret.card = context.blueprint_card or self
                    other_joker_ret.colour = G.C.BLUE
                    return other_joker_ret
                end
            end
        end
    end  

	---Combat Ace Recruiter:---
    SMODS.Jokers.j_combatacerecruiter.calculate = function(self, context)
        if context.discard and not context.other_card.debuff and
        pseudorandom('recruiter') < G.GAME.probabilities.normal/self.ability.extra.odds and
        context.other_card:get_id() ~= 14 then
            local card=context.other_card
            local suit_data = SMODS.Card.SUITS[card.base.suit]
            local suit_prefix = suit_data.prefix .. '_'
			local rank_suffix='A'			
            shakecard(self) 
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
    G.localization.misc.dictionary.k_balanced = "Balanced!"
    G.localization.misc.dictionary.k_agedup = "Aged up!"
    G.localization.misc.dictionary.k_supplies_up = "+ Supplies!"
    G.localization.misc.dictionary.k_supplydrop = "Supply drop!"
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
        if string.match(self.ability.name, "Combat Ace") or string.match(self.ability.name, "Cosmic -") then
            customJoker = true
        end



        --Combat Aces:--
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

            elseif self.ability.name == 'Combat Ace - Supplies' then
                loc_vars = {self.ability.extra.dollars, self.ability.extra.counter}

            elseif self.ability.name == 'Combat Ace - Veteran' then
                loc_vars = {self.ability.extra.chips, self.ability.extra.counter, self.ability.extra.bonustotal}
            elseif self.ability.name == 'Combat Ace - Secret Agent' then
                loc_vars = {self.ability.extra.name}
            end
        
            --Cosmic:--
            if self.ability.name == 'Cosmic - Libra' then
                loc_vars = {self.ability.extra}
            elseif self.ability.name == 'Cosmic - Gemini' then
                loc_vars = {self.ability.extra.x_mult}
            elseif self.ability.name == 'Cosmic - Leo' then
                loc_vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), self.ability.extra.odds}
            elseif self.ability.name == 'Cosmic - Virgo' then
                loc_vars = {self.ability.extra.counter}
            elseif self.ability.name == 'Cosmic - Sagittarius' then
                loc_vars = {self.ability.extra.x_mult,self.ability.extra.counter_total}
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
