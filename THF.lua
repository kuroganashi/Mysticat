-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Doomed = buffactive.doomed or false
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'TH', 'Acc', 'Mod')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.MagicalDefenseMode:options('TH', 'MDT')

    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    
    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    --sets.TreasureHunter = {hands="Plun. Armlets +1",feet="Skulk. Poulaines +1",waist="Chaac Belt"}
    sets.ExtraRegen = {head="Meghanada Visor +2",body="Meg. Cuirie +2",hands="Meg. Gloves +2",legs="Meg. Chausses +2",neck="Sanctity Necklace",ring2="Defending Ring"}
    sets.Kiting = {feet="Jute Boots +1"}

    sets.buff['Sneak Attack'] = {ammo="Amar Cluster",
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Meg. Cuirie +2",hands="Plun. Armlets +1",ring1="Petrov Ring",ring2="Ramuh Ring",
		back="Toutatis's Cape",waist="Chaac Belt",legs="Samnuha Tights",feet="Skulk. Poulaines +1"}--Pursuer's Doublet 

    sets.buff['Trick Attack'] = {ammo="Amar Cluster",
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Meg. Cuirie +2",hands="Plun. Armlets +1",ring1="Garuda Ring",ring2="Garuda Ring",
		back="Toutatis's Cape",waist="Chaac Belt",legs="Samnuha Tights",feet="Skulk. Poulaines +1"}--Pursuer's Doublet 

	sets.buff['Flee'] = {feet="Pill. Poulaines +1"}
		
    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}--Skulker's Bonnet
	sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}--Skulker's Bonnet
	sets.precast.JA['Flee'] = {feet="Pill. Poulaines +1"}
	sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
	sets.precast.JA['Conspirator'] = {body="Raider's Vest +2"}
	sets.precast.JA['Steal'] = {head="Assassin's Bonnet +2",hands="Thief's Kote",legs="Assassin's Culottes",feet="Pillager's Poulaines",neck="Rabbit Charm",waist="Key Ring Belt"}
	sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Skulk. Poulaines +1"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +1"}
	sets.precast.JA['Feint'] = {legs="Assassin's Culottes +2"}


	sets.precast.JA['Sneak Attack'] = {ammo="Amar Cluster",
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Meg. Cuirie +2",hands="Plun. Armlets +1",ring1="Petrov Ring",ring2="Ramuh Ring",
		back="Toutatis's Cape",waist="Chaac Belt",legs="Samnuha Tights",feet="Skulk. Poulaines +1"}--Skulker's Bonnet,Pursuer's Doublet 

	sets.precast.JA['Trick Attack'] = {ammo="Amar Cluster",
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Meg. Cuirie +2",hands="Plun. Armlets +1",ring1="Garuda Ring",ring2="Garuda Ring",
		back="Toutatis's Cape",waist="Chaac Belt",legs="Samnuha Tights",feet="Skulk. Poulaines +1"}--Skulker's Bonnet,Pursuer's Doublet 
	
	sets.precast.JA['Provoke'] = sets.enmity

	sets.TP_Bonus        = {ear2="Cessance Earring"}
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
		head="Mummu Bonnet +1",neck="Unmoving Collar +1",ear1="Soil Pearl",ear2="Soil Pearl",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"} --head="Lilitu Headpiece",Pursuer's Doublet 

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	
	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
	head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
	legs="Rawhide Trousers",body="Dread Jupon"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",back="Mujin Mantle"})


    -- Ranged snapshot gear
	sets.precast.RangedAttack = {head="Meghanada Visor +2",ear2="Clearview Earring",ear1="Volley Earring",neck="Erudit. Necklace",back="Libeccio Mantle",body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Hajduk Ring",ring2="Hajduk Ring",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}--Dampening Tam

	--Enmity
	sets.enmity = {ear1="Friomisi Earring",ear2="Cryptic Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring",feet="Rager Ledel. +1",head="Halitus Helm"}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Yetshila",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Samnuha Tights",
		feet="Meg. Jam. +1",
		ear1="Sherida Earring",ear2="Moonshade Earring",
		back="Toutatis's Cape",
		ring1="Shukuyu Ring",ring2="Epona's Ring",
		neck="Fotia Gorget",waist="Fotia Belt",
		}--Pursuer's Doublet Dampening Tam
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Amar Cluster",head="Dampening Tam",back="Letalis Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	ammo="Yamarang",
	head="Meghanada Visor +2",
	body="Meg. Cuirie +2",
	hands="Meg. Gloves +2",
	legs="Meg. Chausses +2",
	feet="Meg. Jam. +1",
	neck="Fotia Gorget",waist="Fotia Belt",
	ear1="Sherida Earring",ear2="Moonshade Earring",
	ring1="Shukuyu Ring",ring2="Garuda Ring",
	back="Vespid Mantle"
	})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {body="Meg. Cuirie +2",back="Letalis Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",head="Meghanada Visor +2",back="Vespid Mantle"})
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {back="Letalis Mantle"})
	sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {back="Vespid Mantle",head="Meghanada Visor +2",hands="Meg. Gloves +2"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {back="Letalis Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
	ammo="Falcon Eye",
	head="Adhemar Bonnet",
	body="Meg. Cuirie +2",
	hands="Meg. Gloves +2",
	legs="Lustratio Subligar",
	feet="Lustratio Leggings",
	ear1="Ishvara Earring",ear2="Moonshade Earring",
	ring2="Ramuh Ring",ring1="Begrudging Ring",
	back="Toutatis's Cape",
	neck="Caro Necklace",waist="Grunfeld Rope",
	})--Uk'uxkaj Cap Ishvara Earring Lustratio Subligar Yetshila
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {back="Letalis Mantle"})
	sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {waist="Fotia Belt"})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
	sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {back="Letalis Mantle"})
	sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {waist="Fotia Belt"})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Fotia Gorget"})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Fotia Gorget"})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Fotia Gorget"})

	sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Meghanada Visor +2",neck="Fotia Gorget",})
	sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {back="Letalis Mantle"})
	sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})
	sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {waist="Fotia Belt",neck="Fotia Gorget"})

	sets.precast.WS['Aeolian Edge'] = {
		ammo="Pemphredo Tathlum",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		body="Samnuha Coat",
		hands="Leyline Gloves",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		ring1="Petrov Ring",ring2="Fenrir Ring",
		back="Toro Cape",
		ear1="Friomisi Earring",ear2="Moonshade Earring",
		neck="Sanctity Necklace",waist="Eschan Stone",
		}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},ear1="Mendi. Earring",ear2="Loquacious Earring",neck="Voltsurge Torque",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Mujin Mantle",waist="Cetl Belt",legs="Rawhide Trousers",feet="Rawhide Boots"}

    -- Specific spells
    sets.midcast.Utsusemi = {ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},neck="Magoraga Beads",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Mujin Mantle",waist="Cetl Belt",legs="Rawhide Trousers",feet="Rawhide Boots"}

    -- Ranged gear
	sets.midcast.RangedAttack = {
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear2="Clearview Earring",ear1="Volley Earring",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Aquiline Belt",legs="Meg. Chausses +2",feet="Rawhide Boots"}

	sets.midcast.RangedAttack.TH = {
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear1="Clearview Earring",ear2="Volley Earring",
		body="Meg. Cuirie +2",hands="Plun. Armlets +1",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Aquiline Belt",legs="Meg. Chausses +2",feet="Skulk. Poulaines +1"}

	sets.midcast.RangedAttack.Acc = {
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear1="Clearview Earring",ear2="Volley Earring",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Hajduk Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Aquiline Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}


    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
 --Legs{ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}}
    -- Resting sets
	sets.resting = {head="Meghanada Visor +2",body="Meg. Cuirie +2",hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",neck="Sanctity Necklace",
		ring1="Chirich Band",ring2="Chirich Ring"}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Jute Boots +1"}--Raider's Boomerang Uk'uxkaj Cap

	sets.idle.ACC = {ammo="Amar Cluster",
		head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Jute Boots +1"}
	
	sets.idle.Town = {main="Aeneas",sub="Sandung",ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Jute Boots +1"}

	sets.idle.Weak = {ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Jute Boots +1"}

	sets.ExtraRegen = {head="Meghanada Visor +2",body="Meg. Cuirie +2",hands="Meg. Gloves +2",legs="Meg. Chausses +2",neck="Sanctity Necklace",ring1="Chirich Ring",ring2="Chirich Ring"}

    -- Defense sets

	sets.defense.Evasion = {ammo="Amar Cluster",
		head="Alhazen Hat +1",neck="Erudit. Necklace",
		body="Emet Harness +1",hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},ring1="Petrov Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Nusku's Sash",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}}}--Meghanada Visor +1

	sets.defense.PDT = {ammo="Staunch Tathlum",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},neck="Twilight Torque",
		body="Emet Harness +1",hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}}}

	sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Skormoth Mask",neck="Twilight Torque",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Pillager's Armlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Ta'lab Trousers",feet="Rawhide Boots"}

	sets.defense.TH = {ammo="Yamarang",
		head="White Rarab Cap +1",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Adhemar Jacket",hands="Plun. Armlets +1",ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Chaac Belt",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet="Skulk. Poulaines +1"}
		
	sets.Kiting = {feet="Jute Boots +1"} --Skadi's Jambeaux +1


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {ammo="Yamarang",
		head="Skormoth Mask",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Adhemar Jacket",hands="Plun. Armlets +1",ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Windbuffet Belt +1",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet="Skulk. Poulaines +1"}--Skulker's Bonnet
	sets.engaged.TH = {ammo="Yamarang",
		head="White Rarab Cap +1",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Adhemar Jacket",hands="Plun. Armlets +1",ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Chaac Belt",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet="Skulk. Poulaines +1"}
    sets.engaged.Acc = {ammo="Amar Cluster",
		head="Meghanada Visor +2",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Meg. Cuirie +2",hands="Floral Gauntlets",ring1="Cacoethic Ring +1",ring2="Chirich Ring",
		back="Canny Cape",waist="Hurch'lan Sash",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}
        
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.DD = {ammo="Yamarang",
		head="Skormoth Mask",neck="Erudit. Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Adhemar Jacket",hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Windbuffet Belt +1",legs="Meg. Chausses +2",feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}}}--Skulker's Bonnet

    -- Mod set for trivial mobs (Thaumas)--Skulker's Bonnet
    sets.engaged.Mod2 = {ammo="Amar Cluster",
		head="Skormoth Mask",neck="Asperity Necklace",ear1="Sherida Earring",ear2="Cessance Earring",
		body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Cetl Belt",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}}}

    sets.engaged.Evasion = {ammo="Amar Cluster",
		head="Dampening Tam",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},ring1="Petrov Ring",ring2="Epona's Ring",
		back="Canny Cape",waist="Nusku's Sash",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet="Skulk. Poulaines +1"}
    sets.engaged.Acc.Evasion = {ammo="Amar Cluster",
		head="Meghanada Visor +2",neck="Erudit. Necklace",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},ring1="Cacoethic Ring +1",ring2="Chirich Ring",
		back="Letalis Mantle",waist="Hurch'lan Sash",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet="Skulk. Poulaines +1"}

    sets.engaged.PDT = {
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},ring1="Dark Ring",ring2="Defending Ring",
		back="Iximulew Cape",waist="Windbuffet Belt +1",legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}}}
    sets.engaged.Acc.PDT = {
		head="Dampening Tam",neck="Twilight Torque",ear1="Digni. Earring",ear2="Heartseeker Earring",
		body="Samnuha Coat",hands="Floral Gauntlets",ring1="Dark Ring",ring2="Defending Ring",
		back="Canny Cape",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Rawhide Boots"}

		
	sets.buff.Doomed = {ring2="Saida Ring",waist="Gishdubar Sash"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
	
	if player.tp > 2250 then
            equip(sets.TP_Bonus)	
		end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 7)
    elseif player.sub_job == 'WAR' then
        set_macro_page(3, 7)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 7)
    else
        set_macro_page(2, 7)
    end
end