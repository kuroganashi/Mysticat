-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    gs c step
        Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.

    gs c step t
        Uses the currently configured step on the target, but forces use of <t>.
    
    
    Configuration commands:
    
    gs c cycle mainstep
        Cycles through the available steps to use as the primary step when using one of the above commands.
        
    gs c cycle altstep
        Cycles through the available steps to use for alternating with the configured main step.
        
    gs c toggle usealtstep
        Toggles whether or not to use an alternate step.
        
    gs c toggle selectsteptarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
    state.SkillchainPending = M(false, 'Skillchain Pending')

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Recommend', 'Store_TP', 'TEST_TIG')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Fotia Necklace"
    gear.default.weaponskill_waist = "Fotia Belt"
    

    -- Additional local binds
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^- gs c toggle selectsteptarget')
    send_command('bind !- gs c toggle usealtstep')
    send_command('bind ^` input /ja "Chocobo Jig" <me>')
    send_command('bind !` input /ja "Chocobo Jig II" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^-')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +1"}

    sets.precast.JA['Trance'] = {head="Horos Tiara +1"}
    
	sets.precast.JA['Fan Dance'] = {hands="Horos Bangles +1"}

	sets.precast.JA['Saber Dance'] = {legs="Horos Tights +1"}
	
	sets.TP_Bonus        = {ear2="Cessance Earring"}
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
		head="Horos Tiara +1",neck="Unmoving Collar +1",ear2="Roundel Earring",ear1="Soil Pearl",ring1="Titan Ring",ring2="Titan Ring",
		body="Maxixi Casaque +1",hands="Slither Gloves +1",
		back="Toetapper Mantle",waist="Warwolf Belt",legs="Samnuha Tights",feet="Maxixi Toe Shoes +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {head="Maxixi Tiara +1",back="Senuna's Mantle"}

    sets.precast.Jig = {legs="Horos Tights +1",feet="Maxixi Toe Shoes +1"}

   sets.precast.Step = {ammo="Amar Cluster",
	head="Maxixi Tiara +1",hands="Maxixi Bangles +1",feet="Horos Shoes +1",ring1="Cacoethic Ring +1",ring2="Cacoethic Ring",waist="Windbuffet Belt +1",back="Senuna's Mantle"}
	
	sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step,  {hands="Maxixi Bangles +1",feet="Maculele Toeshoes"})

	--Flourish
	sets.precast.Flourish1 = {ammo="Amar Cluster",
	waist="Windbuffet Belt +1",back="Senuna's Mantle",ring1="Cacoethic Ring +1",ring2="Chirich Ring"}
	
	sets.precast.Flourish1['Violent Flourish'] =  set_combine(sets.precast.Flourish1,   {	 ammo="Pemphredo Tathlum",
		ear1="Digni. Earring",ear2="Gwati Earring",
		head="Meghanada Visor +2",body="Horos Casaque +1",hands="Meg. Gloves +2",ring2="Chirich Ring",ring1="Cacoethic Ring +1",
		back="Senuna's Mantle",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}) -- magic accuracy
	
	sets.precast.Flourish1['Desperate Flourish'] =  set_combine(sets.precast.Flourish1,  {ammo="Yamarang",
		head="Meghanada Visor +2",
		body="Samnuha Coat",hands="Meg. Gloves +2",ring1="Cacoethic Ring +1",ring2="Chirich Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}) -- acc gear (Senuna's Mantle)

	sets.precast.Flourish1['Animated Flourish'] = sets.enmity

	--Flourish2
	sets.precast.Flourish2 = {}
	
	sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles",back="Toetapper Mantle"}

	sets.precast.Flourish2['Wild Flourish'] = {hands="Maculele Bangles",legs="Maxixi Tights +1",back="Senuna's Mantle"}
	
	--Flourish3
	sets.precast.Flourish3 = {ammo="Amar Cluster",
	waist="Windbuffet Belt +1",back="Senuna's Mantle",ring1="Cacoethic Ring +1",ring2="Chirich Ring"}
	
	sets.precast.Flourish3['Striking Flourish'] =  set_combine(sets.precast.Flourish3,   {body="Maculele Casaque"})
	
	sets.precast.Flourish3['Climactic Flourish'] =  set_combine(sets.precast.Flourish3,   {head="Maculele Tiara"})

	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
	head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",hands="Leyline Gloves",feet="Meg. Jam. +1",
	legs="Rawhide Trousers",
	ring1="Weatherspoon Ring",ring2="Prolix Ring",body="Dread Jupon"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {back="Mujin Mantle",neck="Magoraga Beads"})

    sets.enmity = {ear1="Friomisi Earring",ear2="Cryptic Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring",feet="Rager Ledel. +1",head="Halitus Helm"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Yamarang",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Samnuha Tights",
		feet="Meg. Jam. +1",
		back="Senuna's Mantle",
		ear1="Sherida Earring",ear2="Moonshade Earring",
		ring1="Shukuyu Ring",ring2="Epona's Ring",
		neck="Fotia Gorget",waist="Fotia Belt",
		}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Amar Cluster", back="Senuna's Mantle"})

	gear.default.weaponskill_neck = "Fotia Necklace"
	gear.default.weaponskill_waist = "Fotia Belt"

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
	ring1="Shukuyu Ring",ring2="Epona's Ring",
	back="Senuna's Mantle"
	})--8,190 
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Amar Cluster", back="Senuna's Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {body="Rawhide Vest",waist="Fotia Belt"})

	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
	ammo="Yamarang",
	head="Meghanada Visor +2",
	body={ name="Herculean Vest", augments={'Accuracy+18','"Triple Atk."+2','STR+10','Attack+6',}},
	hands="Meg. Gloves +2",
	legs="Samnuha Tights",
	feet="Lustratio Leggings",
	back="Senuna's Mantle",
	ring1="Hetairoi Ring",ring2="Epona's Ring",
	ear1="Sherida Earring",ear2="Moonshade Earring",
	neck="Fotia Gorget",waist="Fotia Belt",
	})
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {back="Senuna's Mantle",head="Meghanada Visor +2",hands="Meg. Gloves +2"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {back="Senuna's Mantle",head="Meghanada Visor +2",hands="Meg. Gloves +2"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Amar Cluster",back="Senuna's Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {body="Maxixi Casaque +1",waist="Fotia Belt"})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
	ammo="Charis Feather",
	head="Adhemar Bonnet",
	body="Meg. Cuirie +2",
	hands="Meg. Gloves +2",
	legs="Lustratio Subligar",
	feet="Lustratio Leggings",
	ear1="Ishvara Earring",ear2="Moonshade Earring",
	ring2="Ramuh Ring",ring1="Begrudging Ring",
	back="Senuna's Mantle",
	neck="Caro Necklace",waist="Grunfeld Rope",
	})--Lustra Feet A(19,741) / Lustra Feet B(20,007) / Lustra Feet D(20,197)

	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Yamarang",back="Senuna's Mantle"})

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

	sets.precast.Skillchain = {hands="Maculele Bangles",legs="Maxixi Tights +1",back="Senuna's Mantle"}


    -- Midcast Sets
   sets.midcast.FastRecast = {ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Mujin Mantle",
		legs="Rawhide Trousers",
		feet="Meg. Jam. +1"}

	-- Specific spells
	sets.midcast.Utsusemi = {ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},neck="Magoraga Beads",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Mujin Mantle",
		legs="Rawhide Trousers",
		feet="Meg. Jam. +1"}


	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {head="Meghanada Visor +2",body="Meg. Cuirie +2",hands="Turms Mittens",legs="Turms Subligar",feet="Turms Leggings",neck="Sanctity Necklace",ring1="Chirich Ring",ring2="Chirich Ring"}
	sets.ExtraRegen = {head="Meghanada Visor +2",body="Meg. Cuirie +2",hands="Turms Mittens",legs="Turms Subligar",feet="Turms Leggings",neck="Sanctity Necklace",ring1="Chirich Ring",ring2="Chirich Ring"}


	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	--Turms Mittens  (hands)
	--Turms Subligar (legs)
	--Turms Leggings (feet)
	
	sets.idle.Town = {main="Aeneas",sub="Polyhymnia",ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Meg. Cuirie +2",hands="Turms Mittens",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Turms Subligar",feet="Skd. Jambeaux +1"}--Atoyac/Uk'uxkaj Cap

	sets.idle.Field = {ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Meg. Cuirie +2",hands="Turms Mittens",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Turms Subligar",feet="Skd. Jambeaux +1"}

	sets.idle.Weak = {ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Sanctity Necklace",ear1="Sherida Earring",ear2="Suppanomimi",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Skd. Jambeaux +1"}

	-- Defense sets

	sets.defense.Evasion = {
		head="Meghanada Visor +2",neck="Torero Torque",
		body="Meg. Cuirie +2",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Toetapper Mantle",waist="Flume Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}

	sets.defense.PDT = {
		ammo="Staunch Tathlum",
		head="Meghanada Visor +2",neck="Twilight Torque",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}

	sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Skormoth Mask",neck="Twilight Torque",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Defending Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Ta'lab Trousers",feet="Meg. Jam. +1"}

	sets.Kiting = {feet="Skd. Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		ammo="Yamarang",
		head="Skormoth Mask",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Suppanomimi",
		ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Windbuffet Belt +1",
		}--3679.937
		
	sets.engaged.Acc = {
		ammo="Amar Cluster",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +1",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",ear2="Heartseeker Earring",
		ring1="Cacoethic Ring +1",ring2="Cacoethic Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}
		
	sets.engaged.Recommend = {
		ammo="Yamarang",
		head="Adhemar Bonnet",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Cessance Earring",
		ring1="Chirich Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Windbuffet Belt +1",
		}
	
	sets.engaged.Store_TP = {
		ammo="Yamarang",
		head="Maculele Tiara",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet="Horos Toe Shoes",
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Cessance Earring",
		ring1="Chirich Ring",ring2="Chirich Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}--Mummu Jacket +1 
	
	sets.engaged.TEST_TIG = {
		ammo="Yamarang",
		head="Skormoth Mask",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Suppanomimi",
		ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}
	
	sets.engaged.Evasion = {ammo="Yamarang",
		head="Meghanada Visor +2",neck="Ej Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.Evasion = {ammo="Amar Cluster",
		head="Dampening Tam",neck="Ej Necklace",ear1="Digni. Earring",ear2="Zennaroi Earring",
		body="Emet Harness +1",hands="Leyline Gloves",ring1="Cacoethic Ring +1",ring2="Chirich Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Meg. Jam. +1"}
	sets.engaged.PDT = {ammo="Yamarang",
		head="Meghanada Visor +2",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Samnuha Tights",feet="Meg. Jam. +1"}
	sets.engaged.Acc.PDT = {ammo="Amar Cluster",
		head="Dampening Tam",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Dark Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Meg. Jam. +1"}

	-- Custom melee group: High Haste
	sets.engaged.HighHaste = {
		ammo="Yamarang",
		head="Skormoth Mask",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Suppanomimi",
		ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Windbuffet Belt +1",
		}
		
	sets.engaged.Acc.HighHaste = {
		ammo="Amar Cluster",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +1",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",ear2="Heartseeker Earring",
		ring1="Cacoethic Ring +1",ring2="Cacoethic Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}
		
	sets.engaged.Recommend.HighHaste = {
		ammo="Yamarang",
		head="Adhemar Bonnet",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Cessance Earring",
		ring1="Chirich Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Windbuffet Belt +1",
		}
	
	sets.engaged.Store_TP.HighHaste = {
		ammo="Yamarang",
		head="Maculele Tiara",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet="Horos Toe Shoes",
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Cessance Earring",
		ring1="Chirich Ring",ring2="Chirich Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}--Mummu Jacket +1 
	
	sets.engaged.TEST_TIG.HighHaste = {
		ammo="Yamarang",
		head="Skormoth Mask",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Suppanomimi",
		ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}
		
	sets.engaged.Evasion.HighHaste = {ammo="Yamarang",
		head="Meghanada Visor +2",neck="Torero Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Cacoethic Ring +1",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.Evasion.HighHaste = {ammo="Yamarang",
		head="Dampening Tam",neck="Torero Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Cacoethic Ring +1",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Meg. Jam. +1"}
	sets.engaged.PDT.HighHaste = {ammo="Yamarang",
		head="Meghanada Visor +2",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}
	sets.engaged.Acc.PDT.HighHaste = {ammo="Amar Cluster",
		head="Dampening Tam",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Hurch'lan Sash",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}

	-- Custom melee group: Max Haste
	sets.engaged.MaxHaste = {
		ammo="Yamarang",
		head="Skormoth Mask",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Suppanomimi",
		ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Windbuffet Belt +1",
		}
	sets.engaged.Acc.MaxHaste = {
		ammo="Amar Cluster",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +1",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",ear2="Heartseeker Earring",
		ring1="Cacoethic Ring +1",ring2="Chirich Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}
		
	sets.engaged.Recommend.MaxHaste = {
		ammo="Yamarang",
		head="Adhemar Bonnet",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Cessance Earring",
		ring1="Chirich Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Windbuffet Belt +1",
		}
	
	sets.engaged.Store_TP.MaxHaste = {
		ammo="Yamarang",
		head="Maculele Tiara",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet="Horos Toe Shoes",
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Cessance Earring",
		ring1="Chirich Ring",ring2="Chirich Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}--Mummu Jacket +1 
	
	sets.engaged.TEST_TIG.MaxHaste = {
		ammo="Yamarang",
		head="Skormoth Mask",
		body="Adhemar Jacket",
		hands="Adhemar Wristbands",
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		neck="Anu Torque",
		ear1="Sherida Earring",ear2="Suppanomimi",
		ring1="Hetairoi Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",
		waist="Reiki Yotai",
		}
	
	sets.engaged.Evasion.MaxHaste = {ammo="Yamarang",
		head="Meghanada Visor +2",neck="Torero Torque",ear2="Cessance Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Cacoethic Ring +1",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.Evasion.MaxHaste = {ammo="Amar Cluster",
		head="Dampening Tam",neck="Torero Torque",ear2="Cessance Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Cacoethic Ring +1",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Meg. Jam. +1"}
	sets.engaged.PDT.MaxHaste = {ammo="Yamarang",
		head="Meghanada Visor +2",neck="Twilight Torque",ear2="Cessance Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}
	sets.engaged.Acc.PDT.MaxHaste = {ammo="Amar Cluster",
		head="Dampening Tam",neck="Twilight Torque",ear2="Cessance Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Meg. Gloves +2",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Hurch'lan Sash",legs="Meg. Chausses +2",feet="Meg. Jam. +1"}



	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Saber Dance'] = {legs="Horos Tights +1"}
	sets.buff['Fan Dance'] = {hands="Horos Bangles +1",legs="Maculele Tights"}
	sets.buff['Climactic Flourish'] = {head="Maculele Tiara"}
	sets.buff['Wild Flourish'] = {hands="Maculele Bangles",legs="Maxixi Tights +1",back="Senuna's Mantle"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --auto_presto(spell)
end


function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
        if state.SkillchainPending.value == true then
            equip(sets.precast.Skillchain)
        end
    end
	if player.tp > 2250 then
            equip(sets.TP_Bonus)	
		end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Wild Flourish" then
            state.SkillchainPending:set()
            send_command('wait 5;gs c unset SkillchainPending')
        elseif spell.type:lower() == "weaponskill" then
            state.SkillchainPending:toggle()
            send_command('wait 6;gs c unset SkillchainPending')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
        handle_equipping_gear(player.status)
    end
end


function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        determine_haste_group()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end


function customize_idle_set(idleSet)
    if player.hpp < 80 and not areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value ~= 'None' then
        if buffactive['saber dance'] then
            meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
        end
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
    end
    
    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
        
        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', ['..state.MainStep.current

    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end
    
    msg = msg .. ']'

    if state.SelectStepTarget.value == true then
        steps = steps..' (Targetted)'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end        
        
        send_command('@input /ja "'..doStep..'" <t>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Charis body, Charis neck + DW earrings, and Patentia Sash.

    -- For high haste, we want to be able to drop one of the 10% groups (body, preferably).
    -- High haste buffs:
    -- 2x Marches + Haste
    -- 2x Marches + Haste Samba
    -- 1x March + Haste + Haste Samba
    -- Embrava + any other haste buff
    
    -- For max haste, we probably need to consider dropping all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste/March + Haste Samba
    -- 2x March + Haste + Haste Samba

    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function auto_presto(spell)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('@input /ja "Presto" <me>')
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 6)
    else
        set_macro_page(1, 6)
    end
end
