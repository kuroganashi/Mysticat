----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
	include('organizer-lib')
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master")--, "Trusts"

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Acc", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(true, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Mecisto. Mantle" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind !` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind Delete gs c hide keybinds")
    send_command("bind end gs c toggle CP") 
	send_command("bind != gs c hub all")
	
    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 600
    pos_y = 80
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind !`")
    send_command("unbind home")
    send_command("unbind PAGEUP") 
    send_command("unbind Delete")           
    send_command("unbind end")
	send_command("unbind =")
end

function job_setup()
    include("PUP-LIB.lua")
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II"
    Animators.Melee = "Animator P +1"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +1"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +1"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +1" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +1" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +1" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +1" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +1" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe"

    Visucius = {}
    
	Visucius.PetHaste = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
            "Accuracy+20 Attack+20",
            "Pet: Accuracy+10 Pet: Rng. Acc.+10",
            'Pet: "Haste"+10',
            "Pet: Damage taken -5%"
        }
    }
	
	
	Visucius.PetDT = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
            "Accuracy+20 Attack+20",
            "Pet: Accuracy+10 Pet: Rng. Acc.+10",
            'Pet: "Regen"+10',
            "Pet: Damage taken -5%"
        }
    }
    
	Visucius.PetMagic = {
        name = "Visucius's Mantle",
        augments = {
            "Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20",
            "Accuracy+20 Attack+20",
            "Pet: Accuracy+10 Pet: Rng. Acc.+10",
            'Pet: "Regen"+10',
            "Pet: Damage taken -5%"
        }
    }

    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Pitre Taj +1",
		neck="Empath Necklace",
		ear2="Enmerkar Earring",
		ear1="Burana Earring",
		body="Hiza. Haramaki +1",
		hands="Rao Kote",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Rao Haidate",
		feet="Hermes' Sandals"
		}

    -------------------------------------Fastcast
    sets.precast.FC = {
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		body="Taeon Tabard",
		neck="Voltsurge Torque",
		ring1="Weatherspoon Ring +1",
		ring2="Prolix Ring",
		ear2="Loquacious Earring",
		hands="Thaumas Gloves",
		back="Perimede Cape",
		waist="Witful Belt",
		legs="Rawhide Trousers",
		feet="Regal Pumps +1",
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		body="Taeon Tabard",
		neck="Voltsurge Torque",
		ring1="Weatherspoon Ring +1",
		ring2="Prolix Ring",
		ear2="Loquacious Earring",
		hands="Thaumas Gloves",
		back="Perimede Cape",
		waist="Witful Belt",
		legs="Rawhide Trousers",
		feet="Regal Pumps +1",
    }

    -------------------------------------Kiting
    sets.Kiting = {feet="Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
		neck="Magoraga Beads",
		body="Passion Jacket",
		back="Mujin Mantle",
	})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet="Karagoz Scarpe"}

    sets.precast.JA["Ventriloquy"] = {legs=Relic_Pitre.Legs_PMagic}

    sets.precast.JA["Role Reversal"] = {feet=Relic_Pitre.Feet_PMagic}

    sets.precast.JA["Overdrive"] = {body=Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
        ammo = "Automat. Oil +3",
		main="Nibiru Sainti",
		feet="Foire Babouches +1",
		ear1="Guignol Earring",
		ear2="Pratik Earring",
		legs="Desultor Tassets"
	}

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
		main="Midnights",
		neck="Buffoon's Collar +1",
		body="Karagoz Farsetto",
		hands="Foire Dastanas +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		ear1="Burana Earring"
	}

    sets.precast.JA["Activate"] = {
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		body="Foire Tobe +1"
	}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {
		main="Mafic Cudgel",
		ear1="Friomisi Earring",
		ear2="Cryptic Earring",
		neck="Unmoving Collar +1",
		waist="Goading Belt",
		head="Hizamaru Somen +2",
		body="Passion Jacket",
		hands="Kurys Gloves",
		ring1="Petrov Ring",
		ring2="Begrudging Ring",
		legs="Obatala Subligar",
		back="Umbra Cape",
		feet="Rager Ledel. +1"
	}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Unmoving Collar +1",
		ear1="Odnowa Earring +1",
		ear2="Roundel Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},
		hands="Slither Gloves +1",
		ring1="Niqmaddu Ring",
		ring2="Titan Ring +1",
		back="Iximulew Cape",
		waist="Warwolf Belt",
		legs="Samnuha Tights",
		feet="Rawhide Boots",
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hizamaru Somen +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Hiza. Haramaki +1",
		hands="Malignance Gloves",
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back="Dispersal Mantle",
		waist="Fotia Belt",
		legs="Rao Haidate",
		feet="Hiza. Sune-ate +1",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		back="Rancorous Mantle",
	})

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
		body="Abnoba Kaftan",
		waist="Moonbow Belt",
		ear1="Brutal Earring",
		ring2="Begrudging Ring",
		ring1="Niqmaddu Ring",
		legs="Rao Haidate",
		hands={ name="Ryuo Tekko", augments={'STR+10','DEX+10','Accuracy+15',}},
		feet={ name="Ryuo Sune-Ate", augments={'STR+10','Attack+20','Crit. hit rate+3%',}},
		back="Dispersal Mantle",
		head="Rao Kabuto",
	})

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {
        head="Ryuo Somen",
		body="Naga Samue",
		hands="Malignance Gloves",
		legs="Samnuha Tights",
		neck="Fotia Gorget",
		waist="Moonbow Belt",
	})--Malignance Gloves

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
		neck = "Fotia Gorget",
        ear1 = "Ishvara Earring",
        ear2 = "Moonshade Earring",
        body = Artifact_Foire.Body_WSD_PTank,
        hands = Relic_Pitre.Hands_WSD,
        ring1 = "Ifrit Ring +1",
        ring2 = "Epaminondas's Ring",
        waist = "Moonbow Belt +1",
        legs = "Hiza. Hizayoroi +2",
        feet = "Ryuo Sune-Ate"
	})

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Loricate Torque +1",
        body="Hiza. Haramaki +1",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back="Umbra Cape",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		waist="Incarnation Sash",
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
		ammo="Automat. Oil +3",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Tali'ah Manteel +1",
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back="Dispersal Mantle",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		waist="Moonbow Belt",
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = {
		ammo="Automat. Oil +3",
		head="Alhazen Hat +1",
		neck="Subtlety Spectacles",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		body="Hiza. Haramaki +1",
		hands="Malignance Gloves",
		ring1="Cacoethic Ring +1",
		ring2="Cacoethic Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Incarnation Sash",
		legs="Hiza. Hizayoroi +1",
		feet="Hiza. Sune-ate +1",
    }

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = {
		ammo="Automat. Oil +3",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Tali'ah Manteel +1",
		hands={ name="Herculean Gloves", augments={'Attack+18','"Triple Atk."+3','Accuracy+11',}},
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back="Dispersal Mantle",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		waist="Moonbow Belt",
	}

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = {
		ammo="Automat. Oil +3",
		head={ name="Herculean Helm", augments={'Accuracy+9 Attack+9','"Triple Atk."+4','STR+4','Attack+6',}},
		neck="Loricate Torque +1",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
		body="Tali'ah Manteel +1",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Umbra Cape",
		legs={ name="Herculean Trousers", augments={'Accuracy+17','"Triple Atk."+3','STR+5',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+6',}},
		waist="Incarnation Sash",
    }

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Tali'ah Turban +1",
		neck="Shulmanu Collar",
		ear2="Enmerkar Earring",
		ear1="Domes. Earring",
		body="Pitre Tobe +1",
		hands="Regimen Mittens",
		ring1="Varar Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Incarnation Sash",
		legs="Tali'ah Sera. +1",
		feet="Naga Kyahan",
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",
		neck="Empath Necklace",
		ear2="Enmerkar Earring",
		ear1="Domes. Earring",
        body="Tali'ah Manteel +1",
		hands="Tali'ah Gages +1",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Incarnation Sash",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
		
    }
        

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Tali'ah Turban +1",
		neck="Shulmanu Collar",
		ear2="Enmerkar Earring",
		ear1="Domes. Earring",
		body="Pitre Tobe +1",
		hands="Regimen Mittens",
		ring1="Varar Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Incarnation Sash",
		legs="Tali'ah Sera. +1",
		feet="Naga Kyahan",
    }

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = {
		main="Midnights",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Rao Kabuto",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Rao Togi",
		hands="Rao Kote",
		ring1="Overbearing Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Tali'ah Sera. +1",
		feet="Rao Sune-Ate",
    }--body="Rao Togi"/feet="Rao Sune-Ate"

	--[[
	body={ name="Taeon Tabard", augments={'Pet: Attack+24 Pet: Rng.Atk.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
    hands={ name="Taeon Gloves", augments={'Pet: Attack+23 Pet: Rng.Atk.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
    feet={ name="Taeon Boots", augments={'Pet: Attack+21 Pet: Rng.Atk.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
	
	]]
    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Rao Kabuto",
		neck="Empath Necklace",
		ear1="Burana Earring",
		ear2="Enmerkar Earring",
		body="Rao Togi",
		hands="Rao Kote",
		ring1="Varar Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Tali'ah Sera. +1",
		feet="Rao Sune-Ate",
    }

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
       -- Add your set here 
    }

    sets.midcast.Pet.Cure = {
       range="Animator P II",
	   ear1="Burana Earring",
	   ear2="Enmerkar Earring",
	   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
	   legs="Foire Churidars +1",
	   waist="Ukko Sash",
	   neck="Adad Amulet",
    }

    sets.midcast.Pet["Healing Magic"] = {
       range="Animator P II",
	   ear1="Burana Earring",
	   ear2="Enmerkar Earring",
	   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
	   legs="Foire Churidars +1",
	   waist="Ukko Sash",
	   neck="Adad Amulet",
    }

    sets.midcast.Pet["Elemental Magic"] = {
       range="Animator P II",
	   ear2="Enmerkar Earring",
	   ear1="Burana Earring",
	   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
	   head="Tali'ah Turban +1",
	   body="Tali'ah Manteel +1",
	   hands="Naga Tekko",
	   legs="Tali'ah Sera. +1",
	   feet="Tali'ah Crackows +1",
	   waist="Ukko Sash",
	   neck="Adad Amulet",
    }

    sets.midcast.Pet["Enfeebling Magic"] = {
       range="Animator P II",
	   ear2="Enmerkar Earring",
	   ear1="Burana Earring",
	   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
	   head="Tali'ah Turban +1",
	   body="Tali'ah Manteel +1",
	   hands="Naga Tekko",
	   legs="Tali'ah Sera. +1",
	   feet="Tali'ah Crackows +1",
	   waist="Ukko Sash",
	   neck="Adad Amulet",
    }

    sets.midcast.Pet["Dark Magic"] = {
       range="Animator P II",
	   ear2="Enmerkar Earring",
	   ear1="Burana Earring",
	   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
	   head="Tali'ah Turban +1",
	   body="Tali'ah Manteel +1",
	   hands="Naga Tekko",
	   legs="Tali'ah Sera. +1",
	   feet="Tali'ah Crackows +1",
	   waist="Ukko Sash",
	   neck="Adad Amulet",
    }

    sets.midcast.Pet["Divine Magic"] = {
       range="Animator P II",
	   ear2="Enmerkar Earring",
	   ear1="Burana Earring",
	   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
	   head="Tali'ah Turban +1",
	   body="Tali'ah Manteel +1",
	   hands="Naga Tekko",
	   legs="Tali'ah Sera. +1",
	   feet="Tali'ah Crackows +1",
	   waist="Ukko Sash",
	   neck="Adad Amulet",
    }

    sets.midcast.Pet["Enhancing Magic"] = {
       range="Animator P II",
	   ear2="Enmerkar Earring",
	   ear1="Burana Earring",
	   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
	   head="Tali'ah Turban +1",
	   body="Tali'ah Manteel +1",
	   hands="Naga Tekko",
	   legs="Tali'ah Sera. +1",
	   feet="Tali'ah Crackows +1",
	   waist="Ukko Sash",
	   neck="Adad Amulet",
    }

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = {
		main="Ohtas",
		ammo="Automat. Oil +3",
        head="Pitre Taj +1",
		neck="Empath Necklace",
		ear2="Enmerkar Earring",
		ear1="Burana Earring",
        body="Hiza. Haramaki +1",
		hands="Rao Kote",
		ring1="Dark Ring",
		ring2="Defending Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Rao Haidate",
		feet="Hermes' Sandals"
    }

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = {
		main="Midnights",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Rao Kabuto",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Rao Togi",
		hands="Rao Kote",
		ring1="Overbearing Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Tali'ah Sera. +1",
		feet="Rao Sune-Ate",
		}
	
	--[[
		Weapon -5% DT
		Head -10% DT
		Neck -2% DT
		ear1 -4% PDT
		ear2 -3% DT
		body -4% DT
		hands -4% DT
		back -5% DT
		waist -3% DT
		legs -5% DT
		feet -4% DT
		DT-45%   PDT-49%
	
	]]

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
		main="Condemners",
		head="Heyoka Cap",
		body="He. Harness +1",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar",
		feet="Heyoka Leggings",
		neck="Shepherd's Chain",
		waist="Isa Belt",
		ear1="Domes. Earring",
		ear2="Rimeice Earring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		ring1="Overbearing Ring",
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
		main="Midnights",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Rao Kabuto",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
		body="Rao Togi",
		hands="Rao Kote",
		ring1="Overbearing Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Tali'ah Sera. +1",
		feet="Rao Sune-Ate",
    }

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Tali'ah Turban +1",
		neck="Shulmanu Collar",
		ear2="Enmerkar Earring",
		ear1="Domes. Earring",
		body="Pitre Tobe +1",
		hands="Regimen Mittens",
		ring1="Varar Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Incarnation Sash",
		legs="Tali'ah Sera. +1",
		feet="Naga Kyahan",
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
        head="Tali'ah Turban +1",
		neck="Empath Necklace",
		ear2="Enmerkar Earring",
		ear1="Domes. Earring",
        body="Tali'ah Manteel +1",
		hands="Tali'ah Gages +1",
		ring1="Varar Ring",
		ring2="Varar Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Incarnation Sash",
		legs="Tali'ah Sera. +1",
		feet="Tali'ah Crackows +1",
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Tali'ah Turban +1",
		neck="Shulmanu Collar",
		ear2="Enmerkar Earring",
		ear1="Domes. Earring",
		body="Pitre Tobe +1",
		hands="Regimen Mittens",
		ring1="Varar Ring",
		ring2="Varar Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Incarnation Sash",
		legs="Tali'ah Sera. +1",
		feet="Naga Kyahan",
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = {
		main="Midnights",
		range="Animator P +1",
		ammo="Automat. Oil +3",
        head="Rao Kabuto",
		neck="Empath Necklace",
		ear1="Handler's Earring +1",
		ear2="Enmerkar Earring",
        body="Rao Togi",
		hands="Rao Kote",
		ring1="Overbearing Ring",
		ring2="Varar Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Tali'ah Sera. +1",
		feet="Rao Sune-Ate",
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
        head="Pitre Taj +1",
		neck="Empath Necklace",
		ear1="Burana Earring",
		ear2="Enmerkar Earring",
        body="Rao Togi",
		hands="Rao Kote",
		ring1="Overbearing Ring",
		ring2="Varar Ring",
        back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Tali'ah Sera. +1",
		feet="Rao Sune-Ate",
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged =
        set_combine(sets.idle.Pet.Engaged, {
            legs = Empy_Karagoz.Legs_Combat,
			feet="Tali'ah Crackows +1",
        })

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
		main="Ohtas",
		range="Animator P +1",
        neck="Shulmanu Collar",
		head="Karagoz Capello",
		body="Tali'ah Manteel +1",
		hands="Karagoz Guanti",
		legs="Karagoz Pantaloni",
		feet="Naga Kyahan",
		back="Dispersal Mantle",
		ear1="Burana Earring",
		ear2="Enmerkar Earring",
		waist="Incarnation Sash",
		ring1="Overbearing Ring",
		ring2="Varar Ring",
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
        main="Ohtas",
		range="Animator P +1",
        neck="Shulmanu Collar",
		head="Karagoz Capello",
		body="Tali'ah Manteel +1",
		hands="Karagoz Guanti",
		legs="Karagoz Pantaloni",
		feet="Naga Kyahan",
		back="Dispersal Mantle",
		ear1="Burana Earring",
		ear2="Enmerkar Earring",
		waist="Incarnation Sash",
		ring1="Overbearing Ring",
		ring2="Varar Ring",
		}--body="Tali'ah Manteel +2",

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {}

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(
        sets.midcast.Pet.WSNoFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
            head = Empy_Karagoz.Head_PTPBonus
        }
    )

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {ring1="Varar Ring",})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] = set_combine(sets.midcast.Pet.WSFTP, {
        ring1="Varar Ring",
        head = Empy_Karagoz.Head_PTPBonus,
		body="Pitre Tobe +1",
    })

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
		main="Ohtas",
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Pitre Taj +1",
		neck="Empath Necklace",
		ear2="Enmerkar Earring",
		ear1="Burana Earring",
		body="Hiza. Haramaki +1",
		hands="Rao Kote",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		waist="Isa Belt",
		legs="Rao Haidate",
		feet="Hermes' Sandals"
		}

    -- Resting sets
    sets.resting = {
		neck="Sanctity Necklace",
        ring1="Chirich Ring",
		ring2="Chirich Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10',}},
		ear2="Infused Earring",
		waist="Isa Belt",
		head="Pitre Taj +1",
		hands="Rao Kote",
		legs="Rao Haidate",
		feet="Rao Sune-Ate",
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {
		head="Rao Kabuto",
		body="Rao Togi",
		hands="Rao Kote",
		feet="Rao Sune-Ate",
		neck="Empath Necklace",
	})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == "WAR" then
        set_macro_page(1, 13)
    elseif player.sub_job == "NIN" then
        set_macro_page(1, 13)
    elseif player.sub_job == "DNC" then
        set_macro_page(1, 13)
    else
        set_macro_page(1, 13)
    end
end

