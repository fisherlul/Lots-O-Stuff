--- STEAMODDED HEADER
--- MOD_NAME: Lots O Stuff
--- MOD_ID: LOTS_O_STUFF
--- MOD_AUTHOR: [fisherlul]
--- MOD_DESCRIPTION: A Balatro mod that adds vanilla-esque Jokers, and some crazy ones.
--- PREFIX: xmpl
--- VERSION: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "Jokers",
    path = "jokers.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "pawnbreaker",
    loc_txt = {
        name = "Pawn Breaker",
        text = {
            "When a Joker is sold,",
            "gain {C:mult}+#1# {}Mult and {C:money}#2#${}",
            "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
        }
    },
    config = {extra = {
        money = 2, 
        mult = 5,
    }},
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.mult, 
            card.ability.extra.money, 
        }}
    end,
    rarity = 3,
    atlas = "Jokers",
    cost = 8,
    unlocked = true,  --  -- unlocked by default
    discovered = true, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = false, --can it be perishable
    pos = { x = 0, y = 0 },

    calculate = function(self, card, context) 
        if context.joker_main then
            card.ability.extra.mult = card.ability.extra.mult,
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
            }
        end
    end
    calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.money
		if bonus > 0 then return bonus end
	end
}



----------------------------------------------
------------MOD CODE END----------------------