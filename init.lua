-- Registrierung des Schwerts in Minetest
minetest.register_tool("armageddons_blade:armageddons_blade", {
    description = "Armageddon's Blade",
    inventory_image = "armageddons_blade.png",
    tool_capabilities = {
        full_punch_interval = 0.8,
        max_drop_level = 1,
        groupcaps = {
            snappy = {times = { [1]=1.50, [2]=0.80, [3]=0.40 }, uses = 40, maxlevel = 2},
        },
        damage_groups = {fleshy = 15},
    },
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type == "object" then
            local entity = pointed_thing.ref
            if entity:is_player() then
                -- Verursache eine Explosion an der Position des getroffenen Spielers
                local pos = entity:get_pos()
                minetest.sound_play("tnt_explode", {pos = pos, gain = 1.0, max_hear_distance = 32})
                minetest.add_particlespawner({
                    amount = 100,
                    time = 1,
                    minpos = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
                    maxpos = {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
                    minvel = {x = -1, y = -1, z = -1},
                    maxvel = {x = 1, y = 1, z = 1},
                    minacc = {x = -1, y = -1, z = -1},
                    maxacc = {x = 1, y = 1, z = 1},
                    minexptime = 0.1,
                    maxexptime = 0.5,
                    minsize = 1,
                    maxsize = 3,
                    collisiondetection = true,
                    texture = "default_dirt.png",
                })
                -- Pushe die Spieler weg
                local dir = entity:get_look_dir()
                entity:add_velocity({x = dir.x * 5, y = dir.y * 5, z = dir.z * 5})
            end
        end
    end,
})

-- Registrierung des Rezepts für das Schwert
minetest.register_craft({
    output = "modname:armageddons_blade",
    recipe = {
        {"", "default:diamondblock", ""},
        {"", "default:diamondblock", ""},
        {"default:gold_ingot", "default:goldblock", "default:gold_ingot"},
    },
})
