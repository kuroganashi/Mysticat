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

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	state.Buff.Doomed = buffactive.doomed or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	
	state.MagicBurst = M(false, 'Magic Burst')
	
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
	send_command("bind Delete gs c toggle MagicBurst")
end

function user_unload()
	send_command("unbind !`")
	send_command("unbind !end")
	send_command("unbind Delete")
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		main="Yagrush",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		head="Nahtirah Hat",
		neck="Voltsurge Torque",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Eirene's Manteel",
		hands="Fanatic Gloves",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back="Perimede Cape",
		waist="Witful Belt",
		legs="Lengo Pants",
		feet="Regal Pumps +1",
	} --Nahtirah Hat
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		sub="Ammurapi Shield",
		ammo="Impatiens",
		ear1="Loquacious Earring",
		back="Perimede Cape",
		waist="Siegel Sash",
	})

	----------------------------------------------------------------
	----------------------------------------------------------------
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		neck="Nodens Gorget",
		legs="Doyen Pants",
		sub="Ammurapi Shield",
		feet="Regal Pumps +1",
	})
	
	----------------------------------------------------------------
	----------------------------------------------------------------

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		sub="Sors Shield",
		legs="Ebers Pant. +1",
		feet="Regal Pumps +1",
	})--Ebers Pantaloons +1

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Impatiens",
		hands="Fanatic Gloves",
		body="Heka's Kalasiris",
		ear1="Glorious Earring",
		ear2="Mendi. Earring",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		neck="Aceso's Choker +1",
		feet="Hygieia Clogs +1",
		legs="Doyen Pants",
	}) --body="Heka's Kalasris",ear1="Glorious Earring",feet="Hygieia Clogs +1",legs="Ebers Pant. +1"/"Pahtli Cape"
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Nahtirah Hat",
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Roundel Earring",
		body="Ebers Bliaud",
		hands="Theophany Mitts +2",
		ring1="Titan Ring +1",
		ring2="Titan Ring",
		back="Iximulew Cape",
		waist="Warwolf Belt",
		legs="Th. Pantaloons +2",
		feet="Gendewitha Galoshes",
	}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    sets.precast.WS = {
		ammo="Floestone",
		head="Aya. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Shukuyu Ring",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Fotia Belt",
		legs="Th. Pantaloons +2",
		feet="Aya. Gambieras +1",
	}--Fanatic Gloves/"Alaunus's Cape"
    
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS,  {
		ammo="Pemphredo Tathlum",
		head="Aya. Zucchetto +2",
		neck="Baetyl Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +3",
		hands="Fanatic Gloves",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Toro Cape",
		waist="Refoccilation Stone",
		legs="Lengo Pants",
		feet="Medium's Sabots",
	})--Fanatic Gloves/"Alaunus's Cape"
		
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,   {
		head="Aya. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Fotia Belt",
		legs="Th. Pantaloons +2",
		feet="Aya. Gambieras +1",
	})--Fanatic Gloves/"Alaunus's Cape"
    
	---------------------------------MYSTIC BOOM-------------------------------------------
	
	sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS, {
		ammo="Floestone",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		waist="Luminary Sash",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		head="Aya. Zucchetto +2",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		legs="Th. Pantaloons +2",
		feet="Aya. Gambieras +1",
	})--"Alaunus's Cape"

	----------------------------------------------------------------------------------------
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
		main="Yagrush",
		ammo="Impatiens",
		head="Nahtirah Hat",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		neck="Voltsurge Torque",
		body="Eirene's Manteel",
		hands="Fanatic Gloves",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Witful Belt",
		legs="Lengo Pants",
		feet="Regal Pumps +1",
	}
    
    -- Cure sets
    gear.default.obi_waist = "Witful Belt"
    gear.default.obi_back = "Alaunus's Cape"

    sets.midcast.CureSolace = set_combine(sets.precast.FastRecast,   {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Hydrocera",
		head="Vanya Hood",
		neck="Nodens Gorget",
		ear1="Glorious Earring",
		ear1="Nourish. Earring +1",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Luminary Sash",
		legs="Ebers Pant. +1",
		feet="Medium's Sabots"
	}) 

		--hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}}
		
		--Cure Pot / Spellcast down / Cure Pot II
		--main		(Pot+10 Pot II+2 Spellcast-7)
		--sub		(Pot+3 Spellcast-5)
		
		--head 		(Pot+13%)
		--body		(Pot+5% Pot II +3)
		--hands		(Pot+10 FC+5)
		--legs		(Spellcast-12 FC+10)
		--feet		(Pot+10)
		
		--ammo		(QM+2)
		--ear1		(Pot+5 Spellcast-5)
		--ear2		(Pot II +2%)
		--neck		(Spellcast-13)
		--ring1		(FC+10 QM+5)
		--ring2		(FC+5)
		--waist		(FC+5 QM+3)
		--back		(Spellcast-8)
		
		--Total:	Pot+51 Pot II+7 Spellcast-50 FC+35 QM+10
		
		--------------------------Set 2---------------------------------------------
		--Cure Pot / Spellcast down / Cure Pot II
		--main		(Pot+10 Pot II+2 Spellcast-7)
		--sub		(Pot+3 Spellcast-5)
		
		--head 		(Pot+17%)
		--body		(Pot II +3)
		--hands		(Pot II+2)
		--legs		(Spellcast-12 FC+10)
		--feet		(Pot+10)
		
		--ammo		(QM+2)
		--ear1		(Pot+6~7 Spellcast-4)
		--ear2		(Pot II +2%)
		--neck		(Pot+5)
		--ring1		(FC+10 QM+5)
		--ring2		(FC+5)
		--waist		(FC+5 QM+3)
		--back		(FC+10 MND+25)
		
		--Total:	Pot+51 Pot II+9 Spellcast-28 FC+40 QM+10
    sets.midcast.Cure = set_combine(sets.precast.FastRecast,    {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Hydrocera",
		head="Vanya Hood",
		neck="Nodens Gorget",
		ear1="Nourish. Earring +1",
		ear1="Glorious Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Luminary Sash",
		legs="Ebers Pant. +1",
		feet="Medium's Sabots",
	})--Queller Rod / Kaykaus Bliaut / Medium's Sabots / Telchine Gloves/Kaykaus Bliaut

	--Queller Rod (Pot+10% Pot II+2% Casting time -7% Healing skill+15 )	
	--Sors Shield (Pot +3% Spellcasting -5%)
	--Nodens Gorget (Cure Pot+5%)
	--Vanya Hood (Cure Pot +17%)
	--Theo. Bliaut +3 (Pot II +6%)
	--Theophany Mitts +2 (Pot II +2%)
	--Nourish. Earring +1 (MND+4 Pot +6~7% Spellcasting-4%)
	--Glorious Earring (Pot II +2%)
	--Medium's Sabots (Pot +10%)
	
	--Cure Potency         +51%
	--Cure Potency II      +12%
	--Spellcasting         -16%
	--MND                  +216~226
	--Haste                +20%
	--FC                   +10%
	--Enmity               -42%
	--Conserve MP          +7%
	--Healing Skill        +50
	
	 --hands={ name="Telchine Gloves", augments={'"Fast Cast"+5',}}
		
    sets.midcast.Curaga = set_combine(sets.precast.FastRecast,    {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Hydrocera",
		head="Vanya Hood",
		neck="Nodens Gorget",
		ear1="Nourish. Earring +1",
		ear1="Glorious Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Luminary Sash",
		legs="Ebers Pant. +1",
		feet="Medium's Sabots",
	})--Hygieia Clogs +1/Kaykaus Bliaut

    sets.midcast.CureMelee = set_combine(sets.precast.FastRecast,    {
		main="Queller Rod",
		sub="Sors Shield",
		ammo="Hydrocera",
		head="Vanya Hood",
		neck="Nodens Gorget",
		ear1="Nourish. Earring +1",
		ear1="Glorious Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Luminary Sash",
		legs="Ebers Pant. +1",
		feet="Medium's Sabots",
	})--Hygieia Clogs +1/Kaykaus Bliaut

    sets.midcast.Cursna = set_combine(sets.precast.FastRecast,    {
		main="Yagrush",
		ammo="Impatiens",
		head="Hyksos Khat",
		neck="Malison Medallion",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		body="Ebers Bliaud",
		hands="Fanatic Gloves",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Gishdubar Sash",
		legs="Th. Pantaloons +2",
		feet="Gendewitha Galoshes",
	})--Theo. Pant. +1 / 	Theo. Pantaloons 

	--[[
		Belt		Cursna received +10
		Ring1		Cursna +15
		Ring2		Cursna +15
		Necklace	Cursna +10*		 			(HQ 15)
		Mantle		Cursna +25
		Head		Healing magic skill +10 	(HQ Skill 11)
		Body		Healing magic skill +20
		Hands		Cursna +15
		Legs		Cursna +17
		Feet 		Cursna +10
	
	TOTAL:			Cursna +107%
	
	]]

    sets.midcast.StatusRemoval = set_combine(sets.precast.FastRecast,    {
		main="Yagrush",
		ammo="Impatiens",
		back="Mending Cape",
		neck="Voltsurge Torque",
		hands="Fanatic Gloves",
		feet="Regal Pumps +1",
		head="Hyksos Khat",
		legs="Ebers Pant. +1",
		waist="Witful Belt",
		ear2="Malignance Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	})

	sets.midcast.Erase = set_combine(sets.precast.FastRecast,    {
		main="Yagrush",
		neck="Cleric's Torque",
		hands="Fanatic Gloves",
		feet="Regal Pumps +1",
		waist="Witful Belt",
		ear1="Loquacious Earring",
		ring1="Weatherspoon Ring +1",
		ring2="Kishar Ring",
	})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = set_combine(sets.precast.FastRecast,    {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})--Dynasty Mitts

	--[[
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
	
		------------
		head="Befouled Crown",
		body="Manasa Chasuble",
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs="Piety Pantaln. +1",
		feet="Ebers Duckbills +1",
	]]

	-- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast.EnhancingMagic = set_combine(sets.precast.FastRecast,    {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})
		
	sets.midcast.Haste = set_combine(sets.precast.FastRecast,    {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})
	
	sets.midcast.Phalanx = set_combine(sets.precast.FastRecast,    {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})
	
	sets.midcast.Blink = set_combine(sets.precast.FastRecast,    {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})
	
	sets.midcast.Aquaveil = set_combine(sets.precast.FastRecast,    {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
		})
	
	sets.midcast.Flurry = set_combine(sets.precast.FastRecast,    {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})
	
    sets.midcast.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'],   {
		ammo="Impatiens",
		sub="Ammurapi Shield",
		head="Umuthi Hat",
		neck="Nodens Gorget",
		ear2="Andoaa Earring",
		ear2="Earthcry Earring",
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ring2="Stikini Ring +1",
		ring1="Stikini Ring +1",
		back="Mending Cape",
		waist="Siegel Sash",
		legs="Haven Hose",
		feet="Regal Pumps +1",
		})

    sets.midcast.Auspice = set_combine(sets.precast.FC['Enhancing Magic'],   {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet="Ebers Duckbills +1",
		back="Mending Cape",
		neck="Incanter's Torque",
		waist="Embla Sash",
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
	})

	sets.midcast.Storm = set_combine(sets.midcast.Haste, {hands="Dynasty Mitts"})
	------------------------DO NOT Remove Relic Legs / Empy Feet 
    sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'],    {	  main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		head="Befouled Crown",
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
		legs="Piety Pantaln. +1",
		feet="Ebers Duckbills +1"
	})--Dynasty Mitts

	--[[
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
	]]

    sets.midcast.Regen = set_combine(sets.precast.Cure,    {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands="Ebers Mitts",
		legs="Th. Pantaloons +2",
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		neck="Incanter's Torque",
		waist="Witful Belt",
	})
	
	sets.midcast.Refresh = set_combine(sets.precast.FC['Enhancing Magic'], {
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet="Inspirited Boots",
		waist="Gishdubar Sash",
	})

    sets.midcast.Protectra = set_combine(sets.precast.FC['Enhancing Magic'],   {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Sheltered Ring",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})
	sets.midcast.Protect = sets.midcast.Protectra
	
	sets.midcast.Shellra = set_combine(sets.precast.FC['Enhancing Magic'],   {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Impatiens",
		neck="Incanter's Torque",
		head={ name="Telchine Cap", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +10',}},
		ear2="Andoaa Earring",
		ear1="Loquacious Earring",
		ring1="Sheltered Ring",
		ring2="Stikini Ring +1",
		back="Mending Cape",
		waist="Embla Sash",
	})
	sets.midcast.Shell = sets.midcast.Shellra

    sets.midcast['Divine Magic'] = set_combine(sets.precast.FastRecast,   {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",
		neck="Incanter's Torque",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +3",
		hands="Fanatic Gloves",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Toro Cape",
		waist="Kobo Obi",
		legs="Th. Pantaloons +2",
		feet="Medium's Sabots",
	})

	sets.midcast.Repose = set_combine(sets.midcast['Divine Magic'], {
		neck="Erra Pendant",
	})

    sets.midcast['Dark Magic'] = set_combine(sets.precast.FastRecast,    {
		main="Rubicundity",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Toro Cape",
		waist="Refoccilation Stone",
		legs="Th. Pantaloons +2",
		feet="Gende. Galoshes",
	})

	sets.midcast.Drain = set_combine(sets.precast.FastRecast,    {
		main="Rubicundity",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Appetence Crown",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Toro Cape",
		waist="Fucho-No-Obi",
		legs="Th. Pantaloons +2",
		feet="Gende. Galoshes",
	})
		
	sets.midcast.Aspir = sets.midcast.Drain
		
		
    -- Custom spell classes
    sets.midcast.MndEnfeebles = set_combine(sets.precast.FastRecast,   {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','MND+10','"Fast Cast"+10',}},
		waist="Luminary Sash",
		legs="Th. Pantaloons +2",
		feet="Medium's Sabots",
	})

	sets.midcast.IntEnfeebles = set_combine(sets.precast.FastRecast,   {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +3",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Toro Cape",
		waist="Luminary Sash",
		legs="Th. Pantaloons +2",
		feet="Medium's Sabots",
	})
    
	sets.midcast.Dispellga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak"})
	
	sets.magic_burst = {
		sub="Ammurapi Shield",
		neck="Mizukage-no-Kubikazari",
		ring1="Locus Ring",
		ring2="Mujin Band",
	}
	
    -- Sets to return to when not performing an action.
    
	--Nourishing Earring +1 (Cure Spellcasting -4%)*
	
	--Hygieia Clogs +1 (Cure Spellcasting -18%)
	--Mendi. Earring (Cure Spellcasting -5%)
	--Pahtli Cape (Cure Spellcasting -8%)
	--Nefer Kalasiris (Cure Spellcasting -10%)
	--Aceso's Choker +1 (Cure Spellcasting -13%)
	--Sors Shield (Cure Spellcasting -5%)
	
	--Total (Cure Spellcasting -63%) (w/o Earring = -59%)

	--------------------------------------------------------------------------------

	--Nourishing Earring +1 (Cure Potency +6-7%) *
	
	--Kaykaus Bliaut	(Cure Potency+5% / Cure Potency II +3%)
	--Mendi. Earring (Cure Potency +5%)
	--Ebers Cap (Cure Potency +13%)
	--Nefer Kalasiris (Cure Potency +10%)
	--Tamaxchi (Cure Potency +22%)
	
	--Bokwus Gloves (Cure Potency +13%)
	--Sors Shield (Cure Potency +3%)
	
	--Total  (Cure Potency +72-73%)  (W/o Earring = +66%)
	
	-------------------------------------------------------------------------------
	
	--Glorious Earring (Cure Potency II +2%)
	--Kaykaus Bliaut	(Cure Potency+5% / Cure Potency II +3%)
	--Kaykaus Tights
	
    -- Resting sets
    sets.resting = {
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		body="Theo. Briault +3",
		hands="Serpentes Cuffs",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Fucho-No-Obi",
		legs="Nares Trews",
		feet="Serpentes Sabots",
	}--refresh head soon.
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear2="Malignance Earring",
		ear1="Glorious Earring",
		body="Theo. Briault +3",
		hands="Serpentes Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Assiduity Pants +1",
		feet="Serpentes Sabots",
	}

    sets.idle.PDT = {
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Umbra Cape",
		waist="Windbuffet Belt +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
	}

    sets.idle.Town = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear1="Glorious Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +3",
		hands="Serpentes Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Assiduity Pants +1",
		feet="Serpentes Sabots",
	}--Sors Shield
    
    sets.idle.Weak = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Sanctity Necklace",
		ear2="Malignance Earring",
		ear1="Glorious Earring",
		body="Theo. Briault +3",
		hands="Serpentes Cuffs",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back="Umbra Cape",
		waist="Fucho-No-Obi",
		legs="Assiduity Pants +1",
		feet="Serpentes Sabots",
	}
    
    -- Defense sets

    sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Umbra Cape",
		waist="Windbuffet Belt +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
	}

    sets.defense.MDT = {
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Odnowa Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Solemnity Cape",
		waist="Windbuffet Belt +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
	}--Solemnity Cape

	sets.Kiting = {feet="Herald's Gaiters"}
	sets.Adoulin = {feet="Herald's Gaiters"}
	sets.MoveSpeed = {feet="Herald's Gaiters"}
	--sets.buff['Sandstorm'] = {feet="Desert Boots"}
	
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		main="Yagrush",
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		ring1="Petrov Ring",
		ring2="Hetairoi Ring",
		back="Umbra Cape",
		waist="Windbuffet Belt +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
	}--Amar Cluster

	sets.engaged.Acc = set_combine(sets.precast.engaged,    {
		main="Yagrush",
		ammo="Amar Cluster",
		head="Alhazen Hat +1",
		neck="Subtlety Spec.",
		ear1="Telos Earring",
		ear2="Digni. Earring",
		body="Ayanmo Corazza +2",
		hands="Theophany Mitts +2",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back="Umbra Cape",
		waist="Windbuffet Belt +1",
		legs="Th. Pantaloons +2",
		feet="Aya. Gambieras +1",
	})--Amar Cluster/"Alaunus's Cape"

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {
		hands="Ebers Mitts",
		back="Mending Cape",
	}
	--sets.buff['Sandstorm'] = {feet="Desert Boots"}
	sets.buff.Doomed = {
		ring2="Saida Ring",
		waist="Gishdubar Sash",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end



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
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "White Magic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	
	if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
	
end


---------------------------------------------------------------------------------------------------------------------Auto Sublimation-----------------------------------
------------------------------------------------------------------------------------
--If MP is below 45% will auto-activate uppon using any spell 
--and 
--when it becomes "Complete" if MP is still Below 75% it will auto-activate uppon using any spell.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type ~= 'JobAbility' then
        auto_sublimation()
    end
end
 
function auto_sublimation()
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
        if not (buffactive['Invisible'] or buffactive['Weakness']) then
            if abil_recasts[234] == 0 then
                send_command('@wait 2;input /ja "Sublimation" <me>')
            end
        end
    elseif buffactive['Sublimation: Complete'] then
        if player.mpp < 45 and abil_recasts[234] == 0 then
            send_command('@wait 2;input /ja "Sublimation" <me>')
        end
    end         
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------




-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end
