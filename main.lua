--- STEAMODDED HEADER
--- MOD_NAME: Lots O Stuff
--- MOD_ID: LOTS_O_STUFF
--- MOD_AUTHOR: [fisherlul]
--- MOD_DESCRIPTION: A Balatro mod that adds vanilla-esque Jokers, and some crazy ones.
--- PREFIX: xmpl
--- VERSION: 0.9.1

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "Jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "pawnbroker",
    loc_txt = {
        name = "Pawn Broker",
        text = {
            "When a Joker is sold, gain {C:mult}+#1# {}Mult.",
            "Earn {C:money}#2#${} at end of round.",
            "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
        }
    },
    config = {extra = {
        money = 2, 
        mult = 0,
        mult_gain = 5, -- Added missing mult_gain field
    }},
    rarity = 3,
    atlas = "Jokers",
    cost = 8,
    unlocked = true,  --  -- unlocked by default
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card) 
        return { vars = { 
            card.ability.extra.mult_gain, 
            card.ability.extra.money,
            card.ability.extra.mult, 
        }}
    end,
    calculate = function(self, card, context) 
        local total_mult = card.ability.extra.mult
        if context.selling_card and not context.blueprint and not context.retrigger_joker then
            total_mult = card.ability.extra.mult + card.ability.extra.mult_gain
            card.ability.extra.mult = total_mult
            return {
				message = 'Upgraded!',
				colour = G.C.MULT,
				card = card
			}
        end
        if context.joker_main then
            return {
                card = card,
                colour = G.C.MULT,
                mult_mod = total_mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { total_mult } },
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.money
		if bonus > 0 then return bonus end
	end
}

SMODS.Joker {
    key = "colorchanger",
    loc_txt = {
        name = "Color Changer",
        text = {
            "In the final hand, treat the suit of",
            "all cards held on hand as {V:1}#1#{},",
            "suit changes every round."
        }
    },
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    rarity = 2, 
    atlas = "Jokers",
    cost = 4,
    loc_vars = function(self, info_queue, card) 
        return { vars = { 
            localize(G.GAME.current_round.colorchanger_card.suit, 'suits_singular'),
            colour = { G.C.SUITS[G.GAME.current_round.colorchanger_card.suit] }
         } }
    end,
    calculate = function(self, card, context) 
        if context.joker_main then
            return {
                card = card,
                colour = G.C.SUIT,
                suit_mod = card.ability.extra.suit,
                message = localize { type = 'variable', key = 'a_suit', vars = { card.ability.extra.suit } },
            }
        end
    end,
    -- on_round_start = function(self, card)
    --     local suits = { "hearts", "clubs", "spades", "diamonds" }
    --     local suit = suits[math.random(1, #suits)]
    --     card.ability.extra.suit = suit
    --     return {
    --         message = 'Suit changed!',
    --         colour = G.C.SUIT,
    --         card = card
    --     }
    -- end,
}
local igo = Game.init_game_object
function Game:init_game_object()
	local ret = igo(self)
	ret.current_round.suitchanger_card = { suit = 'spades' }
	return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
	-- Initialize the variable each round
	G.GAME.current_round.suitchanger_card = { suit = 'spades' }
	
	-- Generate a random suit
	local random_suit = pseudorandom_element(SMODS.Suits, pseudoseed('suitshuffler' .. G.GAME.round_resets.ante))
	G.GAME.current_round.suitchanger_card.suit = random_suit

	-- Apply the random suit to every card in hand
	for _, card in ipairs(G.hand.cards) do
		if card.suit then
			card.suit = random_suit
			card:set_sprites()  -- Update visuals (optional, but typically needed!)
		end
	end
end

----------------------------------------------
------------MOD CODE END----------------------