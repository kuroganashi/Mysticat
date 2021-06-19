-----------------------------------------------------------------
-- Leave this line alone. By pulling in the organizer-lib file, we
-- let gearswap automatically pull the necessary gear from mog safe
-- and other locations when we change jobs and execeute the
-- //gs org command.
-----------------------------------------------------------------
include('organizer-lib')

function get_sets()
    sets.alchemy = {
        main="Caduceus",
		head="Midras's Helm +1",
		body="Alchemist's Apron",
		hands="Alchemist's Cuffs",
		neck="Alchemst. Torque",
		ring1="Artificer's Ring",
		ring2="Craftmaster's Ring",
    }
end

function precast(spell)    
end

function midcast(spell)
end

function aftercast(spell)
end

function status_change(new,old)
    equip(sets.alchemy)
end

function self_command(command)
end