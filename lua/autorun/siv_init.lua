siv = {}
siv.version = 0.76
siv.build_date = "11/25/2022"

if CLIENT then
    AddCSLuaFile("siv/client/cl_siv_main.lua")
    AddCSLuaFile("siv/client/cl_siv_settings.lua")

    include("siv/client/cl_siv_main.lua")
    include("siv/client/cl_siv_settings.lua")

    MsgC(Color(69, 140, 255), "##[Simple Item View: Client Initialized]##\n")
end