Mutils = {}
Mutils.mod_dir = ''..SMODS.current_mod.path
Mutils.config = SMODS.current_mod.config

-- local igo = Game.init_game_object
-- Game.init_game_object = function(self)
--     local ret = igo(self)

--     return ret
-- end

local original_start_run = Game.start_run
function Game:start_run(args)
    original_start_run(self, args)
    -- Set the starting size of the shop
    SMODS.change_voucher_limit(Mutils.config.shop_voucher_slots)
    SMODS.change_booster_limit(Mutils.config.shop_booster_slots)
    change_shop_size(Mutils.config.shop_joker_slots)

    -- Adjust card area sizes if desired
    G.consumeables.config.card_limit = G.consumeables.config.card_limit + Mutils.config.consumeable_slots
    G.jokers.config.card_limit = G.jokers.config.card_limit + Mutils.config.joker_slots

    -- Set the starting spawn rate of Jokers
    local total_rate = G.GAME.joker_rate + G.GAME.playing_card_rate
    for _,v in ipairs(SMODS.ConsumableType.ctype_buffer) do
        total_rate = total_rate + G.GAME[v:lower()..'_rate']
    end

    G.GAME.joker_rate = total_rate * Mutils.config.joker_rate
end