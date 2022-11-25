surface.CreateFont( "siv_fontA", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = ScrW()/45.71,
	weight = 50,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "siv_fontB", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = true,
	size = ScrW()/68.57,
	weight = 50,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local mENT = FindMetaTable("Entity")

local wpn_rarity_color = {
    --Uncommon items (green)
    ["revolver"] = 1,
    ["duel"] = 1,
    ["magic"] = 1,
    ["revolver"] = 1,
    ["pistol"] = 1,
    ["knife"] = 1,
    ["melee"] = 1,
    ["melee2"] = 1,
    --Rare items (blue)
    ["smg"] = 2,
    ["slam"] = 2,
    ["grenade"] = 2,
    --Mythical items (purple)
    ["ar2"] = 3,
    ["shotgun"] = 3,
    --Legendary items (gold)
    ["crossbow"] = 4,
    ["rpg"] = 4
}

hook.Add("Think", "cl_siv_think_hk", function()
    trace_ent = LocalPlayer():GetEyeTrace().Entity

    if trace_ent:IsValid() == true and trace_ent:IsWeapon() == true then
        trace_ent:DrawInfo()
        --chat.AddText(trace_ent)
    end
end)

function mENT:DrawInfo()
    hook.Add("PostDrawOpaqueRenderables", "example", function()
        if self:IsValid() == false then return end
        if self:GetModel() == nil then return end
    
        if self:GetPos() == nil then return end

        local ent_pos = self:GetPos()
        local ply = LocalPlayer()

        local cam_ang = Angle(0, ply:LocalEyeAngles().y - 90, 90)
        local cam_scale = GetConVar("siv_scale"):GetFloat()
        local cam_offset = GetConVar("siv_offset"):GetInt()

        if trace_ent ~= self then return end


        local estimated_dmg = 1

        local wpn_max_clip = 0
        local wpn_ammo_type = "N/A"
        local wpn_slot = 1

        if self:GetMaxClip1() ~= nil then
            wpn_max_clip = self:GetMaxClip1()
        end
    
        if self:GetPrimaryAmmoType() ~= nil then
            wpn_ammo_type = game.GetAmmoName(self:GetPrimaryAmmoType())
        end
    
        if self:GetSlot() ~= nil then
            wpn_slot = self:GetSlot()
        end

        local ply_shootpos = ply:GetShootPos()
        local weapon_pos = self:GetPos()
    
        if (ply_shootpos - weapon_pos):Length() < 165 then
            cam.Start3D2D(ent_pos + Vector(0, 0, cam_offset), cam_ang, 0.15 * cam_scale) --Default scale: 0.15
                surface.SetDrawColor(65, 65, 65, 150)
                surface.DrawRect(ScrW()/-8.53, ScrH()/-21.6, ScrW()/4.27, ScrH()/7.2)
                surface.SetDrawColor(255, 255, 255, 200)
                surface.DrawRect(ScrW()/-8.53, ScrH()/-21.6, ScrW()/4.27, ScrH()/36)

                if wpn_rarity_color[self:GetHoldType()] == 1 then
                    surface.SetDrawColor(120, 250, 100, 255)
                    estimated_dmg = 2
                elseif wpn_rarity_color[self:GetHoldType()] == 2 then
                    surface.SetDrawColor(53, 113, 242, 255)
                    estimated_dmg = 3
                elseif wpn_rarity_color[self:GetHoldType()] == 3 then
                    surface.SetDrawColor(116, 51, 245, 255)
                    estimated_dmg = 4
                elseif wpn_rarity_color[self:GetHoldType()] == 4 then
                    surface.SetDrawColor(245, 185, 64, 255)
                    estimated_dmg = 5
                else
                    surface.SetDrawColor(230, 230, 230, 255)
                end
                surface.DrawRect(ScrW()/-8.53, ScrH()/13.01, ScrW()/4.27, ScrH()/60)

                draw.SimpleText(string.upper(self:GetPrintName()), "siv_fontA", ScrW()/-8.53, ScrH()/-19.64, Color(65, 65, 65, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

                draw.SimpleText("MAX AMMO: " ..wpn_max_clip, "siv_fontB", ScrW()/-8.53, ScrH()/72, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText("AMMO TYPE: " ..tostring(wpn_ammo_type), "siv_fontB", ScrW()/-8.53, ScrH()/-72, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText("SLOT: " ..string.upper(wpn_slot + 1), "siv_fontB", ScrW()/16, ScrH()/-72, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                draw.SimpleText("DMG: " ..estimated_dmg.. "/5", "siv_fontB", ScrW()/16, ScrH()/72, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            cam.End3D2D()
        end
    end)
end