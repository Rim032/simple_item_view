if GetConVar("siv_scale") == nil then
    CreateClientConVar("siv_scale", 1, true, false, "The scale of the SIV weapon menu. Default is 1.", 1, 4)
end

if GetConVar("siv_offset") == nil then
    CreateClientConVar("siv_offset", 25, true, false, "The height offset of the SIV weapon menu. Default is 25.", 15, 50)
end