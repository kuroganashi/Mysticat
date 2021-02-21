-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
	state.Buff.Doomed = buffactive.doomed or false
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    --state.Buff.Souleater = buffactive.souleater or false
    state.Buff.Berserk = buffactive.berserk or false
	state.Buff.Restraint = buffactive.restraint or false
    state.Buff.Retaliation = buffactive.retaliation or false
    
    wsList = S{}
    gsList = S{'Macbain', 'Kaquljaan', 'Nativus Halberd', 'Zulfiqar', 'Montante', 'Montante +1'}
    war_sub_weapons = S{"Sangarius", "Usonmunku", "Perun", "Tanmogayi", "Naegling"}

    get_combat_form()
    get_combat_weapon()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Bad_Ass_Set', 'Acc')--, 'Mid', 'Test1', 'Test2', 'Store_TP', 'DA'
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mod', 'Mod2', 'Mod3')--'Mid', 'Acc'
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    state.drain = M(false)
    
    -- Additional local binds
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    
    select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
end
 
organizer_items = {
    --echos="Echo Drops",
    --shihei="Shihei",
	--tools1="Inoshishinofuda",
    --tools2="Chonofuda",
    --tools3="Shikanofuda",
	--tools4="Sanjaku-Tenugui",
	--tools5="Shinobi-Tabi",
	Sword1="Naegling",
	Polearm1="Kaja Lance",
	Shield1="Blurred Shield +1",
	--orb="Macrocosmic Orb",
} 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
     --------------------------------------
     -- Start defining the sets
     --------------------------------------
     -- Augmented gear
     --Acro = {}
     --Acro.Hands = {}
     --Acro.Feet = {}
    
     --Acro.Hands.Haste = {name="Acro gauntlets", augments={'STR+3 AGI+3','Accuracy+18 Attack+18','Haste+2'}} 
     --Acro.Hands.STP = {name="Acro gauntlets", augments={'Accuracy+19 Attack+19','"Store TP"+5','Weapon skill damage +3%'}}

     --Acro.Feet.STP = {name="Flam. Gambieras +1", augments={'STR+7 AGI+7','Accuracy+17 Attack+17','"Store TP"+6'}} 
     --Acro.Feet.WSD = {name="Flam. Gambieras +1", augments={'Accuracy+18 Attack+18','"Dbl. Atk."+3','Weapon skill damage +2%'}} 

     --Niht = {}
     --Niht.DarkMagic = {name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25'}}
     --Niht.WSD = {name="Niht Mantle", augments={'Attack+9','Dark magic skill +4', '"Drain" and "Aspir" potency +11','Weapon skill damage +4%'}}
    --Odyssean = {}
    --Odyssean.Legs = {}
    --Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'Accuracy+23 Attack+23','"Dbl.Atk."+2','STR+3','Accuracy+11','Attack+8',}}
    --Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+7','Accuracy+11',}}
    --Odyssean.Feet = {}
    --Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}
    --Odyssean.Feet.TP = { name="Odyssean Greaves", augments={'Accuracy+16 Attack+16','"Store TP"+4','DEX+1','Accuracy+13','Attack+15',}}

     
     -- Precast Sets
     -- Precast sets to enhance JAs
     -- JA Sets
	 sets.precast['Warcry'] = {
		head="Agoge Mask +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	 sets.precast['Tomahawk'] = {
		ammo="Thr. Tomahawk",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		head="Alhazen Hat +1",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		legs="Pumm. Cuisses +3",
		feet="Agoge Calligae +3",
	}
	 sets.precast.JA.Tomahawk = {
		ammo="Thr. Tomahawk",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		head="Alhazen Hat +1",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		legs="Pumm. Cuisses +3",
		feet="Agoge Calligae +3",
	}
	 --R.ACC +40 Head
	 --R.ACC SET 3/6 (+30)
	 --R.ACC +15 Belt
	 --R.ACC +10 Neck
	 --R.ACC +16 Ring
	 --R.ACC +15 Ring
	 --------------------Total: 126 R.ACC
	 
	 sets.precast['Seigan'] = {}
	 sets.precast["Warrior's Charge"] = {
		legs="Agoge Cuisses +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	 sets.precast['Blood Rage'] = {
		body="Boii Lorica +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	 sets.precast['Aggressor'] = {head="Pummeler's Mask +2",body="Agoge Lorica +3"}
	 sets.precast['Berserk'] = {
		body="Pumm. Lorica +3",
		feet="Agoge Calligae +3",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	 sets.precast['Mighty Strikes'] = {
		hands="Agoge Mufflers +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	 sets.precast['Restraint'] = {
		hands="Boii Mufflers +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	 sets.precast['Retaliation'] = {
		hands="Pumm. Mufflers +2",
		feet="Boii Calligae +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	 sets.precast['Provoke'] = {
		ammo="Amar Cluster",
		head="Halitus Helm",
		neck="Unmoving Collar +1",
		ear1="Friomisi Earring",
		ear2="Cryptic Earring",
		body="Emet Harness +1",
		hands="Pumm. Mufflers +2",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
		legs="Pumm. Cuisses +3",
		feet="Eschite Greaves",
	}--Eschite Greaves  (+8 Enmity)
	
	--Events
     sets.CapacityMantle  = {back="Mecistopins Mantle"}
     --sets.Berserker       = { neck="Berserker's Torque" }
     sets.WSDayBonus      = {}
     -- TP ears for night and day, AM3 up and down. 
     sets.BrutalLugra     = {}--ear2="Lugra Earring +1"
     sets.Lugra           = {}--ear2="Lugra Earring +1"
     sets.Brutal          = {}
	 sets.TP_Bonus        = {ear2="Cessance Earring"}
 
     --sets.reive = {neck="Ygnas's Resolve +1"}
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ear1="Thrud Earring",
		ear2="Odnowa Earring",
		ring1="Titan Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		legs="Pumm. Cuisses +3",
		feet="Amm Greaves",
		neck="Unmoving Collar +1",
	}--Reiki Osode
            
	-- STEPS
    sets.precast.Step = {
		ammo="Amar Cluster",
		head="Pummeler's Mask +2",
		neck="Subtlety Spectacles",
		ear1="Telos Earring",                              
		ear2="Digni. Earring",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	}
 
    -- VIOLENT FLOURISH
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {}
			
     -- Fast cast sets for spells
     sets.precast.FC = {
		ammo="Impatiens",
        head="Cizin Helm +1",
		neck="Voltsurge Torque",
		ear1="Mendi. Earring",
		ear2="Loquacious Earring",
        body="Sulevia's Plate. +2",
		hands="Cizin Mufflers +1",
		ring1="Weatherspoon Ring +1",
		ring2="Prolix Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Eschan Stone",
		legs="Enif Cosciales",
		feet="Odyssean Greaves",
	}
     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	  ---------------------------------------------------------------------------------
	
	-- WEAPONSKILL SETS ----------------------------------------------
     -- General sets
     sets.precast.WS = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Shukuyu Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	}--
     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		body="Pumm. Lorica +3",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		head="Pummeler's Mask +2",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})
    
	-- Great Axe ----------------------------------------------
	
	-- Shield Break
	 -- 60% STR 60% VIT
	sets.precast.WS['Shield Break'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ammo="Amar Cluster",
		head="Pummeler's Mask +2",
		ear1="Telos Earring",                              
		ear2="Digni. Earring",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Need more ACC+
	 
	 -- Iron Tempest
	 -- 60% STR
	sets.precast.WS['Iron Tempest'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
	 
	 -- Sturmwind
	 -- 60% STR
	sets.precast.WS['Sturmwind'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
	 
	 -- Armor Break
	 -- 60% STR 60% VIT
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ammo="Amar Cluster",
		head="Pummeler's Mask +2",
		ear1="Telos Earring",                              
		ear2="Digni. Earring",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Need more ACC+
	 
	 -- Keen Edge
	 -- 100% STR
	sets.precast.WS['Keen Edge'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt"})
	 
	 -- Weapon Break
	 -- 60% STR 60% VIT
	sets.precast.WS['Weapon Break'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ammo="Amar Cluster",
		head="Pummeler's Mask +2",
		ear1="Telos Earring",                              
		ear2="Digni. Earring",
		body="Pumm. Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Need more ACC+
	 
	 -- Raging Rush
	 -- 50% STR (Crit)
	sets.precast.WS['Raging Rush'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt",hands="Flam. Manopolas +2"})
	 
	 -- Full Break
	 -- 50% STR 50% VIT
	sets.precast.WS['Full Break'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ammo="Amar Cluster",
		head="Pummeler's Mask +2",
		ear1="Telos Earring",                              
		ear2="Digni. Earring",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Need more ACC+
	
	 -- Steel Cyclone
	 -- 60% STR 60% VIT
	sets.precast.WS['Steel Cyclone'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
	})
	
	 -- King's Justice
	 -- 50% STR
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		ear1="Thrud Earring",
		feet="Sulev. Leggings +2",
	})--Similar to Resolution
	 
	 -- Metatron Torment
	 -- 80% STR
	sets.precast.WS['Metatron Torment'] = set_combine(sets.precast.WS, {
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
		ear1="Thrud Earring",
		neck="Fotia Gorget",
		waist="Fotia Belt",
	})--WSD+
	
	 -- Fell Cleave 
	 -- 60% STR 
	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
	})
	 
	 -- Upheaval (1 hit)
	 -- 86~100% VIT
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+21','Weapon skill damage +4%','AGI+10','Attack+10',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+5','Attack+14',}},
		feet="Sulev. Leggings +2",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		ring1="Titan Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		neck="Fotia Gorget",
	 })--24,554 (waist="Fotia Belt",) legs="Pumm. Cuisses +3", feet="Pumm. Calligae +3", Ioskeha Belt hands="Sule. Gauntlets +2",
 
	--[[legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+5','Attack+14',}},
		feet="Sulev. Leggings +2",waist="Fotia Belt",]]
 
	--Old
	sets.precast.WS['Upheaval'].Mod = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+21','Weapon skill damage +4%','AGI+10','Attack+10',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+5','Attack+14',}},
		feet="Sulev. Leggings +2",
		ear1="Thrud Earring",
		ring1="Titan Ring +1",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		neck="Fotia Gorget",
	 })--24.013
 

	-- Ukko's Fury (2 hit)
	 --	80% STR (Crit)
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		head="Flamma Zucchetto +2",
		body="Agoge Lorica +3",
		hands="Flam. Manopolas +2",
		legs="Pumm. Cuisses +3",
		feet="Sulev. Leggings +2",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		ring1="Begrudging Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt"
	})--13,817 

	 --Set A (Crit DA)
	 sets.precast.WS["Ukko's Fury"].Mod = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		head="Flamma Zucchetto +2",
		body="Agoge Lorica +3",
		hands="Flam. Manopolas +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		ring1="Begrudging Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
	})--13,516
	 
	 --Set B (WSD+)
	 sets.precast.WS["Ukko's Fury"].Mod2 = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+21','Weapon skill damage +4%','AGI+10','Attack+10',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+5','Attack+14',}},
		feet="Sulev. Leggings +2",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		ring1="Begrudging Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
	})--12,438
	 
	 --Old set
	 sets.precast.WS["Ukko's Fury"].Mod3 = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		head="Flam. Zucchetto +2",
		body="Agoge Lorica +3",
		hands="Flam. Manopolas +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		ring1="Begrudging Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
	})--13,346
	 
	 -- Great Sword ----------------------------------------------
	 
	 --Hard Slash
	 --100% STR
	 sets.precast.WS['Hard Slash'] = set_combine(sets.precast.WS, {})
	 
	 --Power Slash
	 --60% STR 60% VIT (Crit)
	 sets.precast.WS['Power Slash'] = set_combine(sets.precast.WS, {})
	 
	 --Frostbite
	 --40% STR 40% INT
	 sets.precast.WS['Frostbite'] = set_combine(sets.precast.WS, {})
	 
	 --Freezebite
	 --40% STR 40% INT
	 sets.precast.WS['Freezebite'] = set_combine(sets.precast.WS, {})
	 
	 --Shockwave
	 --30% STR 30% MND
	 sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {})
	 
	 --Crescent Moon
	 -- 80% STR
	 sets.precast.WS['Crescent Moon'] = set_combine(sets.precast.WS, {})
	 
	 --Sickle Moon
	 -- 40% STR 40% AGI
	 sets.precast.WS['Sickle Moon'] = set_combine(sets.precast.WS, {})
	 
	 --Spinning Slash
	 -- 30% STR 30% INT
	 sets.precast.WS['Spinning Slash'] = set_combine(sets.precast.WS, {})
	 
	 --Herculean Slash
	 -- 80% VIT
	 sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS, {})
	 
	 --Scourge
	 -- 40% STR 40% VIT
	 sets.precast.WS['Scourge'] = set_combine(sets.precast.WS, {})
	 
	 -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		ring1="Shukuyu Ring",
		ring2="Niqmaddu Ring",
		head="Flam. Zucchetto +2",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Knobkierrie
     sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {})
     sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 
	
	-- GROUND STRIKE
	-- 50% STR / 50% INT
	sets.precast.WS['Ground Stike'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt",ammo="Knobkierrie",ear1="Thrud Earring"})
    sets.precast.WS['Ground Stike'].Mid = set_combine(sets.precast.WS.Mid, {neck="Fotia Gorget",waist="Fotia Belt",ear1="Thrud Earring"})
    sets.precast.WS['Ground Stike'].Acc = set_combine(sets.precast.WS['Ground Stike'].Mid, sets.precast.WS.Acc)
	
     -- TORCLEAVER 
     -- VIT 80%
     sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+21','Weapon skill damage +4%','AGI+10','Attack+10',}},
		ring1="Titan Ring +1",
		ring2="Niqmaddu Ring",
		feet="Sulev. Leggings +2",
		head="Sulevia's Mask +2",
		body="Pumm. Lorica +3",
		ear1="Thrud Earring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		neck="Fotia Gorget",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+5','Attack+14',}},
	})
     sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {})
     sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)

	 
	 -- Polearm ----------------------------------------------
	 
	 --Double Thrust
	 --30 STR 30 DEX
	 sets.precast.WS['Double Thrust'] = set_combine(sets.precast.WS, {})
	 
	 --Thunder Thrust
	 --40 STR 40 INT
	 sets.precast.WS['Thunder Thrust'] = set_combine(sets.precast.WS, {})
	 
	 --Raiden Thrust
	 --40 STR 40 INT
	 sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS, {})
	 
	 --Leg Sweep
	 --100% STR
	 sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {})
	 
	 --Penta Thrust
	 --20 STR 20 DEX
	 sets.precast.WS['Penta Thrust'] = set_combine(sets.precast.WS, {})
	 
	 --Vorpal Thrust
	 --50 STR 50 AGI (Crit)
	 sets.precast.WS['Vorpal Thrust'] = set_combine(sets.precast.WS, {})
	 
	 --Skewer
	 --50 STR
	 sets.precast.WS['Skewer'] = set_combine(sets.precast.WS, {})
	 
	 --Wheeling Thrust
	 --80 STR
	 sets.precast.WS['Wheeling Thrust'] = set_combine(sets.precast.WS, {})
	 
	 --Impulse Drive
	 --100%
	 sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		ring1="Shukuyu Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	})
	 
	 --Sonic Thrust
	 --40 STR 40 DEX
	 sets.precast.WS['Sonic Thrust'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Stardiver
	 --STR 86~100%
    sets.precast.WS.Stardiver = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		ring1="Shukuyu Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	})
     
	 -- Sword WS's ----------------------------------------------
     
	 
	 --Fast Blade
	 --40 STR 40 DEX
	 sets.precast.WS['Fast Blade'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Burning Blade
	 --40 STR 40 INT
	 sets.precast.WS['Burning Blade'] = set_combine(sets.precast.WS, {})
	 
	 --Red Lotus Blade
	 --40 STR 40 INT
	 sets.precast.WS['Red Lotus Blade'] = set_combine(sets.precast.WS, {})
	 
	 --Flat Blade
	 --100% STR
	 sets.precast.WS['Flat Blade'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Shining Blade
	 --40 STR 40 MND
	 sets.precast.WS['Shining Blade'] = set_combine(sets.precast.WS, {})
	 
	 --Seraph Blade
	 --40 STR 40 MND
	 sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS, {})
	 
	 --Circle Blade
	 --100% STR
	 sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS, {
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	 })
	 
	 --Spirits Within
	 --HP Based
	 sets.precast.WS['Spirits Within'] = set_combine(sets.precast.WS, {})
	 
	 --Vorpal Blade
	 --60% STR (Crit)
	 sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	 })
	 
	 --Swift Blade
	 --50 STR 50 MND
	 sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {})
	 
	 --Savage Blade
	 --50 STR 50 MND
	 sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
		body="Pumm. Lorica +3",
		hands={ name="Odyssean Gauntlets", augments={'Accuracy+21','Weapon skill damage +4%','AGI+10','Attack+10',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+5','Attack+14',}},
		feet="Sulev. Leggings +2",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		ring1="Rufescent Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		neck="Fotia Gorget",
	})
	 
	 --Uriel Blade
	 --32 STR 32 MND
	 sets.precast.WS['Uriel Blade'] = set_combine(sets.precast.WS, {})
	 
	 --Glory Slash
	 --???
	 sets.precast.WS['Glory Slash'] = set_combine(sets.precast.WS, {})
	 
	 
	 -- SANGUINE BLADE
     -- 50% MND / 30% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		ear1="Friomisi Earring",
		ear2="Hecate's Earring",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Fenrir Ring",
		ring2="Fenrir Ring",
		back="Toro Cape",
		legs="Pumm. Cuisses +3",
		feet="Reverence Leggings",
	})
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
		ring1="Stikini Ring +1",
		ring2="Rufescent Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		head="Sulevia's Mask +2",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Pumm. Calligae +3",
	})
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
     sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)
     
	 
	 -- Club ---------------------------------------------- 
	 
	 --Shining Strike
	 --40 STR 40 MND
	 sets.precast.WS['Shining Strike'] = set_combine(sets.precast.WS, {})
	 
	 --Seraph Strike
	 --40 STR 40 MND
	 sets.precast.WS['Seraph Strike'] = set_combine(sets.precast.WS, {})
	 
	 --Brainshaker
	 --100% STR
	 sets.precast.WS['Brainshaker'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Starlight
	 --Club Skill Based.
	 sets.precast.WS['Starlight'] = set_combine(sets.precast.WS, {})
	 
	 --Moonlight
	 --Club Skill Based.
	 sets.precast.WS['Moonlight'] = set_combine(sets.precast.WS, {})
	 
	 --Skullbreaker
	 --100% STR
	 sets.precast.WS['Skullbreaker'] = set_combine(sets.precast.WS, {})
	 
	 --True Strike
	 --100% STR (Crit)
	 sets.precast.WS['True Strike'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Judgment
	 --50 STR 50 MND
	 sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {})
	 
	 --Hexa Strike
	 --30 STR 30 MND
	 sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {})
	 
	 --Black Halo
	 --70 MND 30 STR
	 sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
	 
	 --Flash Nova
	 --50 STR 50 MND
	 sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Realmrazer
	 -- 85~100% MND
	 sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	 
	 
	 -- Staff ---------------------------------------------- 
	 
	 --Heavy Swing
	 -- 40 STR
	 sets.precast.WS['Heavy Swing'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Rock Crusher
	 --40 STR 40 INT
	 sets.precast.WS['Rock Crusher'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Earth Crusher
	 --40 STR 40 INT
	 sets.precast.WS['Earth Crusher'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Starburst
	 --40 STR 40 MND
	 sets.precast.WS['Starburst'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Sunburst
	 --40 STR 40 MND
	 sets.precast.WS['Sunburst'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Shell Crusher
	 --100% STR
	 sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Full Swing
	 --50 STR
	 sets.precast.WS['Full Swing'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Spirit Taker
	 --50 INT 50 MND
	 sets.precast.WS['Spirit Taker'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Retribution
	 --30 STR 50 MND
	 sets.precast.WS['Retribution'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Cataclysm
	 --30 STR 30 INT
	 sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Shattersoul
	 --INT 85~100%
	 sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS, {})
	 
	 --Tartarus Torpor
	 --STR 30 INT 30
	 sets.precast.WS['Tartarus Torpor'] = set_combine(sets.precast.WS, {})
	 
	 
	 -- Scythe ----------------------------------------------
	 
	 --Slice
	 --100% STR
	 sets.precast.WS['Slice'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Dark Harvest
	 --STR 40 INT 40
	 sets.precast.WS['Dark Harvest'] = set_combine(sets.precast.WS, {})
	 
	 --Shadow of Death
	 --STR 40 INT 40
	 sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Nightmare Scythe
	 --STR 60 MND 60
	 sets.precast.WS['Nightmare Scythe'] = set_combine(sets.precast.WS, {})
	 
	 --Spinning Scythe
	 --STR 100
	 sets.precast.WS['Spinning Scythe'] = set_combine(sets.precast.WS, {})
	 
	 --Vorpal Scythe
	 --STR 100 (Crit)
	 sets.precast.WS['Vorpal Scythe'] = set_combine(sets.precast.WS, {})
	 
	 --Guillotine
	 --STR 30 MND 50
	 sets.precast.WS['Guillotine'] = set_combine(sets.precast.WS, {})
	 
	 --Cross Reaper
	 --STR 60 MND 60
	 sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {})
	 
	 --Spiral Hell
	 --STR 50 INT 50
	 sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS, {})
	 
	 --Infernal Scythe
	 --STR 30 INT 70
	 sets.precast.WS['Infernal Scythe'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant",ear1="Thrud Earring"})
	 
	 --Entropy
	 --INT 85~100
	 sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {})
	 
	 
	 -- Dagger ----------------------------------------------
	 
	 --Wasp Sting
	 --DEX 100
	 sets.precast.WS['Wasp Sting'] = set_combine(sets.precast.WS, {})
	 
	 --Gust Slash
	 --DEX 40 INT 40
	 sets.precast.WS['Gust Slash'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Shadowstitch
	 --CHR 100
	 sets.precast.WS['Shadowstitch'] = set_combine(sets.precast.WS, {})
	 
	 --Viper Bite
	 --DEX 100
	 sets.precast.WS['Viper Bite'] = set_combine(sets.precast.WS, {})
	 
	 --Cyclone
	 --DEX 40
	 sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Energy Steal
	 --MND 100%
	 sets.precast.WS['Energy Steal'] = set_combine(sets.precast.WS, {})
	 
	 --Energy Drain
	 --MND 100%
	 sets.precast.WS['Energy Drain'] = set_combine(sets.precast.WS, {})
	 
	 --Dancing Edge
	 --DEX 40 CHR 40
	 sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
	 
	 --Shark Bite
	 --DEX 40 AGI 40
	 sets.precast.WS['Shark Bite'] = set_combine(sets.precast.WS, {})
	 
	 --Evisceration
	 --DEX 50
	 sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	 })
	 
	 --Aeolian Edge
	 --DEX 40 INT 40
	 sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant"})
	 
	 --Exenterator
	 --AGI 85~100%
	 sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
	 
	 -- Axe ----------------------------------------------
	 
	 --Raging Axe
	 --STR 60
	 sets.precast.WS['Raging Axe'] = set_combine(sets.precast.WS, {})
	 
	 --Smash Axe
	 --STR 100
	 sets.precast.WS['Smash Axe'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Gale Axe
	 --STR 100
	 sets.precast.WS['Gale Axe'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant",ear1="Thrud Earring"})
	 
	 --Avalanche Axe
	 --STR 60
	 sets.precast.WS['Avalanche Axe'] = set_combine(sets.precast.WS, {})
	 
	 --Spinning Axe
	 --STR 60
	 sets.precast.WS['Spinning Axe'] = set_combine(sets.precast.WS, {})
	 
	 --Rampage
	 --STR 50
	 sets.precast.WS['Rampage'] = set_combine(sets.precast.WS, {})
	 
	 --Calamity
	 --STR 50 VIT 50
	 sets.precast.WS['Calamity'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Mistral Axe
	 --STR 50
	 sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Decimation
	 --STR 50
	 sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Bora Axe
	 --DEX 100
	 sets.precast.WS['Bora Axe'] = set_combine(sets.precast.WS, {
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	 })
	 
	 --Ruinator
	 --STR 85~100%
	 sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {
	 
	 })
	 
	 --Cloudsplitter
	 --STR 40 MND 40
	 sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS, {neck="Baetyl Pendant",ear1="Thrud Earring"})
	 
	 
	 -- Archery ----------------------------------------------
	 
	 --Arching Arrow
	 --AGI 50 STR 20
	 sets.precast.WS['Arching Arrow'] = {ear1="Thrud Earring"}
	 
	 -- Marksmanship ----------------------------------------------
	 
	 --Heavy Shot
	 --AGI 70
	 sets.precast.WS['Heavy Shot'] = {ear1="Thrud Earring"}
	 
	 
	 -- Hand-to-Hand ----------------------------------------------
	 
	 --Combo
	 --STR 30 DEX 30
	 sets.precast.WS['Combo'] = set_combine(sets.precast.WS, {})
	 
	 --Shoulder Tackle
	 --VIT 100
	 sets.precast.WS['Shoulder Tackle'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --One Inch Punch
	 --VIT 100
	 sets.precast.WS['One Inch Punch'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Backhand Blow
	 --STR 50 DEX 50 (Crit)
	 sets.precast.WS['Backhand Blow'] = set_combine(sets.precast.WS, {ear1="Thrud Earring"})
	 
	 --Spinning Attack
	 --STR 100
	 sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
	 
	 --Dragon Kick
	 --STR 50 DEX50
	 sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {})
	 
	 
	 -------------------------------------------------------
	 
     -- Midcast Sets
     sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		ammo="Impatiens",
		ear2="Loquacious Earring",
		neck="Voltsurge Torque",
		ring1="Weatherspoon Ring +1",
		ring2="Prolix Ring",
		feet="Odyssean Greaves",
	})
            
     -- Specific spells
     sets.midcast.Utsusemi = set_combine(sets.precast.FastRecast,  {
		feet="Odyssean Greaves",
	})
 
	 -- Provoke
	
	 sets.midcast.Enmity = {
		ammo="Amar Cluster",
		head="Halitus Helm",
		neck="Unmoving Collar +1",
		ear1="Friomisi Earring",
		ear2="Cryptic Earring",
		body="Emet Harness +1",
		hands="Pumm. Mufflers +2",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
		legs="Pumm. Cuisses +3",
		feet="Eschite Greaves",
	}

	sets.midcast.Provoke = {
		ammo="Amar Cluster",
		head="Halitus Helm",
		neck="Unmoving Collar +1",
		ear1="Friomisi Earring",
		ear2="Cryptic Earring",
		body="Emet Harness +1",
		hands="Pumm. Mufflers +2",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
		legs="Pumm. Cuisses +3",
		feet="Eschite Greaves",
	}
 
     -- Ranged for xbow
     sets.precast.RA = {}
     sets.midcast.RA = {}

     
     -- Resting sets
    sets.resting = {
		ammo="Staunch Tathlum",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
		neck="Sanctity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
        body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Chirich Ring",
		ring2="Chirich Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Sulev. Cuisses +2",
		feet="Hermes' Sandals",
	}
 
     -- Idle sets
     sets.idle.Town = {
		main="Chango",
		sub="Utu Grip",
		ammo="Staunch Tathlum",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
        body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Hermes' Sandals",
		neck="Sanctity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
	}--Duplus Grip/Nepenthe Grip +1/Aganoshe
     
     sets.idle.Field = {
		ammo="Staunch Tathlum",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
        body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Hermes' Sandals",
		neck="Sanctity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
	}
		
     sets.idle.Regen = set_combine(sets.idle.Field, {
		neck="Sanctity Necklace",
		ear1="Infused Earring",
		ring1="Chirich Ring",
		ring2="Chirich Ring",
	})
 
     sets.idle.Weak = {
		ammo="Staunch Tathlum",
		head={ name="Valorous Mask", augments={'Accuracy+30','Weapon skill damage +4%','VIT+12',}},
		neck="Sanctity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
        body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Sulev. Cuisses +2",
		feet="Hermes' Sandals",
	}

     -- Defense sets
     sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +2",
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
	}--DT-50%
    
	--Dark Ring PDT-3 MDT-3
	
     sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail",
	})
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +2",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Sulev. Cuisses +2",
		feet="Volte Spats",
	})--DT-50%
 
     sets.Kiting = {feet="Hermes' Sandals"}
 
     sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +2",
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
	}
     sets.Defensive_Mid = {
		ammo="Staunch Tathlum",
		head="Sulevia's Mask +2",
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
	}
     sets.Defensive_Acc = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2",
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Sulevia's Plate. +2",
		hands="Sulev. Gauntlets +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Sulev. Leggings +2",
	}
 
		
												--Argosy SET
												
		--Argosy Celata		(DEF:115 HP+50 STR+30 DEX+30 Accuracy+20 Attack+25 Evasion-10 Haste+7% "Store TP"+6)
		--Argosy Hauberk	(DEF:145 HP+68 STR+34 DEX+34 Accuracy+30 Attack+30 Evasion-15 Haste+3% "Double Attack"+4%)
		--Argosy Mufflers	(DEF:101 HP+34 STR+19 DEX+35 Accuracy+15 Attack+30 Evasion-8 Haste+4% "Store TP"+5)
		--Argosy Breeches	(DEF:126 HP+57 STR+43 DEX+11 Accuracy+22 Attack+22 Evasion-10 Haste+5% "Double Attack"+3%)
		--Argosy Sollerets	(DEF:83 HP+22 STR+24 DEX+20 Accuracy+25 Attack+20 Evasion-8 Haste+3% "Store TP"+4)
												
												--Flamma SET
   
   
		--Flam. Zucchetto +1 (DEF:118 HP+80 MP+20 STR+32 DEX+28 VIT+24 AGI+16 INT+12 MND+12 CHR+12 Accuracy+38 Magic Accuracy+38 Evasion+49 Magic Evasion+53 "Magic Def. Bonus"+3 Haste+4% "Triple Attack"+4% "Store TP"+5)
	
		--Flamma Korazin +1 (DEF:148 HP+140 MP+35 STR+39 DEX+35 VIT+32 AGI+20 INT+20 MND+20 CHR+20 Accuracy+40 Magic Accuracy+40 Evasion+55 Magic Evasion+69 "Magic Def. Bonus"+6 Haste+2% "Store TP"+8 "Subtle Blow"+15)
	
		--Flam. Manopolas +1 (DEF:106 HP+60 MP+15 STR+19 DEX+42 VIT+35 AGI+8 INT+7 MND+24 CHR+17 Accuracy+37 Magic Accuracy+37 Evasion+36 Magic Evasion+48 "Magic Def. Bonus"+2 Haste+4% "Store TP"+5 Critical hit rate +7%)
	
		--Flamma Dirs +1 (DEF:130 HP+100 MP+25 STR+49 DEX+7 VIT+29 AGI+16 INT+24 MND+14 CHR+11 Accuracy+39 Magic Accuracy+39 Evasion+41 Magic Evasion+86 "Magic Def. Bonus"+5 Haste+4% "Store TP"+7 Potency of "Cure" effect received +8%)
	
		--Flam. Gambieras +1 (DEF:88 HP+40 MP+10 STR+27 DEX+30 VIT+20 AGI+26 MND+6 CHR+20 Accuracy+36 Magic Accuracy+36 Evasion+74 Magic Evasion+86 "Magic Def. Bonus"+5 Haste+2% "Double Attack"+5% "Store TP"+5)
 
		--Cichol's Mantle (STR+20 ACC+20 ATK+20 DA+10% DA DMG+20 Berserk Duration+15)
 
		--Cichol's Mantle (VIT+30 ACC+20 ATK+20 WSD+10% DA DMG+20 Berserk Duration+15)
 
 
     -- Engaged set, assumes Chango
    sets.engaged = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	}--4851.888
		
		--------------------------------------------------------------------------
		--Head TA+5
		--Body DA+7
		--Neck DA+2
		--Ear1 DA+5
		--Ear2 DA+3
		--Hands DA+6
		--Ring2 QA+3%
		--Back DA+10
		--Waist DA+8
		--Legs DA+11
		--Feet DA+6
		--Total: DA+58 (+23)=(DA+81) TA+5 QA+3%
		--TOTAL ACC: 1,211 ~~~~~> 1,224
	 
	sets.engaged.Bad_Ass_Set = {ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Flamma Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	}
	
	--- ACC: 1,234
	 
	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		ammo="Amar Cluster",
		head="Pummeler's Mask +2",
		neck="Subtlety Spectacles",
		ear1="Telos Earring",                              
		ear2="Digni. Earring",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})
	
	--[[
		ACC:
		Ammo 	10
		neck 	15 
		ear1 	10
		ear2 	6
		ring2 	10
		back 	20
		belt 	12
		head 	37
		body 	50
		hands 	38
		ring1 	11
		legs 	56
		feet 	36
		
		SET:	5/5= +60
		TOTAL:		371			
		(1,274 ACC) ~> 1,292
	
	]]
	
	sets.engaged.Test2 = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Petrov Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	}--4851.888
	
	
		--------------------------------------------------------------------------
		--Head TA+5
		--Body DA+7
		--Neck DA+2
		--Ear1 DA+5
		--Ear2 DA+3
		--Hands DA+6
		--Ring1 DA+1
		--Ring2 QA+3%
		--Back DA+10
		--Waist DA+8
		--Legs DA+11
		--Feet DA+6
		--Total: DA+59 (+23)=(DA+82) TA+5 QA+3%
		--TOTAL ACC: 1201
		
	
	sets.engaged.Test1 = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Flamma Korazin +2",
		hands="Sulev. Gauntlets +2",
		ring1="Chirich Ring",
		ring2="Chirich Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	}
	
	
	sets.engaged.DA = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Petrov Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	}--Argosy Hauberk/"Pumm. Cuisses +3"
		
	
     sets.engaged.Mid = set_combine(sets.engaged, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
        body="Flamma Korazin +2",
		hands="Sulev. Gauntlets +2",
		ring1="Petrov Ring",
		ring2="Chirich Ring",
        back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Boii Mask 
	
	sets.engaged.Store_TP = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		ring1="Petrov Ring",
		ring2="Chirich Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Weapon skill damage +2%','STR+5','Attack+14',}},
		feet="Flam. Gambieras +1",
	}--Argosy Hauberk
		
		
     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

	sets.engaged.SW = set_combine(sets.engaged, {legs="Boii Cuisses +1"})--Agoge Mufflers +3
	 
	sets.engaged.SW.Acc = set_combine(sets.engaged.Acc, {legs="Boii Cuisses +1"})--Agoge Mufflers +3
	 
	sets.engaged.SW.DA = set_combine(sets.engaged.DA, {legs="Boii Cuisses +1"})--Boii Mask
	 
	sets.engaged.SW.Mid = set_combine(sets.engaged.Mid, {legs="Boii Cuisses +1"})
	 
	sets.engaged.SW.Store_TP = set_combine(sets.engaged.Store_TP, {legs="Boii Cuisses +1"})
	 
    sets.engaged.DW = set_combine(sets.engaged, {
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
	})
    
	sets.engaged.DW.DA = set_combine(sets.engaged.Mid,  {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Petrov Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Argosy Hauberk
	
	sets.engaged.DW.Mid = set_combine(sets.engaged.Mid, {
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
	})
	 
	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
	})
	 
	sets.engaged.DW.Store_TP = set_combine(sets.engaged.Store_TP, {
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
	})
	
	sets.engaged.OneHand = set_combine(sets.engaged, {legs="Boii Cuisses +1"})
	--Agoge Mufflers +3
	 
	sets.engaged.OneHand.Acc = set_combine(sets.engaged.Acc, {legs="Boii Cuisses +1"})
	--Agoge Mufflers +3
	
	sets.engaged.OneHand.Mid = set_combine(sets.engaged.Mid, {legs="Boii Cuisses +1"})
	
	sets.engaged.OneHand.Store_TP = set_combine(sets.engaged.Store_TP, {legs="Boii Cuisses +1"})
	 
    sets.engaged.GreatSword = set_combine(sets.engaged, {})
     
	sets.engaged.GreatSword.DA = set_combine(sets.engaged.Mid, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Agoge Lorica +3",
		hands="Sulev. Gauntlets +2",
		ring1="Petrov Ring",
		ring2="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})--Argosy Hauberk
	 
	sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {})
	 
    sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
		ammo="Ginsen",
		head="Pummeler's Mask +2",
		neck="Subtlety Spectacles",
		ear1="Telos Earring",                              
		ear2="Digni. Earring",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
		waist="Ioskeha Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})

	sets.engaged.GreatSword.Store_TP = set_combine(sets.engaged.Store_TP, {})	
		
    sets.engaged.Reraise = set_combine(sets.engaged, {
		head="Twilight Helm",
		body="Twilight Mail",
	})
     
	sets.engaged.Reraise.Mid = set_combine(sets.engaged.Mid, {
		head="Twilight Helm",
		body="Twilight Mail",
	})
	 
	sets.engaged.Reraise.Acc = set_combine(sets.engaged.Acc, {
		head="Twilight Helm",
		body="Twilight Mail",
	})
	 
	sets.engaged.Reraise.Store_TP = set_combine(sets.engaged.Store_TP, {
		head="Twilight Helm",
		body="Twilight Mail",
	})
	 
	sets.buff.Berserk = {
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}--feet="Warrior's Calligae +2"
	
	sets.buff["Warrior's Charge"] = {
		legs="Agoge Cuisses +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.buff.Restraint = {
		hands="Boii Mufflers +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
    sets.buff['Restraint'] = set_combine(sets.engaged,  {
		hands="Boii Mufflers +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	})
	sets.buff.Retaliation = {
		hands="Pumm. Mufflers +2",
		feet="Boii Calligae +1",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.buff.Doomed = {
		ring2="Saida Ring",
		waist="Gishdubar Sash",
	}
end


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    --elseif spell.target.distance > 8 and player.status == 'Engaged' then
    --    eventArgs.cancel = true
    --    add_to_chat(122,"Outside WS Range! /Canceling")
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end
 
function job_post_precast(spell, action, spellMap, eventArgs)

    -- Make sure abilities using head gear don't swap 
	if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
        --if is_sc_element_today(spell) then
          --  if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            --else
                --equip(sets.WSDayBonus)
          --  end
        end
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        
		if player.tp > 2250 then
            equip(sets.TP_Bonus)	
		end
		
        if player.tp > 2999 then
            equip(sets.BrutalLugra)
        else -- use Lugra + moonshade
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.Lugra)
            else
                --equip(sets.Brutal)
            end
        end
        -- Use SOA neck piece for WS in rieves
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
    end

 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
        equip(sets.buff.Berserk)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Berserk and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Berserk)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
 
function customize_melee_set(meleeSet)
    if state.Buff.Restraint and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Restraint)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end 
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if buffactive.Berserk and not state.Buff.Retaliation then
            equip(sets.buff.Berserk)
        end
        get_combat_weapon()
    --elseif newStatus == 'Idle' then
    --    determine_idle_group()
    end
    end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Vocation', 'Capacity'}:contains(player.equipment.ring2) then
        if not buffactive['Dedication'] then
            disable('ring2')
        end
    else
        enable('ring2')
    end
    
    if buff == "Berserk" then
        if gain and not buffactive['Retaliation'] then
            equip(sets.buff.Berserk)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

	if buff == "Restraint" then
        if gain and not buffactive['Retaliation'] then
            equip(sets.buff.Restraint)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    	if buffactive.Restraint and not buffactive['Retaliation'] then
            equip(sets.buff.Restraint)
        end
        get_combat_weapon()
    --elseif newStatus == 'Idle' then
    --    determine_idle_group()
	end
	
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    war_sj = player.sub_job == 'WAR' or false
    get_combat_form()
    get_combat_weapon()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    --if war_sj then
        --state.CombatForm:set("War")
    --else
        --state.CombatForm:reset()
    --end
    if S{'NIN', 'DNC'}:contains(player.sub_job) and war_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    elseif S{'SAM', 'WAR'}:contains(player.sub_job) and player.equipment.sub == 'Rinda Shield' then
        state.CombatForm:set("OneHand")
    else
        state.CombatForm:reset()
    end

end

function get_combat_weapon()
    if gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatSword")
    else -- use regular set
        state.CombatWeapon:reset()
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    --if stateField == 'Look Cool' then
    --    if newValue == 'On' then
    --        send_command('gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
    --        --send_command('wait 1.2;gs c update user')
    --    else
    --        send_command('@input /lockstyle off')
    --    end
    --end
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
	end
end
