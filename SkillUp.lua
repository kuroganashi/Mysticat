--[[How to use:
        --this tool is set it and forget it you can leave it running for hours as long as se does not log you out it will keep running--
        1.)place "skillup.lua" in your normal gearswap folder(where all your job files are)
        2.)then us "gs l skillup.lua" to load this skill up in to gearswap
        3.) on lines 22 and 25 of this file you can put in you wind and string instruments
        to start Geomancy magic skillup use command "gs c startgeo"
        to start Healing magic skillup use command "gs c starthealing"
        to start Enhancing magic skillup use command "gs c startenhancing"
        to start Ninjutsu magic skillup use command "gs c startninjutsu"
        to start Singing magic skillup use command "gs c startsinging"
        to start Blue magic skillup use command "gs c startblue"
        to start Summoning magic skillup use command "gs c startsmn"
        to stop all skillups use command "gs c skillstop"
        to auto shutdown after skillup use command "gs c aftershutdown"
        to auto logoff after skillup use command "gs c afterlogoff"
        to just stop and stay logged on after skillup use command "gs c afterStop"(only needed if you use one of the above auto shutdown/logoff)
       
        much thanks to Arcon,Byrth,Mote,and anybody else i forgot for the help in making this]]
require 'actions'
function get_sets()
        skilluprun = false
        sets.brd = {}
        sets.brd.wind = {
                range="Linos"--put your wind instrument here
        }
        sets.brd.string = {
                range="Terpander"--put your string instrument here
        }
        skilluptype = {"Geomancy","Healing","Enhancing","Ninjutsu","Singing","Blue","Summoning"}
        skillupcount = 1
        geospells = {"Indi-Acumen","Indi-AGI","Indi-Attunement","Indi-Barrier","Indi-CHR","Indi-DEX","Indi-Fade","Indi-Fend","Indi-Focus","Indi-Frailty","Indi-Fury","Indi-Gravity","Indi-Haste","Indi-INT","Indi-Languor","Indi-Malaise","Indi-MND","Indi-Paralysis","Indi-Poison","Indi-Precision","Indi-Refresh","Indi-Regen","Indi-Slip","Indi-Slow","Indi-STR","Indi-Torpor","Indi-Vex","Indi-VIT","Indi-Voidance","Indi-Wilt"}
        geocount = 1
        healingspells = {"Blindna","Cura","Cura II","Cura III","Curaga","Curaga II","Curaga III","Curaga IV","Curaga V","Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI","Cursna","Esuna","Paralyna","Poisona","Reraise","Reraise II","Reraise III","Silena","Stona","Viruna"}
        healingcount = 1
        enhancespells = {"Adloquium","Animus Augeo","Animus Minuo","Aquaveil","Aurorastorm","Auspice","Baraera","Baraero","Baramnesia","Baramnesra","Barblind","Barblindra","Barblizzara","Barblizzard","Barfira","Barfire","Barparalyze","Barparalyzra","Barpetra","Barpetrify","Barpoison","Barpoisonra","Barsilence","Barsilencera","Barsleep","Barsleepra","Barstone","Barstonra","Barthunder","Barthundra","Barvira","Barvirus","Barwater","Barwatera","Blaze Spikes","Blink","Boost-AGI","Boost-CHR","Boost-DEX","Boost-INT","Boost-MND","Boost-STR","Boost-VIT","Crusade","Deodorize","Embrava","Enaero","Enaero II","Enblizzard","Enblizzard II","Enfire","Enfire II","Enstone","Enstone II","Enthunder","Enthunder II","Enwater","Enwater II","Erase","Escape","Firestorm","Foil","Gain-AGI","Gain-CHR","Gain-DEX","Gain-INT","Gain-MND","Gain-STR","Gain-VIT","Hailstorm","Haste","Ice Spikes","Invisible","Phalanx","Phalanx II","Protect","Protect II","Protect III","Protect IV","Protect V","Protectra","Protectra II","Protectra III","Protectra IV","Protectra V","Rainstorm","Refresh","Refresh II","Regen","Regen II","Regen III","Regen IV","Regen V","Reprisal","Sandstorm","Shell","Shell II","Shell III","Shell IV","Shell V","Shellra","Shellra II","Shellra III","Shellra IV","Shellra V","Shock Spikes","Sneak","Stoneskin","Temper","Thunderstorm","Voidstorm","Windstorm"}
        enhancecount = 1
        ninspells = {"Gekka: Ichi","Kakka: Ichi","Migawari: Ichi","Monomi: Ichi","Myoshu: Ichi","Tonko: Ichi","Tonko: Ni","Utsusemi: Ichi","Utsusemi: Ni","Yain: Ichi","Yain: Ichi","Gekka: Ichi"}
        nincount = 1
        nincant = {}
        nincantcount = 0
        if player.main_job == "NIN" or player.sub_job == "NIN" then
                ninspellitem = S{
                        ["Doton: Ichi"] = "Makibishi",
                        ["Doton: Ni"] = "Makibishi",
                        ["Doton: San"] = "Makibishi",
                        ["Huton: Ichi"] = "Kawahori-Ogi",
                        ["Huton: Ni"] = "Kawahori-Ogi",
                        ["Huton: San"] = "Kawahori-Ogi",
                        ["Hyoton: Ichi"] = "Tsurara",
                        ["Hyoton: Ni"] = "Tsurara",
                        ["Hyoton: San"] = "Tsurara",
                        ["Katon: Ichi"] = "Uchitake",
                        ["Katon: Ni"] = "Uchitake",
                        ["Katon: San"] = "Uchitake",
                        ["Raiton: Ichi"] = "Hiraishin",
                        ["Raiton: Ni"] = "Hiraishin",
                        ["Raiton: San"] = "Hiraishin",
                        ["Suiton: Ichi"] = "Mizu-Deppo",
                        ["Suiton: Ni"] = "Mizu-Deppo",
                        ["Suiton: San"] = "Mizu-Deppo",
                        ["Kakka: Ichi"] = "Ryuno",
                        ["Migawari: Ichi"] = "Mokujin",
                        ["Monomi: Ichi"] = "Sanjaku-Tenugui",
                        ["Myoshu: Ichi"] = "Kabenro",
                        ["Tonko: Ichi"] = "Shinobi-Tabi",
                        ["Tonko: Ni"] = "Shinobi-Tabi",
                        ["Tonko: San"] = "Shinobi-Tabi",
                        ["Utsusemi: Ichi"] = "Shihei",
                        ["Utsusemi: Ni"] = "Shihei",
                        ["Utsusemi: San"] = "Shihei",
                        ["Aisha: Ichi"] = "Soshi",
                        ["Dokumori: Ichi"] = "Kodoku",
                        ["Dokumori: Ni"] = "Kodoku",
                        ["Dokumori: San"] = "Kodoku",
                        ["Hojo: Ichi"] = "Kaginawa",
                        ["Hojo: Ni"] = "Kaginawa",
                        ["Hojo: San"] = "Kaginawa",
                        ["Jubaku: Ichi"] = "Jusatsu",
                        ["Jubaku: Ni"] = "Jusatsu",
                        ["Jubaku: San"] = "Jusatsu",
                        ["Kurayami: Ichi"] = "Sairui-Ran",
                        ["Kurayami: Ni"] = "Sairui-Ran",
                        ["Kurayami: San"] = "Sairui-Ran",
                        ["Yurin: Ichi"] = "Jinko",
                        ["Gekka: Ichi"] = "Ranka",
                        ["Yain: Ichi"] = "Furusumi",
                        }
                ninplustool = S{
                        ["Makibishi"] = "Inoshishinofuda",
                        ["Kawahori-Ogi"] = "Inoshishinofuda",
                        ["Tsurara"] = "Inoshishinofuda",
                        ["Uchitake"] = "Inoshishinofuda",
                        ["Hiraishin"] = "Inoshishinofuda",
                        ["Mizu-Deppo"] = "Inoshishinofuda",
                        ["Ryuno"] = "Shikanofuda",
                        ["Mokujin"] = "Shikanofuda",
                        ["Sanjaku-Tenugui"] = "Shikanofuda",
                        ["Kabenro"] = "Shikanofuda",
                        ["Shinobi-Tabi"] = "Shikanofuda",
                        ["Shihei"] = "Shikanofuda",
                        ["Soshi"] = "Chonofuda",
                        ["Kodoku"] = "Chonofuda",
                        ["Kaginawa"] = "Chonofuda",
                        ["Jusatsu"] = "Chonofuda",
                        ["Sairui-Ran"] = "Chonofuda",
                        ["Jinko"] = "Chonofuda",
                        ["Ranka"] = "Ranka",
                        ["Furusumi"] = "Furusumi",
                        }
                nintoolbag = S{
                        ["Makibishi"] = "Toolbag (Maki)",
                        ["Kawahori-Ogi"] = "Toolbag (Kawa)",
                        ["Tsurara"] = "Toolbag (Tsura)",
                        ["Uchitake"] = "Toolbag (Uchi)",
                        ["Hiraishin"] = "Toolbag (Hira)",
                        ["Mizu-Deppo"] = "Toolbag (Mizu)",
                        ["Ryuno"] = "Toolbag (Ryuno)",
                        ["Mokujin"] = "Toolbag (Moku)",
                        ["Sanjaku-Tenugui"] = "Toolbag (Sanja)",
                        ["Kabenro"] = "Toolbag (Kabenro)",
                        ["Shinobi-Tabi"] = "Toolbag (Shino)",
                        ["Shihei"] = "Toolbag (Shihei)",
                        ["Soshi"] = "Toolbag (Soshi)",
                        ["Kodoku"] = "Toolbag (Kodo)",
                        ["Kaginawa"] = "Toolbag (Kagi)",
                        ["Jusatsu"] = "Toolbag (Jusa)",
                        ["Sairui-Ran"] = "Toolbag (Sai)",
                        ["Jinko"] = "Toolbag (Jinko)",
                        ["Inoshishinofuda"] = "Toolbag (Ino)",
                        ["Shikanofuda"] = "Toolbag (Shika)",
                        ["Chonofuda"] = "Toolbag (Cho)",
                        ["Ranka"] = "Toolbag (Ranka)",
                        ["Furusumi"] = "Toolbag (Furu)",
                        }
                toolbagtoid = {
                        ["Toolbag (Uchi)"] = 5308,
                        ["Toolbag (Tsura)"] = 5309,
                        ["Toolbag (Kawa)"] = 5310,
                        ["Toolbag (Maki)"] = 5311,
                        ["Toolbag (Hira)"] = 5312,
                        ["Toolbag (Mizu)"] = 5313,
                        ["Toolbag (Shihe)"] = 5314,
                        ["Toolbag (Jusa)"] = 5315,
                        ["Toolbag (Kagi)"] = 5316,
                        ["Toolbag (Sai)"] = 5317,
                        ["Toolbag (Kodo)"] = 5318,
                        ["Toolbag (Shino)"] = 5319,
                        ["Toolbag (Sanja)"] = 5417,
                        ["Toolbag (Soshi)"] = 5734,
                        ["Toolbg. (Kaben)"] = 5863,
                        ["Toolbag (Jinko)"] = 5864,
                        ["Toolbag (Ryuno)"] = 5865,
                        ["Toolbag (Moku)"] = 5866,
                        ["Toolbag (Ino)"] = 5867,
                        ["Toolbag (Shika)"] = 5868,
                        ["Toolbag (Cho)"] = 5869,
                        ["Toolbag (Ranka)"] = 6265,
                        ["Toolbag (Furu)"] = 6266,
                        }
                tbid = 0
        end
        songspells = {"Knight's Minne","Advancing March","Adventurer's Dirge","Archer's Prelude","Army's Paeon","Army's Paeon II","Army's Paeon III","Army's Paeon IV","Army's Paeon V","Army's Paeon VI","Bewitching Etude","Blade Madrigal","Chocobo Mazurka","Dark Carol","Dark Carol II","Dextrous Etude","Dragonfoe Mambo","Earth Carol","Earth Carol II","Enchanting Etude","Fire Carol","Fire Carol II","Foe Sirvente","Fowl Aubade","Goblin Gavotte","Goddess's Hymnus","Gold Capriccio","Herb Pastoral","Herculean Etude","Hunter's Prelude","Ice Carol","Ice Carol II","Knight's Minne II","Knight's Minne III","Knight's Minne IV","Knight's Minne V","Learned Etude","Light Carol","Light Carol II","Lightning Carol","Lightning Carol II","Logical Etude","Mage's Ballad","Mage's Ballad II","Mage's Ballad III","Puppet's Operetta","Quick Etude","Raptor Mazurka","Sage Etude","Scop's Operetta","Sentinel's Scherzo","Sheepfoe Mambo","Shining Fantasia","Sinewy Etude","Spirited Etude","Swift Etude","Sword Madrigal","Uncanny Etude","Valor Minuet","Valor Minuet II","Valor Minuet III","Valor Minuet IV","Valor Minuet V","Victory March","Vital Etude","Vivacious Etude","Warding Round","Water Carol","Water Carol II","Wind Carol","Wind Carol II"}
        songcount = 1
        bluspells = {"Pollen","Wild Carrot","Refueling","Feather Barrier","Magic Fruit","Diamondhide","Warm-Up","Amplification","Triumphant Roar","Saline Coat","Reactor Cool","Plasma Charge","Plenilune Embrace","Regeneration","Animating Wail","Battery Charge","Magic Barrier","Fantod","Winds of Promy.","Barrier Tusk","White Wind","Harden Shell","O. Counterstance","Pyric Bulwark","Nat. Meditation","Carcharian Verve","Healing Breeze"}
        bluspellul = S{"Harden Shell","Thunderbolt","Absolute Terror","Gates of Hades","Tourbillion","Pyric Bulwark","Bilgestorm","Bloodrake","Droning Whirlwind","Carcharian Verve","Blistering Roar"}
        ulid = S{
                ["Harden Shell"] = 737,
                ["Thunderbolt"] = 736,
                ["Absolute Terror"] = 738,
                ["Gates of Hades"] = 739,
                ["Tourbillion"] = 740,
                ["Pyric Bulwark"] = 741,
                ["Bilgestorm"] = 742,
                ["Bloodrake"] = 743,
                ["Droning Whirlwind"] = 744,
                ["Carcharian Verve"] = 745,
                ["Blistering Roar"] = 746,
                }
        blucount = 1
        smnspells = {"Carbuncle","Cait Sith","Diabolos","Fenrir","Garuda","Ifrit","Leviathan","Ramuh","Shiva","Titan","Air Spirit","Dark Spirit","Earth Spirit","Fire Spirit","Ice Spirit","Light Spirit","Thunder Spirit","Water Spirit"}
        smncount = 1
        sets.Idle = {
                main="Dark Staff",
                left_ear="Relaxing Earring",
                right_ear="Liminus Earring",
        }
        shutdown = false
        logoff = false
        healingcap = false
        enhancingcap = false
        summoningcap = false
        ninjutsucap = false
        singingcap = false
        stringcap = false
        windcap = false
        bluecap = false
        geomancycap = false
        handbellcap = false
        add_to_chat(123,"Skill Up Loaded")
