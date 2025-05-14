--- STEAMODDED HEADER
--- MOD_NAME: Pawn Breaker
--- MOD_ID: PAWN_BREAKER
--- MOD_AUTHOR: [fisherlul]
--- MOD_DESCRIPTION: An example mod on how to create Jokers.
--- PREFIX: xmpl

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
        return { vars = { card.ability.extra.mult, card.ability.extra.money } }
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
            return {
                mult_mod = card.ability.extra.mult,
                money_mod = card.ability.extra.money,
                localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                localize { type = 'variable', key = 'a_money', vars = { card.ability.extra.money } },
            }
        end
    end
    
}



----------------------------------------------
------------MOD CODE END----------------------