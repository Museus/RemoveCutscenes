--[[
    RemoveCutscenes
    Author:
        Museus (Discord: Museus#7777)

    Optionally removes intro and outro cutscenes to runs
]]
ModUtil.Mod.Register("RemoveCutscenes")

local config = {
    ModName = "RemoveCutscenes",
    RemoveIntro = true,
    RemoveOutro = true,
}
RemoveCutscenes.config = config

-- Remove starting cutscene
ModUtil.Path.Wrap("ShowRunIntro", function( baseFunc )
    if config.RemoveIntro then
        return
    end

    baseFunc()
end, RemoveCutscenes)

ModUtil.Path.Wrap("EndEarlyAccessPresentation", function ( baseFunc )
    if config.RemoveOutro then
        CurrentRun.ActiveBiomeTimer = false

        thread( Kill, CurrentRun.Hero )
        wait( 0.15 )

        FadeIn({ Duration = 0.5 })
        return
    end

    baseFunc()
end, RemoveCutscenes)

-- Scripts/RoomManager.lua : 1874
ModUtil.Path.Wrap("StartRoom", function ( baseFunc, currentRun, currentRoom )
    PrintUtil.showModdedWarning()

    baseFunc(currentRun, currentRoom)
end, RemoveCutscenes)

-- Scripts/UIScripts.lua : 145
ModUtil.Path.Wrap("ShowCombatUI", function ( baseFunc, flag )
    PrintUtil.showModdedWarning()

    baseFunc(flag)
end, RemoveCutscenes)