end
function status_change(new,old)
        if new=='Idle' then
                equip(sets.Idle)
                if skilluptype[skillupcount] == "Geomancy" and skilluprun then
                        send_command('wait 1.0;input /ma "'..geospells[geocount]..'" <me>')
                elseif skilluptype[skillupcount] == "Healing" and skilluprun then
                        send_command('wait 1.0;input /ma "'..healingspells[healingcount]..'" <me>')
                elseif skilluptype[skillupcount] == "Enhancing" and skilluprun then
                        send_command('wait 1.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
                elseif skilluptype[skillupcount] == "Ninjutsu" and skilluprun then
                        send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
                elseif skilluptype[skillupcount] == "Singing" and skilluprun then
                        send_command('wait 1.0;input /ma "'..songspells[songcount]..'" <me>')
                elseif skilluptype[skillupcount] == "Blue" and skilluprun then
                        send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
                elseif skilluptype[skillupcount] == "Summoning" and skilluprun then
                        send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
                end
        end
end
function filtered_action(spell)
        if spell.type == "Geomancy" and skilluprun then
                cancel_spell()
                if geocount < 30 then
                        geocount = geocount +1
                else
                        geocount = 1
                end
                send_command('input /ma "'..geospells[geocount]..'" <me>')
                return
        elseif spell.skill == "Healing Magic" and skilluprun then
                cancel_spell()
                if healingcount < 25 then
                        healingcount = healingcount +1
                else
                        healingcount = 1
                end
                send_command('input /ma "'..healingspells[healingcount]..'" <me>')
                return
        elseif spell.skill == "Enhancing Magic" and skilluprun then
                cancel_spell()
                if enhancecount < 112 then
                        enhancecount = enhancecount +1
                else
                        enhancecount = 1
                end
                send_command('input /ma "'..enhancespells[enhancecount]..'" <me>')
                return
        elseif spell.skill == "Ninjutsu" and skilluprun then
                cancel_spell()
                nin_tool_check(spell)
        elseif spell.skill == "Singing" and skilluprun then
                cancel_spell()
                if songcount < 71 then
                        songcount = songcount +1
                else
                        songcount = 1
                end
                send_command('input /ma "'..songspells[songcount]..'" <me>')
                return
        elseif spell.skill == "Blue Magic" and skilluprun then
                cancel_spell()
                if blucount < 27 then
                        blucount = blucount +1
                else
                        blucount = 1
                end
                send_command('input /ma "'..bluspells[blucount]..'" <me>')
                return
        elseif spell.type == "SummonerPact" and skilluprun then
                cancel_spell()
                if smncount < 18 then
                        smncount = smncount +1
                else
                        smncount = 1
                end
                send_command('input /ma "'..smnspells[smncount]..'" <me>')
                return
        elseif spell.name == "Unbridled Learning" then
                cancel_spell()
                if blucount < 27 then
                        blucount = blucount +1
                else
                        blucount = 1
                end
                send_command('input /ma "'..bluspells[blucount]..'" <me>')
                return
        elseif spell.name == "Avatar's Favor" then
                        cancel_spell()
                        send_command('input /ja "Release" <me>')
                        return
        end
end
function precast(spell)
        if spell then
                if spell.mp_cost > player.mp then
                        cancel_spell()
                        send_command('input /heal on')
                        return
                end
        end
        if spell.type == "Geomancy" and skilluprun then
                if not windower.ffxi.get_spells()[spell.id] then
                        cancel_spell()
                        if geocount < 30 then
                                geocount = geocount +1
                        else
                                geocount = 1
                        end
                        send_command('input /ma "'..geospells[geocount]..'" <me>')
                        return
                elseif geocount < 30 then
                        geocount = geocount +1
                else
                        geocount = 1
                end
        elseif spell.skill == "Healing Magic" and skilluprun then
                if not windower.ffxi.get_spells()[spell.id] then
                        cancel_spell()
                        if healingcount < 25 then
                                healingcount = healingcount +1
                        else
                                healingcount = 1
                        end
                        send_command('input /ma "'..healingspells[healingcount]..'" <me>')
                        return
                elseif healingcount < 25 then
                        healingcount = healingcount +1
                else
                        healingcount = 1
                end
        elseif spell.skill == "Enhancing Magic" and skilluprun then
                if not windower.ffxi.get_spells()[spell.id] then
                        cancel_spell()
                        if enhancecount < 112 then
                                enhancecount = enhancecount +1
                        else
                                enhancecount = 1
                        end
                        send_command('input /ma "'..enhancespells[enhancecount]..'" <me>')
                        return
                elseif enhancecount < 112 then
                        enhancecount = enhancecount +1
                else
                        enhancecount = 1
                end
        elseif spell.skill == "Ninjutsu" and skilluprun then
                if not windower.ffxi.get_spells()[spell.id] then
                        cancel_spell()
                        if nincount < 12 then
                                nincount = nincount +1
                        else
                                nincount = 1
                        end
                        send_command('input /ma "'..ninspells[nincount]..'" <me>')
                        return
                elseif nincount < 12 then
                        nincount = nincount +1
                else
                        nincount = 1
                end
        elseif spell.skill == "Singing" and skilluprun then
                if not stringcap then
                        equip(sets.brd.string)
                elseif not windcap then
                        equip(sets.brd.wind)
                end
                if not windower.ffxi.get_spells()[spell.id] then
                        cancel_spell()
                        if songcount < 71 then
                                songcount = songcount +1
                        else
                                songcount = 1
                        end
                        send_command('input /ma "'..songspells[songcount]..'" <me>')
                        return
                elseif songcount < 71 then
                        songcount = songcount +1
                else
                        songcount = 1
                end
        elseif spell.skill == "Blue Magic" and skilluprun then
                if not windower.ffxi.get_spells()[spell.id] then
                        cancel_spell()
                        if blucount < 27 then
                                blucount = blucount +1
                        else
                                blucount = 1
                        end
                        send_command('input /ma "'..bluspells[blucount]..'" <me>')
                        return
                elseif blucount < 27 then
                        blucount = blucount +1
                else
                        blucount = 1
                end
        elseif spell.type == "SummonerPact" and skilluprun then
                if not windower.ffxi.get_spells()[spell.id] then
                        cancel_spell()
                        if smncount < 18 then
                                smncount = smncount +1
                        else
                                smncount = 1
                        end
                        send_command('input /ma "'..smnspells[smncount]..'" <me>')
                        return
                elseif smncount < 18 then
                        smncount = smncount +1
                else
                        smncount = 1
                end
        end
        if spell.name == "Avatar's Favor" then
                if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) or buffactive["Avatar's Favor"] then
                        cancel_spell()
                        send_command('input /ja "Release" <me>')
                        return
                end
        elseif spell.name == "Elemental Siphon" then
                if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) or player.mpp > 75 then
                        cancel_spell()
                        send_command('input /ja "Release" <me>')
                        return
                end
        elseif spell.name == "Unbridled Learning" then
                if bluspellul:contains(bluspells[blucount]) and not windower.ffxi.get_spells()[ulid[bluspells[blucount]]] then
                        if not buffactive["Unbridled Learning"] then
                                if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) then
                                        cancel_spell()
                                        if blucount < 27 then
                                                blucount = blucount +1
                                        else
                                                blucount = 1
                                        end
                                        send_command('input /ma "'..bluspells[blucount]..'" <me>')
                                        return
                                end
                        end
                else
                        cancel_spell()
                        if blucount < 27 then
                                blucount = blucount +1
                        else
                                blucount = 1
                        end
                        send_command('input /ma "'..bluspells[blucount]..'" <me>')
                        return
                end
        end
        if spell.name == "Release" then
                if not pet.isvalid then
                        cancel_spell()
                        send_command('input /heal on')
                        return
                end
                if (windower.ffxi.get_ability_recasts()[spell.recast_id] > 0) then
                        cancel_spell()
                        send_command('wait 1.05;input /ja "Release" <me>')
                        return
                end
        end
