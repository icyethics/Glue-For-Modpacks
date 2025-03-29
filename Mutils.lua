Mutils = {}
Mutils.mod_dir = ''..SMODS.current_mod.path
Mutils.config = SMODS.current_mod.config

-- local igo = Game.init_game_object
-- Game.init_game_object = function(self)
--     local ret = igo(self)

--     return ret
-- end

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    -- Set the starting size of the shop
    -- SMODS.change_voucher_limit(Mutils.config.shop_voucher_slots)
    -- SMODS.change_booster_limit(Mutils.config.shop_booster_slots)
    ret.modifiers.extra_vouchers = (ret.modifiers.extra_vouchers or 0) + Mutils.config.shop_voucher_slots
    ret.shop.joker_max = ret.shop.joker_max + Mutils.config.shop_joker_slots
    print(Mutils.config.shop_joker_slots)
    -- change_shop_size(Mutils.config.shop_joker_slots)

    -- Adjust card area sizes if desired
    print(ret.starting_params.consumable_slots)
    print(Mutils.config.consumeable_slots)
    ret.starting_params.consumable_slots = (ret.starting_params.consumable_slots or 0) + Mutils.config.consumeable_slots
    ret.starting_params.joker_slots = (ret.starting_params.joker_slots or 0) + Mutils.config.joker_slots
    print(ret.starting_params.consumable_slots)
    -- Set the starting spawn rate of Jokers
    local total_rate = ret.joker_rate + ret.playing_card_rate
    for _,v in ipairs(SMODS.ConsumableType.ctype_buffer) do
        total_rate = total_rate + ret[v:lower()..'_rate']
    end

    ret.joker_rate = total_rate * Mutils.config.joker_rate

    return ret
end