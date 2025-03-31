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
    ret.modifiers.extra_boosters = (ret.modifiers.extra_boosters or 0) + Mutils.config.shop_booster_slots
    ret.modifiers.extra_vouchers = (ret.modifiers.extra_vouchers or 0) + Mutils.config.shop_voucher_slots
    ret.shop.joker_max = ret.shop.joker_max + Mutils.config.shop_joker_slots
    -- change_shop_size(Mutils.config.shop_joker_slots)

    -- Adjust card area sizes if desired

    ret.starting_params.consumable_slots = (ret.starting_params.consumable_slots or 0) + Mutils.config.consumeable_slots
    ret.starting_params.joker_slots = (ret.starting_params.joker_slots or 0) + Mutils.config.joker_slots
    -- Set the starting spawn rate of Jokers
    local total_rate = ret.joker_rate + ret.playing_card_rate
    for _,v in ipairs(SMODS.ConsumableType.ctype_buffer) do
        total_rate = total_rate + ret[v:lower()..'_rate']
    end

    ret.joker_rate = total_rate * (Mutils.config.joker_rate / 100)

    return ret
end

-- Config UI

local shop_boxes = {
    {ref_value = "shop_joker_slots", label = "glue_settings_shop_joker_slots", min = 0, max = 5},
    {ref_value = "shop_voucher_slots", label = "glue_settings_voucher_slots", min = 0, max = 5},
    {ref_value = "shop_booster_slots", label = "glue_settings_booster_slots", min = 0, max = 5}
}

local card_area_boxes = {
    {ref_value = "joker_slots", label = "glue_settings_joker_slots", min = 0, max = 5},
    {ref_value = "consumeable_slots", label = "glue_settings_consumeable_slots", min = 0, max = 5},
}

local spawn_rate_boxes = {
    {ref_value = "joker_rate", label = "glue_settings_joker_rate", min = 0, max = 100},
}

local create_menu_sliders = function(parent, sliders)
	for k, v in ipairs(sliders) do
		parent.nodes[#parent.nodes + 1] = create_slider({
			label = localize(v.label),
			label_scale = 0.4,
			text_scale = 0.3,
			w = 4,
			h = 0.4,
			ref_table = Mutils.config,
			ref_value = v.ref_value,
			min = v.min,
			max = v.max,
		})
		if v.tooltip then
			parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
		end
	end
end

glueconfig = function()
    local shop_boxes_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_sliders(shop_boxes_settings, shop_boxes)

    local card_area_boxes_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_sliders(card_area_boxes_settings, card_area_boxes)

    local spawn_rate_boxes_settings = {n = G.UIT.R, config = {align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR,}, nodes = {}}
	create_menu_sliders(spawn_rate_boxes_settings, spawn_rate_boxes)

    local config_nodes = {
        {
            n = G.UIT.R,
            config = {
                padding = 0,
                align = "tm"
            },
            nodes = {
                shop_boxes_settings,
                card_area_boxes_settings,
                spawn_rate_boxes_settings
            }
        }
    }

    return config_nodes
end

SMODS.current_mod.config_tab = function()
	return {
		n = G.UIT.ROOT, 
		config = {        
			align = "cm",
        	padding = 0.05,
        	colour = G.C.CLEAR,
		}, 
		nodes = glueconfig()
	}
end