end
function aftercast(spell)
        if skilluprun then
                if spell.type == "Geomancy" then
                        if geomancycap and handbellcap then
                                skilluprun = false
                                shutdown_logoff()
                                return
                        end
                        send_command('wait 3.0;input /ma "'..geospells[geocount]..'" <me>')
                elseif spell.skill == "Healing Magic" then
                        if healingcap then
                                skilluprun = false
                                shutdown_logoff()
                                return
                        end
                        send_command('wait 3.0;input /ma "'..healingspells[healingcount]..'" <me>')
                elseif spell.skill == "Enhancing Magic" then
                        if enhancingcap then
                                skilluprun = false
                                shutdown_logoff()
                                return
                        end
                        send_command('wait 3.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
                elseif spell.skill == "Ninjutsu" then
                        if ninjutsucap then
                                skilluprun = false
                                shutdown_logoff()
                                return
                        end
                        send_command('wait 3.0;input /ma "'..ninspells[nincount]..'" <me>')
                elseif spell.skill == "Singing" then
                        if singingcap and stringcap and windcap then
                                skilluprun = false
                                shutdown_logoff()
                                return
                        end
                        send_command('wait 3.0;input /ma "'..songspells[songcount]..'" <me>')
                elseif spell.skill == "Blue Magic" then
                        if bluecap then
                                skilluprun = false
                                shutdown_logoff()
                                return
                        end
                        send_command('wait 3.5;input /ja "Unbridled Learning" <me>')
                elseif spell.type == "SummonerPact" then
                        if summoningcap then
                                skilluprun = false
                                send_command('wait 4.0;input /ja "Release" <me>')
                                return
                        end
                        if spell.name:contains('Spirit') then
                                send_command('wait 4.0;input /ja "Elemental Siphon" <me>')
                        else
                                send_command('wait 4.0;input /ja "Avatar\'s Favor" <me>')
                        end
                elseif spell.name == "Release" then
                        send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
                elseif spell.name == "Avatar's Favor" then
                        send_command('wait 1.0;input /ja "Release" <me>')
                elseif spell.name == "Elemental Siphon" then
                        send_command('wait 1.0;input /ja "Release" <me>')
                elseif spell.name == "Unbridled Learning" then
                        send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
                end
        elseif spell.type == "SummonerPact" then
                if summoningcap then
                        skilluprun = false
                        send_command('wait 1.0;input /ja "Release" <me>')
                        return
                end
                if spell.name:contains('Spirit') then
                        send_command('wait 4.0;input /ja "Elemental Siphon" <me>')
                else
                        send_command('wait 4.0;input /ja "Avatar\'s Favor" <me>')
                end
        elseif spell.name == "Release" then
                if summoningcap then
                        shutdown_logoff()
                        return
                end
                if pet and pet.isvalid then
                        send_command('wait 1.05;input /ja "Release" <me>')
                end
        elseif spell.name == "Avatar's Favor" then
                send_command('wait 1.0;input /ja "Release" <me>')
        end
end
function self_command(command)
        if command == "startgeo" then
                skilluprun = true
                skillupcount = 1
                send_command('wait 1.0;input /ma "'..geospells[geocount]..'" <me>')
                add_to_chat(123,"Starting Geomancy Skill up")
        end
        if command == "starthealing" then
                skilluprun = true
                skillupcount = 2
                send_command('wait 1.0;input /ma "'..healingspells[healingcount]..'" <me>')
                add_to_chat(123,"Starting Healing Skill up")
        end
        if command == "startenhancing" then
                skilluprun = true
                skillupcount = 3
                send_command('wait 1.0;input /ma "'..enhancespells[enhancecount]..'" <me>')
                add_to_chat(123,"Starting Enhancing Skill up")
        end
        if command == "startninjutsu" then
                skilluprun = true
                skillupcount = 4
                send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
                add_to_chat(123,"Starting Ninjutsu Skill up")
        end
        if command == "startsinging" then
                skilluprun = true
                skillupcount = 5
                send_command('wait 1.0;input /ma "'..songspells[songcount]..'" <me>')
                add_to_chat(123,"Starting Singing Skill up")
        end
        if command == "startblue" then
                skilluprun = true
                skillupcount = 6
                send_command('wait 1.0;input /ma "'..bluspells[blucount]..'" <me>')
                add_to_chat(123,"Starting Blue Magic Skill up")
        end
        if command == "startsmn" then
                skilluprun = true
                skillupcount = 7
                send_command('wait 1.0;input /ma "'..smnspells[smncount]..'" <me>')
                add_to_chat(123,"Starting Summoning Skill up")
        end
        if command == "skillstop" then
                skilluprun = false
                add_to_chat(123,"Stoping Skill up")
        end
        if command == 'aftershutdown' then
                shutdown = true
                logoff = false
                add_to_chat(123, '----- Will Shutdown When Skillup Done -----')
        end
        if command == 'afterlogoff' then
                shutdown = false
                logoff = true
                add_to_chat(123, '----- Will Logoff When Skillup Done -----')
        end
        if command == 'afterStop' then
                shutdown = false
                logoff = false
                add_to_chat(123, '----- Will Stop When Skillup Done -----')
        end
end
function shutdown_logoff()
                add_to_chat(123,"Auto stop skillup")
        if logoff then
                send_command('wait 3.0;input /logoff')
        elseif shutdown then
                send_command('wait 3.0;input /shutdown')
        end
end
function nin_tool_check(spell)
        if spell.type == "Ninjutsu" then
                local tool = ninspellitem[spell.name]
                local stool = ninplustool[tool]
                local toolbag = nintoolbag[tool]
                local stoolbag = nintoolbag[stool]
                if not nincant:contains(spell.name)then
                        if not (player.inventory == tool or player.inventory == stool) then
                                cancel_spell()
                                if player.inventory == toolbag then
                                        tbid = toolbagtoid[toolbag]
                                        send_command('input /item "'..toolbag..'" <me>')
                                elseif player.inventory == stoolbag then
                                        tbid = toolbagtoid[stoolbag]
                                        send_command('input /item "'..stoolbag..'" <me>')
                                else
                                        nincant:append(spell.name)
                                        nincantcount = nincantcount +1
                                end
                                if nincount < 12 then
                                        nincount = nincount +1
                                else
                                        nincount = 1
                                end
                                send_command('input /ma "'..ninspells[nincount]..'" <me>')
                                return
                        end
                elseif nincantcount < 12 then
                        if nincount < 12 then
                                nincount = nincount +1
                        else
                                nincount = 1
                        end
                                send_command('input /ma "'..ninspells[nincount]..'" <me>')
                        return
                else
                        skilluprun = false
                        add_to_chat(123,"You Have No More Of The Tools Needed For Castin of NIN Spells\nStoping NIN Skillup")
                        return
                end
        end
end
function event_action(act)
        action = Action(act)
    if action:get_category_string() == 'item_finish' then
        if action.raw.param == tbid and player.id == action.raw.actor_id then
                        send_command('wait 1.0;input /ma "'..ninspells[nincount]..'" <me>')
                        tbid = 0
                end
    end
end
windower.raw_register_event('action', event_action)
function skill_capped(id, data, modified, injected, blocked)
        if id == 0x062 then
                healingcap = data:unpack('q', 0xC4, 8)
                enhancingcap = data:unpack('q', 0xC6, 8)
                summoningcap = data:unpack('q', 0xCE, 8)
                ninjutsucap = data:unpack('q', 0xD0, 8)
                singingcap = data:unpack('q', 0xD2, 8)
                stringcap = data:unpack('q', 0xD4, 8)
                windcap = data:unpack('q', 0xD6, 8)
                bluecap = data:unpack('q', 0xD8, 8)
                geomancycap = data:unpack('q', 0xDA, 8)
                handbellcap = data:unpack('q', 0xDC, 8)
        end
        if id == 0x0DF then
                if data:unpack('I', 0x0D) == player.max_mp and skilluprun then
                        windower.send_command('input /heal off')
                end
        end
end
windower.raw_register_event('incoming chunk', skill_capped)
