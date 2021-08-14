
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
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
	--Polearm1="Kaja Lance",
	--Shield1="Blurred Shield +1",
	--orb="Macrocosmic Orb",
} 

-- Setup vars that are user-independent.
function job_setup()

		state.Buff.Doomed = buffactive.doomed or false
        state.Buff.Battuta = buffactive.battuta or false
		--state.Buff.Embolden = buffactive.embolden or false

    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Tank3', 'PDT', 'Normal', 'Acc', 'Hybid')--'PDT', 'MDT', 'Resist', 'MP_Back' , 'Triple', 'Test1', 'Tank', 'Store_TP', 
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Tank', 'Hybid')--'MP_Back'
	state.MagicalDefenseMode:options('MDT', 'Resist')
    state.IdleMode:options('Regen', 'OhShitYouAreTheTank', 'Refresh') -- 'Refresh',

	select_default_macro_book()
	--[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")
	-----------------------------------------------
	state.Moving = M(false, "moving")
	state.Refresh = M(false, "Refresh")
	
	
	send_command("bind !` gs c toggle LockWeapon")
	send_command("bind !end gs c toggle Refresh")
end

function user_unload()
	send_command("unbind !`")
	send_command("unbind !end")
end

function init_gear_sets()
    sets.enmity = {
		ammo="Aqreqaq Bomblet",
		ear2="Friomisi Earring",
		ear1="Cryptic Earring",
		neck="Unmoving Collar +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
	}
	--Current Enmity :
	
	--main="Aettir"								(+10)
	--ammo="Aqreqaq Bomblet" 					(+2)
	--neck="Unmoving Collar +1" 				(+10)
	--ear1="Friomisi Earring"					(+2)
	--ear2="Cryptic Earring"					(+4)
	--head="Halitus Helm"						(+8)
	--body="Emet Harness +1"					(+10)
	--hands="Kurys Gloves"						(+9)
	--ring1="Petrov Ring"						(+4)
	--ring2="Begrudging Ring"					(+5)
	--back="Evasionist's Cape"					(+1~7)
	--waist="Warwolf Belt"						(+3)
	--legs="Eri. Leg Guards +1"					(+11)
	--feet="Rager Ledel. +1"					(+7)
	
	--TOTAL:									(+92) out of 95 possible Enmity.
	
	
	---------------------------------------------------------
	
	--Enmity + Gear
	
	--ammo="Sapience Orb" 						(+2)
	--ammo="Aqreqaq Bomblet" 					(+2)
	
	--head="Halitus Helm"               		(+8)
	--neck="Unmoving Collar +1" 				(+10)
	
	--ear1="Cryptic Earring"					(+4)
	--ear1="Friomisi Earring"					(+2)
	
	--ear2="Trux Earring"						(+5)
	--body="Emet Harness +1"					(+10)
	--hands="Kurys Gloves"						(+9)
	
	--ring1="Petrov Ring"						(+4)
	--ring1="Supershear Ring"					(+5)
	
	--ring2="Begrudging Ring"					(+5)
	--back="Evasionist's Cape"					(+1~7)
	--waist="Warwolf Belt"						(+3)
	--legs="Eri. Leg Guards +1"					(+10)
	--feet="Rager Ledel. +1"					(+7)
	--feet="Erilaz Greaves +1"					(+6)
	

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = set_combine(sets.enmity, {
		body="Runeist Coat +2",
		legs="Futhark Trousers +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.enmity, {
		feet="Runeist Bottes +2",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	})
    sets.precast.JA['Battuta'] = {
		head="Futhark Bandeau +1",
		hands="Turms Mittens",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	--legs="Rawhide Trousers",feet="Futhark Boots +1"
    sets.precast.JA['Liement'] = {body="Futhark Coat +3"}
    sets.precast.JA['Lunge'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Baetyl Pendant",
		ear2="Friomisi Earring",
		ear1="Hecate's Earring",
		body="Samnuha Coat",
		hands="Leyline Gloves",
		ring1="Stikini Ring +1",
		ring2="Shiva Ring +1",
		back="Evasionist's Cape",
		waist="Eschan Stone",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}--Argocham. Mantle,
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +2"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {
		back="Evasionist's Cape",
		legs="Futhark Trousers +1",
		head="Erilaz Galea +1",
	}--Erilaz Galea +1
    
	sets.precast.JA['Vivacious Pulse'] = {
		head="Erilaz Galea +1",
		legs="Rune. Trousers +2",
		ear1="Beatific Earring",
		neck="Incanter's Torque",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	}--Erilaz Galea +1 / Altruistic Cape / Bishop's Sash
	
    sets.precast.JA['One For All'] = {}--More HP the More Shield it gives.
    
	sets.precast.JA['Provoke'] = set_combine(sets.enmity, {	
		ammo="Aqreqaq Bomblet",
		ear2="Friomisi Earring",
		ear1="Cryptic Earring",
		neck="Unmoving Collar +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
	})


	sets.TP_Bonus        = {ear2="Cessance Earring"}
    -- Waltz set (chr and vit)
	sets.precast.Waltz = {
		ammo="Yamarang",
		head="Mummu Bonnet +1",
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Roundel Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands="Slither Gloves +1",
		ring1="Niqmaddu Ring",
		ring2="Titan Ring +1",
		back={ name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Phys. dmg. taken-10%',}},
		waist="Warwolf Belt",
		legs="Samnuha Tights",
		feet="Rawhide Boots",
	} --head="Lilitu Headpiece"
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {
		ammo="Yamarang",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +1",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		waist="Ioskeha Belt",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		neck="Subtlety Spectacles",
	}
    
	sets.precast.Flourish1 = {
		head="Aya. Zucchetto +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +1",
		ear2="Gwanti Earring",
		ear1="Digni. Earring",
		waist="Ioskeha Belt",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		ammo="Amar Cluster",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		neck="Subtlety Spectacles",
	}
	
	
	-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head="Carmine Mask",
		body="Dread Jupon",
		hands="Leyline Gloves",
		legs="Rawhide Trousers",
		feet="Carmine Greaves",
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}--Runeist Bandeau
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash",
		legs="Futhark Trousers +1",
		head="Carmine Mask",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})-- Manasa Chasuble / Erilaz Galea / Carmine Mask
	
	-----------------------------------------------------
	----------------------------------------------------
    --EXPERIMENTAL FC Stoneskin
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		neck="Nodens Gorget",
		legs="Doyen Pants",
		feet="Carmine Greaves",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
	
	----------------------------------------------------
	----------------------------------------------------
	
	sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {
		neck="Magoraga Beads",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {
		neck="Magoraga Beads",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})


	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Meghanada Visor +2",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet="Meg. Jam. +1",
	}--Dampening Tam
    
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	})
	
	
	---			Special  Weapon Skills
    
	--Great Sword 			Weapon Skills
	sets.precast.WS['Resolution'] = {
		ammo="Knobkierrie",
		head="Adhemar Bonnet",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		body={ name="Herculean Vest", augments={'Accuracy+18','"Triple Atk."+2','STR+10','Attack+6',}},
		hands="Adhemar Wristbands",
		ring2="Epona's Ring",
		ring1="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Ioskeha Belt",
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}--  (Mantle WSD+) / (WSD/DA/TA Herc Feet/legs)
   
	--[[
	sets.precast.WS['Resolution'] = {
			ammo="Knobkierrie",
			head="Adhemar Bonnet",
			neck="Fotia Gorget",
			ear1="Sherida Earring",
			ear2="Moonshade Earring",
			body={ name="Herculean Vest", augments={'Accuracy+18','"Triple Atk."+2','STR+10','Attack+6',}},
			hands="Adhemar Wristbands",
			ring2="Shukuyu Ring",
			ring1="Niqmaddu Ring",
			back="Ogma's Cape",
			waist="Fotia Belt",
			legs="Samnuha Tights",
			feet="Lustratio Leggings"
		}
	]]
   
   sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
		ammo="Amar Cluster",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		legs="Meg. Chausses +2",
	})--Futhark Mitons
		
    sets.precast.WS['Dimidiation'] = {
		ammo="C. Palug Stone",
		head="Meghanada Visor +2",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Lustratio Subligar",
		feet="Lustratio Leggings",
	}-- (WSD/DA/TA Herc Feet/legs)
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
		ammo="Amar Cluster",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	})
    
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {
		hands="Leyline Gloves",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
	})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'], {})

	sets.precast.WS['Freezebite'] = sets.precast.WS['Herculean Slash']
	sets.precast.WS['Frostbite'] = sets.precast.WS['Herculean Slash']

	sets.precast.WS['Ground Strike'] = {
		ammo="Knobkierrie",
		head="Carmine Mask",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body={ name="Herculean Vest", augments={'Accuracy+18','"Triple Atk."+2','STR+10','Attack+6',}},
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Phys. dmg. taken-10%',}},
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet="Lustratio Leggings",
	}--Ishvara Earring

	--Polearm
	

	--Sword 			Weapon Skills
	sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head="Carmine Mask",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body={ name="Herculean Vest", augments={'Accuracy+18','"Triple Atk."+2','STR+10','Attack+6',}},
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet="Lustratio Leggings",
	}--Ishvara Earring

	sets.precast.WS['Requiescat'] = {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Stikini Ring +1",
		ring2="Rufescent Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}

	--Axe 				Weapon Skills
	sets.precast.WS['Ruinator'] = {
		ammo="Knobkierrie",
		head="Carmine Mask",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet="Lustratio Leggings",
	}

	--Great Axe 		Weapon Skills
	sets.precast.WS['Upheaval'] = {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Niqmaddu Ring",
		ring2="Titan Ring +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}

	--Club 				Weapon Skills
	sets.precast.WS['Realmrazer'] = {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Stikini Ring +1",
		ring2="Rufescent Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}

	sets.precast.WS['True Strike'] = {
		ammo="Knobkierrie",
		head="Carmine Mask",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet="Lustratio Leggings",
	}--Ishvara Earring

	sets.precast.WS['Judgement'] = {
		ammo="Knobkierrie",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring2="Epona's Ring",
		ring1="Niqmaddu Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Fotia Belt",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {
		ammo="Impatiens",
		head="Carmine Mask",
		body="Dread Jupon",
		hands="Leyline Gloves",
		legs="Rawhide Trousers",
		feet="Carmine Greaves",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
	}--Carmine Mask
	
    sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FC, {
		ammo="Impatiens",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Magnetic Earring",
		head="Carmine Mask",
		body="Manasa Chasuble",
		hands="Runeist Mitons +2",
		legs="Carmine Cuisses +1",
		feet="Carmine Greaves",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
		waist="Siegel Sash",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	})
    
	--sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FC, {neck="Incanter's Torque",ear1="Andoaa Earring",hands="Runeist Mitons +2",waist="Siegel Sash",legs="Futhark Trousers +1",head="Erilaz Galea +1",body="Manasa Chasuble",ring1="Stikini Ring +1",ring2="Stikini Ring +1"})
	
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		head="Futhark Bandeau +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
    
	--[[
		Taeon Body / hands / legs / feet (Phalanx+3)
	]]
	
	sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {
		head="Rune. Bandeau +2",
		legs="Futhark Trousers +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
    
	--[[
	
	sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
		ammo="Impatiens",
		legs="Carmine Cuisses +1",
		ear1="Halasz Earring",
		ear2="Magnetic Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}) -- 63%
	
		Job Trait 				10%
		Mantle 					10%
		ammo					10%
		legs 					20%
		Magnetic Earring		8%
		Halasz Earring 			5%
		Evanescence Ring		5%
		Audumbla Sash  			10%
		Rumination Sash 		10%
		Karasutengu (Feet)		15%
		Willpower Torque 		5%
		Moonlight Necklace (HQ)	15%
		Moonbeam Necklace (NQ) 	10%
		
		total: 100% 
	]]
	
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
		head="Erilaz Galea +1",
		body="Runeist Coat +2",
		legs="Futhark Trousers +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		waist="Gishdubar Sash",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})--Erilaz Galea +1
	
	sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		head="Carmine Mask",
		legs="Futhark Trousers +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		ear1="Andoaa Earring",
		ear2="Earthcry Earring",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
    
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
		ring1="Sheltered Ring",
		ring2="Stikini Ring +1",
		legs="Futhark Trousers +1",
		head="Carmine Mask",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
		ring1="Sheltered Ring",
		ring2="Stikini Ring +1",
		legs="Futhark Trousers +1",
		head="Carmine Mask",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
		})
	sets.midcast.Shell = sets.midcast.Shellra
	
	sets.midcast.Cure = set_combine(sets.precast.FC, {
		neck="Incanter's Torque",
		hands="Buremte Gloves",
		feet="Futhark Boots +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		ear1="Mendi. Earring",
		ear2="Roundel Earring",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})

	sets.midcast['Flash'] = set_combine(sets.enmity, {	
		ammo="Aqreqaq Bomblet",
		ear2="Friomisi Earring",
		ear1="Cryptic Earring",
		neck="Unmoving Collar +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
	})
	
	sets.midcast['Foil'] = set_combine(sets.enmity, {
		ammo="Aqreqaq Bomblet",
		ear2="Friomisi Earring",
		ear1="Cryptic Earring",
		neck="Unmoving Collar +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
	})
	
	sets.midcast['Crusade'] = set_combine(sets.enmity, {
		ammo="Aqreqaq Bomblet",
		ear2="Friomisi Earring",
		ear1="Cryptic Earring",
		neck="Unmoving Collar +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
	})
	
	sets.midcast['Blue Magic'] = set_combine(sets.enmity, {
		ammo="Aqreqaq Bomblet",
		ear2="Friomisi Earring",
		ear1="Cryptic Earring",
		neck="Unmoving Collar +1",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Warwolf Belt",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
	})
	
	sets.midcast['Refueling'] = set_combine(sets.midcast['Enhancing Magic'], {
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
	
	sets.midcast['Cocoon'] = set_combine(sets.midcast['Enhancing Magic'], {
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
	
	sets.midcast['Wild Carrot'] = set_combine(sets.precast.FC, {
		neck="Incanter's Torque",
		hands="Buremte Gloves",
		feet="Futhark Boots +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		ear1="Mendi. Earring",
		ear2="Roundel Earring",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
	
	sets.midcast['Pollen'] = set_combine(sets.precast.FC, {
		neck="Incanter's Torque",
		hands="Buremte Gloves",
		feet="Futhark Boots +1",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		ear1="Mendi. Earring",
		ear2="Roundel Earring",
		back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	--Rune. Bandeau +1
	--Runeist Coat +1
	--Runeist Mitons +1
	--Rune. Trousers +1
	--Runeist Bottes +1
	
	--Herculean Vest (STR+10 ACC+18 ATK+6 TA+2%)
	--Montante +1 (Triple Attack +3~5% Store TP +11 ATK+33 DMG:+299 Delay:489)
	--Zulfiqar (WSD+10% ACC+36 ATK+30 DMG:297 Delay:504)
	
    sets.idle = {
		ammo="Homiliary",
		head="Rawhide Mask",
		body="Futhark Coat +3",
		hands="Turms Mittens",
		legs="Rawhide Trousers",
		feet="Turms Leggings",
		neck="Sanctity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Fucho-No-Obi",
	}--Paguroidea Ring
    
	sets.idle.Town = {
		main="Lionheart",
		sub="Utu Grip",
		ammo="Homiliary",
		head="Rawhide Mask",
		neck="Sanctity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Futhark Coat +3",
		hands="Turms Mittens",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		waist="Fucho-No-Obi",
		legs="Rawhide Trousers",
		feet="Turms Leggings",
	}--Montante +1/Nepenthe Grip +1
	
	sets.idle.Refresh = set_combine(sets.idle, {
		body="Runeist Coat +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	})
	
	sets.idle.OhShitYouAreTheTank = set_combine(sets.idle, {
		main="Aettir",
		ammo="Staunch Tathlum",
		head="Futhark Bandeau +1",
		body="Futhark Coat +3",
		hands="Turms Mittens",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Flume Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Phys. dmg. taken-10%',}},
	})--PDT 50% PDTII 5%  = -55%
	
	--back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	--back={ name="Ogma's cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Phys. dmg. taken-10%',}},
	--back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	--back={ name="Ogma's cape", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-10%',}},
	
	---------------------------------------
	-- Defensive Sets
	---------------------------------------
	
	--Meghanada Visor +2	(PDT-5%)
	--Futhark Coat +1		(DT-7%)
	--Meg. Cuirie +2		(PDT-8%)
	--Meg. Gloves +2		(PDT-4%)
	--Erilaz Leg Guards		(PDT-6%)
	--Erilaz Greaves        (PDT-4%)
	
	--Mollusca Mantle		(DT-5%)
	--Flume Belt			(PDT-4%)
	--Defending Ring		(DT-10%)
	--Dark Ring				(DT-3%)
	--Twilight Torque		(DT-5%)
	--Evasionist's Cape		(DT-5% / PDT-8%)
	--Staunch Tathlum		(DT-2%)
	
	sets.defense.PDT = {
		main="Aettir",
		ammo="Staunch Tathlum",
		head="Futhark Bandeau +1",
		body="Futhark Coat +3",
		hands="Meg. Gloves +2",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Flume Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}--Aya. Manopolas +1

	--Weapon 	PDT II -5%
	--ammo		DT-2
	--head		PDT-4
	--body 		DT-9
	--hands		PDT-4
	--legs		PDT-7%
	--feet		PDT-5
	--neck		DT-6
	--waist		PDT-4
	--back		(PDT-10)
	--ring1		DT-3
	--ring2		DT-10
	--ear1 		MDT-3
	--ear2		MDT-3
	--Total of:  PDT 64%     PDT II 5%     MDT 36%
	sets.defense.MDT =  set_combine(sets.defense.PDT,  {
		main="Aettir",
		ammo="Staunch Tathlum",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Engraved Belt",
		neck="Warder's Charm +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		back="Solemnity Cape",
		head="Aya. Zucchetto +2",
		body="Futhark Coat +3",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Volte Spats",
	})--DT-42% MDT-37%

	sets.defense.Resist = set_combine(sets.defense.PDT, {
		main="Aettir",
		ammo="Staunch Tathlum",
		waist="Engraved Belt",
		neck="Warder's Charm +1",
		hands="Erilaz Gauntlets +1",
		legs="Rune. Trousers +2",
		feet="Erilaz Greaves +1",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
		ring1="Warden's Ring",
	})
	
	sets.defense.MP_Back = set_combine(sets.defense.PDT, {
		body="Erilaz Surcoat +1",
	})
	
	sets.defense.Tank = {
		main="Aettir",
		ammo="Staunch Tathlum",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		head="Meghanada Visor +2",
		body="Erilaz Surcoat +1",
		hands="Turms Mittens",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Flume Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}-- PDT-40% DT-20%
	
	sets.defense.Hybid = {
		main="Lionheart",
		ammo="Yamarang",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Ioskeha Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.Kiting = {
		main="Aettir",
		ammo="Staunch Tathlum",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		head="Meghanada Visor +2",
		body="Futhark Coat +3",
		hands="Aya. Manopolas +1",
		legs="Carmine Cuisses +1",
		feet="Erilaz Greaves +1",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Flume Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}--Skadi's Jambeaux +1

	sets.latent_refresh = {waist="Fucho-No-Obi"}

	sets.Adoulin = {legs="Carmine Cuisses +1"}
	sets.MoveSpeed = {legs="Carmine Cuisses +1"}
	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
		main="Lionheart",
		ammo="Yamarang",
		head="Adhemar Bonnet",
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Adhemar Jacket",
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Ioskeha Belt",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}
    
	sets.engaged.Test1 = {
		main="Lionheart",
		ammo="Yamarang",
		head="Adhemar Bonnet",
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Adhemar Jacket",
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Chirich Ring",
		ring2="Chirich Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Ioskeha Belt",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}
	
	sets.engaged.Tank = {
		main="Aettir",
		ammo="Staunch Tathlum",
		head="Meghanada Visor +2",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Erilaz Surcoat +1",
		hands="Turms Mittens",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Flume Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}-- PDT-40% DT-20%
	
	sets.engaged.Tank3 = {
		main="Aettir",
		ammo="Staunch Tathlum",
		head="Futhark Bandeau +1",
		body="Futhark Coat +3",
		hands="Turms Mittens",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Flume Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	--[[
		
	
	]]
	
	--[[
		Futhark Bandeau +1 (+3)
		Futhark Coat +1 	(+3)
		Futhark Boots +1	(+3)
		Turms Mittens +1
		Flume Belt +1
		Ayanmo Legs +2
		Etiolation Earring / Cryptic Earring
		Moonlight Ring / Defending Ring
		Futhark neck +2
		Staunch Tathlum +1
		Khonsu (Grip)
		Epeo.
	]]
	
	sets.engaged.Hybid = {
		main="Lionheart",
		ammo="Yamarang",
		head="Aya. Zucchetto +2",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2",
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Ioskeha Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.engaged.Triple = {
		main="Lionheart",
		ammo="Yamarang",
		head="Adhemar Bonnet",
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Adhemar Jacket",
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Hetairoi Ring",
		ring2="Epona's Ring",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		waist="Windbuffet Belt +1",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
	}
	
	sets.engaged.Store_TP = set_combine(sets.engaged,  {
		ammo="Yamarang",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet="Carmine Greaves",
		neck="Anu Torque",
		ring1="Petrov Ring",
		ring2="Epona's Ring",
		ear1="Sherida Earring",
		ear2="Telos Earring",
		waist="Reiki Yotai",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	})
	
    sets.engaged.Acc = set_combine(sets.engaged, {
		ammo="Amar Cluster",
		head="Meghanada Visor +2",
		neck="Subtlety Spec.",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		waist="Ioskeha Belt",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +1",
		back={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		ear1="Digni. Earring",
		ear2="Telos Earring",
	})
    
	sets.engaged.PDT = {
		main="Aettir",
		ammo="Staunch Tathlum",
		head="Meghanada Visor +2",
		ear1="Sherida Earring",
		ear2="Cessance Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Flume Belt",
		neck="Loricate Torque +1",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
    
	sets.engaged.MDT = set_combine(sets.engaged.PDT, {
		ammo="Staunch Tathlum",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Engraved Belt",
		neck="Warder's Charm +1",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
		head="Aya. Zucchetto +2",
		body="Futhark Coat +3",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	})
    
	sets.engaged.Resist = set_combine(sets.engaged.PDT, {
		main="Aettir",
		ammo="Staunch Tathlum",
		waist="Engraved Belt",
		neck="Warder's Charm +1",
		hands="Erilaz Gauntlets +1",
		legs="Rune. Trousers +2",
		feet="Erilaz Greaves +1",
		ear1="Hearty Earring",
		ear2="Etiolation Earring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	})
	
	sets.engaged.MP_Back = set_combine(sets.engaged.PDT, {
		main="Aettir",
		body="Erilaz Surcoat +1",
	})
	
	sets.engaged.Repulse = set_combine(sets.engaged.PDT,  {
		main="Aettir",
		back="Repulse Mantle",
	})

	
	sets.buff.Battuta = {
		head="Futhark Bandeau +1",
		hands="Turms Mittens",
		legs="Eri. Leg Guards +1",
		feet="Turms Leggings",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
	}
	--legs="Rawhide Trousers",feet="Futhark Boots +1"
	
	--[[sets.buff.Embolden = {
		back="Evasionist's Cape",
		legs="Futhark Trousers +1",
		head="Erilaz Galea +1",
	}]]
	
	sets.buff.Doomed = {
		ring2="Saida Ring",
		waist="Gishdubar Sash",
	}
end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)  
    if state.Buff.Battuta then
                meleeSet = set_combine(meleeSet, sets.buff.Battuta)
        end
	--if sets.buff.Embolden(meleeSet) then
		--meleeSet = set_combine(meleeSet,  sets.buff.Embolden)
		--end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
		return meleeSet
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist="Hachirin-No-Obi"})
        end
    end
end


function job_aftercast(spell)
    if not spell.interrupted then
        if spell.type == 'Rune' then
            update_timers(spell)
        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
            reset_timers()
        elseif spell.name == "Swipe" then
            send_command(trim(1))
        end
    end
end


---------TP TEST
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
		if player.tp > 2250 then
            equip(sets.TP_Bonus)	
		end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    --if spell.action_type == 'Magic' then
       -- apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    --end
	if spell.skill == 'Blue Magic'  then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-No-Obi"})
            --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
        end
    end
	--if spell.skill == 'Blue Magic' then
      --  if state.MagicBurst.value then
        --equip(sets.magic_burst)
        --end
	--end
	if spell.type == "WeaponSkill" then
      if spell.element == world.weather_element or spell.element == world.day_element then
        --equip({waist="Hachirin-no-Obi"})
        --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
      end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 4)
	elseif player.sub_job == 'BLU' then
		set_macro_page(1, 4)
	else
		set_macro_page(1, 4)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end

-------------Weapon lock
function validateTextInformation()
if state.LockWeapon.value then
        --main_text_hub.toggle_lock_weapon = const_on
    else
        --main_text_hub.toggle_lock_weapon = const_off
    end
end

function job_state_change(stateField, newValue, oldValue)
   if stateField == "Lock Weapon" then --Updates HUB and disables/enables window for Lock Weapon
        if newValue == true then
			disable("main")
			disable("sub")
            --main_text_hub.toggle_lock_weapon = "ON"
        else
            enable("main")
			enable("sub")
            --main_text_hub.toggle_lock_weapon = "OFF"
        end 
end
end

------------------------------------Mov---------------------------------------------
mov= {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
	mov.x = windower.ffxi.get_mob_by_index(player.index).x
	mov.y = windower.ffxi.get_mob_by_index(player.index).y
	mov.z = windower.ffxi.get_mob_by_index(player.index).z
end	

moving = false
windower.raw_register_event('prerender', function()
	mov.counter = mov.counter +1;
	if buffactive['Mana Wall'] then
		moving = false
	elseif mov.counter > 15 then
		local p1 = windower.ffxi.get_mob_by_index(player.index)
		if p1 and p1.x and mov.x then
			dist = math.sqrt( (p1.x-mov.x)^2 + (p1.y-mov.y)^2 + (p1.z-mov.z)^2 )
			if dist > 1 and not moving then
				state.Moving.value = true
				send_command('gs c update')
				if world.area:contains("Adoulin") then
					send_command('gs equip sets.Adoulin')
					else
					send_command('gs equip sets.MoveSpeed')
				end
		moving = true
			elseif dist < 1 and moving then
				state.Moving.value = false
				send_command('gs c update')
				moving = false
			end
		end
	if p1 and p1.x then
		mov.x = p1.x
		mov.y = p1.y
		mov.z = p1.z
	end
	
	mov.counter = 0

	end
end)
------------------------Auto-Refresh-------------------------------------------------
function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type ~= 'JobAbility' then
        auto_refresh()
    end
end


function auto_refresh()
    local spell_recasts = windower.ffxi.get_spell_recasts()
    if state.Refresh.value == true then 
	if not (buffactive['Refresh']) then
        if not (buffactive['Invisible'] or buffactive['Weakness'] or buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
            if spell_recasts[10] == 0 then
                send_command('@wait 2;input /ma "Refresh" <me>')
            end
        end
    
    end         
end
end
------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
    local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    --add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
        local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)