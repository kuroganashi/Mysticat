-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------


--You can try it just manually typing in /console gs c toggle MagicBurst and it should put a message in your chat log saying "Magic Burst is now on."

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Refresh', 'Normal')--'None'
    state.CastingMode:options('Normal', 'MP_Back')--'Resistant', 'Proc'
    state.IdleMode:options('Normal', 'PDT')
    
    state.MagicBurst = M(false, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

	sets.precast.Waltz = {
		head="Nahtirah Hat",neck="Unmoving Collar +1",ear2="Roundel Earring",ear1="Soil Pearl",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Warwolf Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}--Lengo Pants
	
    -- Fast cast sets for spells

    sets.precast.FC = {ammo="Impatiens",
        head="Nahtirah Hat",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",neck="Voltsurge Torque",
        body="Vrikodara Jupon",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Ogapepo Cape",legs="Psycloth Lappas",feet="Regal Pumps +1"}--Swith Cape

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Sanctity Necklace"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear1="Mendi. Earring",ear2="Roundel Earring",body="Heka's Kalasiris",hands="Telchine Gloves",back="Pahtli Cape",legs="Nares Trews",feet="Medium's Sabots"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Amar Cluster",
        head="Jhakri Coronal +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Petrov Ring",ring2="Rufescent Ring",
        back="Rancorous Mantle",waist="Fotia Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Barkarole Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
        back="Taranus's Cape",waist="Fotia Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
    
		sets.precast.WS['Myrkr'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Gifted Earring",ear2="Evans Earring",
		body="Witching Robe",hands="Telchine Gloves",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		back="Pahtli Cape",waist="Fucho-No-Obi",legs="Psycloth Lappas",feet="Medium's Sabots"}

		sets.precast.WS['Shattersoul'] = {ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Petrov Ring",ring2="Fenrir Ring +1",back="Taranus's Cape",waist="Fotia Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}--80% INT Base
		
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {ammo="Impatiens",
        head="Nahtirah Hat",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",neck="Voltsurge Torque",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Swith Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Cure = {main="Serenity",ammo="Impatiens",
		head="Nahtirah Hat",neck="Incanter's Torque",ear2="Roundel Earring",ear1="Mendi. Earring",
		body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Weatherspoon Ring",ring2="Kishar Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Nares Trews",feet="Medium's Sabots"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {main="Serenity",
		neck="Incanter's Torque",head="Umuthi Hat",
		body="Vrikodara Jupon",hands="Jhakri Cuffs +1",ring1="Weatherspoon Ring",ring2="Kishar Ring",back="Ogapepo Cape",
		legs="Psycloth Lappas"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",ear1="Earthcry Earring",hands="Carapacho Cuffs",head="Umuthi Hat"})--legs="Haven Hose"

    sets.midcast['Enfeebling Magic'] = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Ischemia Chasu.",hands="Jhakri Cuffs +1",ring1="Fenrir Ring +1",ring2="Stikini Ring",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+7%','CHR+10','Mag. Acc.+11','"Mag.Atk.Bns."+6',}}}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Fenrir Ring +1",ring2="Stikini Ring",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+7%','CHR+10','Mag. Acc.+11','"Mag.Atk.Bns."+6',}}}

    sets.midcast.Drain = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Fenrir Ring +1",ring2="Stikini Ring",
		back="Taranus's Cape",waist="Fucho-No-Obi",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+7%','CHR+10','Mag. Acc.+11','"Mag.Atk.Bns."+6',}}}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Stikini Ring",ring2="Kishar Ring",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+7%','CHR+10','Mag. Acc.+11','"Mag.Atk.Bns."+6',}}}

	sets.midcast.Death = {ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",neck="Sanctity Necklace",ear1="Gifted Earring",ear2="Evans Earring",
		body="Witching Robe",hands="Telchine Gloves",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		back="Pahtli Cape",waist="Fucho-No-Obi",legs="Psycloth Lappas",feet="Medium's Sabots"}	
		
    sets.midcast.BardSong = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+7%','CHR+10','Mag. Acc.+11','"Mag.Atk.Bns."+6',}}}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Jhakri Robe +2",hands="Amalric Gages",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'CHR+9','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}}

    sets.midcast['Elemental Magic'].Resistant = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Jhakri Robe +2",hands="Amalric Gages",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'CHR+9','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}}--Bane Cape

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap"})

	--MP Back
	sets.midcast['Elemental Magic'].MP_Back = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Spae. Coat +1",hands="Amalric Gages",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'CHR+9','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}}
	
	sets.midcast['Elemental Magic'].HighTierNuke.MP_Back = set_combine(sets.midcast['Elemental Magic'], {
		main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Merlinic Hood",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Friomisi Earring",
		body="Spae. Coat +1",hands="Amalric Gages",ring1="Fenrir Ring +1",ring2="Fenrir Ring +1",
		back="Taranus's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet={ name="Merlinic Crackows", augments={'CHR+9','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}})

    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Lathi", sub="Niobid Strap",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Barkarole Earring",ear2="Loquacious Earring",
        body="Vrikodara Jupon",hands="Serpentes Cuffs",ring1="Weatherspoon Ring",ring2="Kishar Ring",
        back="Swith Cape",waist="Witful Belt",legs="Nares Trews",feet="Regal Pumps +1"}


    
    -- Sets to return to when not performing an action.
    
	--Bane Cape
	
	--Taranus's Cape
	
	
	--                   M.ACC+36 MAB+40 Magic Dmg+11
	
	--feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+7%','CHR+10','Mag. Acc.+11','"Mag.Atk.Bns."+6',}}
	
	
	--					CHR+9 M.ACC+19 MAB+61
	
	--feet={ name="Merlinic Crackows", augments={'CHR+9','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Sanctity Necklace",
		body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Lathi", sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Infused Earring",ear2="Loquacious Earring",
		body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Earth Staff", sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +1",neck="Twilight Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Lathi",sub="Niobid Strap",ammo="Impatiens",
        head="Befouled Crown",neck="Sanctity Necklace",ear1="Infused Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
    
    -- Town gear.
    sets.idle.Town = {main="Lathi",sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Sanctity Necklace",ear1="Infused Earring",ear2="Loquacious Earring",
		body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Matrimony Band",ring2="Defending Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Herald's Gaiters"}
        
    -- Defense sets

    sets.defense.PDT = {main="Earth Staff",sub="Niobid Strap",
        head="Jhakri Coronal +1",neck="Twilight Torque",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring2="Dark Ring",ring1="Defending Ring",
        back="Umbra Cape",waist="Hierarch Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Jhakri Coronal +1",neck="Twilight Torque",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring2="Dark Ring",ring1="Defending Ring",
        back="Umbra Cape",waist="Hierarch Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {back="Taranus's Cape",feet="Wicce Sabots"}
	--sets.buff['Sandstorm'] = {feet="Desert Boots"}
	
    sets.magic_burst = {neck="Mizukage-no-Kubikazari",ring1="Locus Ring",ring2="Mujin Band"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Amar Cluster",
		head="Merlinic Hood",ear1="Brutal Earring",ear2="Cessance Earring",neck="Sanctity Necklace",
		body="Jhakri Robe +2",hands="Telchine Gloves",ring1="Petrov Ring",ring2="Chirich Ring",
		back="Umbra Cape",waist="Cetl Belt",legs="Lengo Pants",feet={ name="Merlinic Crackows", augments={'CHR+9','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}}

	sets.engaged.Refresh = {ammo="Pemphredo Tathlum",
		head="Wivre Hairpin",ear1="Brutal Earring",ear2="Cessance Earring",neck="Sanctity Necklace",
		body="Jhakri Robe +2",hands="Serpentes Cuffs",ring1="Petrov Ring",ring2="Chirich Ring",
		back="Umbra Cape",waist="Fucho-No-Obi",legs="Assiduity Pants +1",feet="Serpentes Sabots"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Hachirin-no-Obi"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Refoccilation Stone"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    --if spell.action_type == 'Magic' then
       -- apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    --end
	if spell.skill == 'Elemental Magic'  then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-No-Obi"})
            --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
        end
    end
	if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
        equip(sets.magic_burst)
        end
	end
	if spell.type == "WeaponSkill" then
      if spell.element == world.weather_element or spell.element == world.day_element then
        --equip({waist="Hachirin-no-Obi"})
        --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
      end
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
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
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
	
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


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.Buff['Sublimation: Activated'] then
		if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
		elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
		end
	end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end


-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1,5)
end