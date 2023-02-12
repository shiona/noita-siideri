dofile("data/scripts/lib/mod_settings.lua")
dofile("mods/siideri/files/crc.lua")

local mod_id = "siideri" -- This should match the name of your mod's folder.

function mod_setting_checksum_label(mod_id, gui, in_main_menu, im_id, setting)
	local seed_list = ModSettingGetNextValue("siideri.seed_list")
	local checksum = crc(seed_list)
	GuiText(gui, mod_setting_group_x_offset, 0, string.format("Checksum: %04x", checksum))
end


function mod_setting_load_button(mod_id, gui, in_main_menui, im_id, setting)
	local text = "Load (mods/siideri/files/seed_list.txt)"
	local button = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, text)
	if (button) then 
		local raw = ModTextFileGetContent("mods/siideri/files/seed_list.txt")
		local filtered = string.gsub(raw, "[^0-9,]", "")

		if filtered == nil or filtered == "" then
			-- Would be nice if this could persist on the screen for a moment
			GuiText(gui, mod_setting_group_x_offset, 0, "Could not read the file")
		else
			ModSettingSetNextValue("siideri.seed_list", filtered, false);
		end
	end
end

mod_settings = 
{
	{
		id = "seed_list",
		ui_name = "World seeds",
		ui_description = "List of seeds you want to use, separated with commas",
		value_default = "",
		scope = MOD_SETTING_SCOPE_NEW_GAME,
		text_max_length = 500, -- Might need to be even longer, no idea
		allowed_characters = "0123456789,",
	},
	{
		id = "seed_index",
		ui_name = "Seed Index",
		ui_description = "Which seed is next to be used (index starts with 1)",
		value_default = "1",
		scope = MOD_SETTING_SCOPE_NEW_GAME,
		text_max_length = 5,
		allowed_characters = "0123456789",
	},
	{
		id = "crc",
		ui_name = "CRC",
		value_default = "xxxx",
		ui_fn = mod_setting_checksum_label,
	},
	{
		id = "load",
		ui_name = "Load",
		ui_description = "Load list of seeds from \"seed_list.txt\" file in this mods \"files\" directory",
		ui_fn = mod_setting_load_button,
	},
}

-- This function is called to ensure the correct setting values are visible to the game. your mod's settings don't work if you don't have a function like this defined in settings.lua.
function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	mod_settings_update( mod_id, mod_settings, init_scope )
end

-- This function should return the number of visible setting UI elements. 
-- Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
-- If your mod changes the displayed settings dynamically, you might need to implement custom logic for this function.
function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

-- This function is called to display the settings UI for this mod. your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end
