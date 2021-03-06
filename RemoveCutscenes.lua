--[[
    RemoveCutscenes
    Author:
        Museus (Discord: Museus#7777)

    Optionally removes intro and outro cutscenes to runs
]]
ModUtil.RegisterMod("RemoveCutscenes")

local config = {
    RemoveIntro = true,
    RemoveOutro = true,
}
RemoveCutscenes.config = config

    -- Remove starting cutscene
ModUtil.WrapBaseFunction("ShowRunIntro", function( baseFunc )
    if config.RemoveIntro then
        return
    end

    baseFunc()
end, RemoveCutscenes)


ModUtil.WrapBaseFunction("EndEarlyAccessPresentation", function ( baseFunc )
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
ModUtil.WrapBaseFunction("StartRoom", function ( baseFunc, currentRun, currentRoom )
    PrintUtil.showModdedWarning()

    baseFunc(currentRun, currentRoom)
end, RemoveCutscenes)

-- Scripts/UIScripts.lua : 145
ModUtil.WrapBaseFunction("ShowCombatUI", function ( baseFunc, flag )
    PrintUtil.showModdedWarning()

    baseFunc(flag)
end, RemoveCutscenes)