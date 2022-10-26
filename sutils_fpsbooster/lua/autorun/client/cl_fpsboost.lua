CreateClientConVar( "fpsboost_hidemenu", "0", true, false )

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
local x, y = panel:LocalToScreen(0, 0)
local scrW, scrH = ScrW(), ScrH()
surface.SetDrawColor(255, 255, 255)
surface.SetMaterial(blur)
for i = 1, 3 do
	blur:SetFloat("$blur", (i / 3) * (amount or 6))
	blur:Recompute()
	render.UpdateScreenEffectTexture()
	surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

surface.CreateFont( "FPSFont", {
		extended = false,
		bold = true,
		font = "DebugFixed",
		size = 20,
		weight = 500,
		antialias = true
	} )

	local function fpsboost()
		local ply = LocalPlayer()
		local FPSMenu = vgui.Create( "DFrame" )
		FPSMenu:SetTitle( "SUtils FPS Booster By Inco Dev Group" )
		FPSMenu:SetSize( 0, 0 )
		FPSMenu:SetPos(ScrW()/2-150, ScrH()/2-60 )
		FPSMenu:MakePopup()
		FPSMenu:ShowCloseButton(false)
		FPSMenu:SetDraggable(false)
		FPSMenu:SizeTo( 300, 130, .5, 0, 10)
		FPSMenu.Paint = function( self, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, Color( 0, 0, 0, 150 ) ) 
			draw.RoundedBox( 6, 5, 5, w-10, h-10, Color( 10, 10, 10, 100 ) ) 
			DrawBlur(self, 3)
		end
		
		local FpsText = vgui.Create( "DLabel", FPSMenu )
		FpsText:SetPos( 70, 55 )
		FpsText:SetText( "Enable FPS Booster?" )
		FpsText:SetTextColor( Color( 255, 255, 255 ) )
		FpsText:SetFont("FPSFont")
		FpsText:SizeToContents()
		
		local EnableButton = vgui.Create( "DButton", FPSMenu )
		EnableButton:SetText( "Yes, Please!" )
		EnableButton:SetTextColor( Color( 255, 255, 255 ) )
		EnableButton:SetPos( 55, 85 )
		EnableButton:SetSize( 90, 30 )
		EnableButton.Paint = function( self, w, h )	
			if EnableButton:IsHovered() then
				draw.RoundedBox( 4, 0, 0, w, h, Color( 150, 200, 150, 120 ) ) 
			else
				draw.RoundedBox( 4, 0, 0, w, h, Color( 128, 200, 128, 120 ) ) 
			end
		end
		EnableButton.DoClick = function() 
			surface.PlaySound("buttons/button15.wav") 
			local ply = LocalPlayer()
				ply:ChatPrint( "[FPSBooster] Menu Will No Longer Appear. Change this via console variable 'fpsboost_hidemenu'." )
				ply:ChatPrint( "[FPSBooster] Crashing Or Worse FPS? Use Console Command 'fpsboost_undo'." )
				ply:ConCommand("mat_queue_mode 2")
				ply:ConCommand("gmod_mcore_test 1")
				ply:ConCommand("cl_threaded_bone_setup 1")
				ply:ConCommand("cl_threaded_client_leaf_system 1")
				ply:ConCommand("r_threaded_client_shadow_manager 1")
				ply:ConCommand("r_threaded_particles 1")
				ply:ConCommand("r_threaded_renderables 1")
				ply:ConCommand("r_queued_ropes 1")
				ply:ConCommand("menu_cleanupgmas")
				ply:ConCommand("M9KGasEffect 0")
				ply:ConCommand("fas2_blureffects 0")
				ply:ConCommand("fas2_headbob_intensity 0")
				ply:ConCommand("fpsboost_hidemenu 1")
				FPSMenu:Remove()
		end

		local NoButton = vgui.Create( "DButton", FPSMenu ) 
		NoButton:SetText( "No, I Like Lag." )
		NoButton:SetTextColor( Color( 255, 255, 255 ) )
		NoButton:SetPos( 150, 85 )
		NoButton:SetSize( 90, 30 )
		NoButton.Paint = function( self, w, h )
			if NoButton:IsHovered() then
				draw.RoundedBox( 4, 0, 0, w, h, Color( 200, 150, 150, 120 ) ) 
			else
				draw.RoundedBox( 4, 0, 0, w, h, Color( 200, 128, 128, 120 ) ) 
			end
		end
		NoButton.DoClick = function()
			local ply = LocalPlayer()
			ply:ChatPrint( "[FPSBooster] Menu Will No Longer Appear. Change this via console variable 'fpsboost_hidemenu'." )
			surface.PlaySound("buttons/button15.wav") 
			ply:ConCommand("fpsboost_hidemenu 1")
			FPSMenu:Remove()
		end
	end

net.Receive("OpenMenuCheck", function()
	local ply = LocalPlayer()
	local showmenu = ply:GetInfoNum( "fpsboost_hidemenu", 0 )
	if(showmenu >= 1) then return end
	fpsboost()
end)

concommand.Add( "fpsboost_undo", function()
	local ply = LocalPlayer()
	ply:ChatPrint( "[FPSBooster] FPS Boost Settings Reset..." )
	ply:ConCommand("mat_queue_mode 1")
	ply:ConCommand("gmod_mcore_test 0")
	ply:ConCommand("cl_threaded_bone_setup 0")
	ply:ConCommand("cl_threaded_client_leaf_system 0")
	ply:ConCommand("r_threaded_client_shadow_manager 0")
	ply:ConCommand("r_threaded_particles 0")
	ply:ConCommand("r_threaded_renderables 0")
	ply:ConCommand("r_queued_ropes 0")
	ply:ConCommand("M9KGasEffect 1")
	ply:ConCommand("fas2_blureffects 1")
	ply:ConCommand("fas2_headbob_intensity 1")
	ply:ConCommand("fpsboost_hidemenu 0")
end)