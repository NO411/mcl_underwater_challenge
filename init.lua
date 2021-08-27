local modpath = minetest.get_modpath

local function replace_air_with_water(water)
        minetest.register_on_generated(function(minp, maxp, blockseed)
        	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
        	local area = VoxelArea:new{ MinEdge = emin, MaxEdge = emax }
        	local data = vm:get_data()
                for y = minp.y, maxp.y do
			for x = minp.x, maxp.x do
				for z = minp.z, maxp.z do
                                        if y <= mcl_vars.mg_overworld_max_official then
                                                local i = area:index(x, y, z)
                                                if minetest.get_name_from_content_id(data[i]) == "air" then
                                                        data[i] = minetest.get_content_id(water)
                                                end
					end
				end
			end
		end
        	vm:set_data(data)
        	vm:write_to_map(true)
        end)
end

if modpath("mcl_core") then
        replace_air_with_water("mcl_core:water_source")
        minetest.register_on_newplayer(function(player)
                local pos = player:get_pos()
                minetest.add_item(pos, "mcl_potions:water_breathing_plus")
        end)
else
        minetest.log("error", "Please install Mineclone2 to use the mod.")
        return
end