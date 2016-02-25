-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
        state.Buff.Migawari = buffactive.migawari or false
        state.Buff.Doomed = buffactive.doomed or false
        state.Buff.Yonin = buffactive.yonin or false
        state.Buff.Innin = buffactive.innin or false
        state.Buff.Futae = buffactive.futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Special')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachiya Kyahan"
    
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}
	sets.precast.JA['Migawari'] = {body="Hattori Ningi"}
	sets.precast.JA['Yonin'] = {legs="Hattori Hakama"}
	sets.precast.JA['Innin'] = {head="Hattori Zukin"}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Khepri Bonnet",neck="Tjukurrpa Medal",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Samnuha Coat",hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Thur. Boots +1"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Whirlpool Mask",neck="Subtlety Spectacles",ear2="Choreia Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Rajas Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",legs="Hachi. Hakama +1",feet="Taeon Boots"}

	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",head="Anwig Salade",body="Mirke Wardecors",back="Mujin Mantle",ear2="Loquacious Earring",ear1="Mendi. Earring",
	hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",legs="Hachi. Hakama +1",neck="Jeweled Collar"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Mochi. Chainmail +1",back="Mujin Mantle",neck="Magoraga Beads",ear1="Mendi. Earring",
	feet="Iga Kyahan +2",hands="Mochizuki Tekko"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Yetshila",
		head="Uk'uxkaj Cap",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Pursuer's Doublet",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Otronif Boots +1"} --body="Otro. Harness +1",Letalis Mantle

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",hands="Rawhide Gloves",waist="Fotia Belt",
	back="Vespid Mantle",ring2="Ramuh Ring",legs="Samnuha Tights"})--Rancorous Mantle , Fotia Gorget

	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",hands="Seiryu's Kote",waist="Fotia Belt",
	legs="Hachi. Hakama +1",feet="Taeon Boots",ring1="Garuda Ring",ring2="Garuda Ring",back="Yokaze Mantle"})
	sets.precast.WS['Blade: Hi'].Mod = set_combine(sets.precast.WS['Blade: Hi'], {waist="Fotia Belt"})--Rancorous Mantle,Hope Torque

	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt",ring2="Ramuh Ring",
	back="Vespid Mantle",legs="Samnuha Tights",feet="Mochizuki Kyahan",ammo="Jukukik Feather",hands="Rawhide Gloves"})

	sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",back="Yokaze Mantle",waist="Fotia Belt",
	legs="Nahtirah Trousers",hands="Slither Gloves +1"})
	sets.precast.WS['Blade: Kamu'].Mod = set_combine(sets.precast.WS['Blade: Kamu'], {waist="Fotia Belt"})

	sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt",legs="Samnuha Tights",
	hands="Rawhide Gloves",back="Vespid Mantle"})
	sets.precast.WS['Blade: Ku'].Mod = set_combine(sets.precast.WS['Blade: Ku'], {waist="Fotia Belt"})

	sets.precast.WS['Blade: Metsu'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt",legs="Hachi. Hakama +1",
	body="Mochi. Chainmail +1",hands="Slither Gloves +1",ring2="Ramuh Ring",back="Letalis Mantle",feet="Mochizuki Kyahan"})
	sets.precast.WS['Blade: Metsu'].Mod = set_combine(sets.precast.WS['Blade: Metsu'], {waist="Fotia Belt"})
	
	sets.precast.WS['Aeolian Edge'] = {
		head="Thaumas Hat",neck="Stoicheion Medal",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Pursuer's Doublet",hands="Slither Gloves +1",ring1="Rajas Ring",ring2="Demon's Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Otronif Boots +1"}

	sets.precast.WS['Sunburst'] = {
		head="Whirlpool Mask",neck="Fotia Gorget",ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Samnuha Coat",hands="Slither Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Toro Cape",waist="Fotia Belt",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}
		

	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Impatiens",head="Anwig Salade",body="Mirke Wardecors",back="Mujin Mantle",ear2="Loquacious Earring",ear1="Mendi. Earring",
	hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",legs="Hachi. Hakama +1",neck="Jeweled Collar"}

	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = set_combine(sets.midcast.FastRecast, {neck="Jeweled Collar"})

	sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {body="Mochi. Chainmail +1",back="Mujin Mantle",neck="Magoraga Beads",ear1="Mendi. Earring",
	feet="Iga Kyahan +2",hands="Mochizuki Tekko"})

	-- any ninjutsu cast on enemies
	sets.midcast.Ninjutsu = {ammo="Dosis Tathlum",
		head="Anwig Salade",neck="Stoicheion Medal",
		ear2="Friomisi Earring",ear1="Hecate's Earring",
		body="Samnuha Coat",hands="Mochizuki Tekko",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Toro Cape",waist="Cetl Belt",legs="Hachi. Hakama +1",feet="Hachiya Kyahan"}

	sets.midcast.Ninjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {head="Whirlpool Mask",ear1="Lifestorm Earring",ear2="Psystorm Earring",ring2="Fenrir Ring",feet="Hachiya Kyahan",back="Yokaze Mantle"})

	sets.midcast.NinjutsuDebuff = set_combine(sets.midcast.Ninjutsu, {head="Whirlpool Mask",ear1="Lifestorm Earring",ear2="Psystorm Earring",ring2="Fenrir Ring",feet="Hachiya Kyahan",back="Yokaze Mantle"})

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {head="Uk'uxkaj Cap",neck="Asperity Necklace",
		ring1="Matrimony Band",ring2="Epona's Ring"}


	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {ammo="Happo Shuriken",
		head="Uk'uxkaj Cap",neck="Lissome Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Mochizuki Tekko",ring1="Matrimony Band",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Hachi. Hakama +1",feet=gear.MovementFeet}

	sets.idle.Town = {main="Raimitsukane",sub="Izuna",ammo="Happo Shuriken",
		head="Uk'uxkaj Cap",neck="Lissome Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Mochizuki Tekko",ring1="Matrimony Band",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Hachi. Hakama +1",feet=gear.MovementFeet}

	sets.idle.Weak = {ammo="Happo Shuriken",
		head="Uk'uxkaj Cap",neck="Lissome Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Mochizuki Tekko",ring1="Matrimony Band",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Hachi. Hakama +1",feet=gear.MovementFeet}

	-- Defense sets
	sets.defense.Evasion = {
		head="Whirlpool Mask",neck="Torero Torque",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Defending Ring",
		back="Ik Cape",waist="Nusku's Sash",legs="Ta'lab Trousers",feet="Otronif Boots +1"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Otronif Mask +1",neck="Twilight Torque",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Nusku's Sash",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Shadow Ring",
		back="Mollusca Mantle",waist="Nusku's Sash",legs="Ta'lab Trousers",feet="Otronif Boots +1"}


	sets.DayMovement = {feet="Danzo sune-ate"}

	sets.NightMovement = {feet="Hachiya Kyahan"}

	sets.Kiting = select_movement_feet()


	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
sets.engaged = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Taeon Boots"}
	sets.engaged.Acc = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Samnuha Coat",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",legs="Hachi. Hakama +1",feet="Taeon Boots"}
	sets.engaged.Special = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Nusku's Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}
	sets.engaged.Evasion = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.Evasion = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.PDT = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}

	-- Custom melee group: High Haste (~20% DW)
	sets.engaged.HighHaste = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Taeon Boots"}
	sets.engaged.Acc.HighHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Samnuha Coat",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",legs="Hachi. Hakama +1",feet="Taeon Boots"}
	sets.engaged.Special.HighHaste = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Nusku's Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}
	sets.engaged.Evasion.HighHaste = {ammo="Qirmiz Tathlum",
		head="Dampening Tam",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.PDT.HighHaste = {ammo="Qirmiz Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Patentia Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT.HighHaste = {ammo="Qirmiz Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}

	-- Custom melee group: Embrava Haste (7% DW)
	sets.engaged.EmbravaHaste = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Taeon Boots"}
	sets.engaged.Acc.EmbravaHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Samnuha Coat",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",legs="Hachi. Hakama +1",feet="Taeon Boots"}
	sets.engaged.Special.EmbravaHaste = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Nusku's Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}
	sets.engaged.Evasion.EmbravaHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.Evasion.EmbravaHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Torero Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.PDT.EmbravaHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Samnuha Tights",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT.EmbravaHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Otronif Boots +1"}

	-- Custom melee group: Max Haste (0% DW)
	sets.engaged.MaxHaste = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Taeon Boots"}
	sets.engaged.Acc.MaxHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
		body="Samnuha Coat",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Mars's Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",legs="Hachi. Hakama +1",feet="Taeon Boots"}
	sets.engaged.Special.MaxHaste = {ammo="Happo Shuriken",
		head="Hattori Zukin",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Mochi. Chainmail +1",hands="Otronif Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Nusku's Sash",legs={ name="Taeon Tights", augments={'Accuracy+11','"Triple Atk."+2','Weapon skill damage +3%',}},feet="Taeon Boots"}
	sets.engaged.Evasion.MaxHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.Evasion.MaxHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Samnuha Coat",hands="Otronif Gloves +1",ring1="Beeline Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachi. Hakama +1",feet="Otronif Boots +1"}
	sets.engaged.PDT.MaxHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Windbuffet Belt",legs="Samnuha Tights",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT.MaxHaste = {ammo="Happo Shuriken",
		head="Dampening Tam",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Otronif Boots +1"}


	sets.buff.Migawari = {body="Hattori Ningi"}
	sets.buff.Yonin = {legs="Hattori Hakama"}
	sets.buff.Innin = {head="Hattori Zukin"}
	sets.buff.Doomed = {ring2="Saida Ring"}
	sets.buff.Futae = {hands="Hattori Tekko"}
	sets.buff.Sange = {ammo="Hachiya Shuriken"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
	        if state.Buff.Futae then
                idleSet = set_combine(idleSet, sets.buff.Futae)
        end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
	        if state.Buff.Yonin then
                meleeSet = set_combine(meleeSet, sets.buff.Yonin)
        end
        if state.Buff.Innin then
                meleeSet = set_combine(meleeSet, sets.buff.Innin)
        end
        if state.Buff.Futae then
                meleeSet = set_combine(meleeSet, sets.buff.Futae)
        end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        -- Default macro set/book
        if player.sub_job == 'DNC' then
                set_macro_page(1, 6)
        elseif player.sub_job == 'THF' then
                set_macro_page(2, 6)
        elseif player.sub_job == 'RUN' then
                set_macro_page(9, 6)   
        else
                set_macro_page(10, 6)
        end
end