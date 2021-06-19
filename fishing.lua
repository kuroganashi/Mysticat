-----------------------------------------------------------------
-- Leave this line alone. By pulling in the organizer-lib file, we
-- let gearswap automatically pull the necessary gear from mog safe
-- and other locations when we change jobs and execeute the
-- //gs org command.
-----------------------------------------------------------------
include('organizer-lib')

function get_sets()
    sets.fishing = {
        range="Ebisu F. Rod +1",
		head="Tlahtlamah Glasses",
		body="Fsh. Tunica",
		hands="Fsh. Gloves",
		legs="Fisherman's Hose",
		feet="Waders",
		neck="Fisher's Torque",
		ring1="Noddy Ring",
		ring2="Puffin Ring",
		waist="Fisher's Rope",	
    }
end

function precast(spell)    
end

function midcast(spell)
end

function aftercast(spell)
end

function status_change(new,old)
    equip(sets.fishing)
end

function self_command(command)
end