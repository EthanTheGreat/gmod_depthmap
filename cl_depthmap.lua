local dw = CreateMaterial("_DepthWrite"..math.random(1,1000000), "DepthWrite", {
    ["$no_fullbright"] = "1",
    ["$color_depth"] = "1"
})

local textureRT = GetRenderTargetEx("_rt_depthpro",
    ScrW()/4, ScrH()/4, -- Downsample for higher FPS
    RT_SIZE_NO_CHANGE,
    MATERIAL_RT_DEPTH_SHARED,
    bit.bor(2, 256),
    0,
    24 -- 1 - 8bit, 24 - 16bit, 29 32bit ** Restart Game **
)
local renderMat = CreateMaterial("_rt_depthpro_mat"..math.random(1,1000000), "UnlitGeneric", {
    ["$basetexture"] = textureRT:GetName();
})

hook.Add( "RenderScene", "RenderDepthWrite", function()
	render.PushRenderTarget( textureRT )
    render.Clear(0,0,0,0)
    render.OverrideDepthEnable( true, true ) 
    render.MaterialOverride(dw)
    render.BrushMaterialOverride( dw )
    render.WorldMaterialOverride( dw )
    render.ModelMaterialOverride( dw )

        render.SetShadowColor(0,0,0)
        render.RenderView( ) -- This can be edited to suit shadow depth
        render.SetShadowColor(255,255,255)

    render.MaterialOverride(nil);
    render.BrushMaterialOverride( nil )
    render.WorldMaterialOverride( nil )
    render.ModelMaterialOverride( nil )
    render.OverrideDepthEnable( false, false ) 

	render.PopRenderTarget()
end )
 

-- To Fix Skybox
local min = Vector(1,1,1)*10000;
local max = Vector(1,1,1)*10000;
hook.Add("PostDraw2DSkyBox", "DepthWriteSkybox", function()
    local rt = render.GetRenderTarget()
    if !rt or rt:GetName() != "_rt_depthpro" then  
        return
    end
    local cViewSetup = render.GetViewSetup();

    cam.Start3D( zero_vec, cViewSetup.angles )
    

    render.SetMaterial( dw )
    
    render.DrawBox( vector_origin, angle_zero, max, min, color_white )
    cam.End3D()
end)

-- To Debug Depth Buffer --
local scale = 0.4;
hook.Add("HUDPaint", "debug_view", function()
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(renderMat)
    surface.DrawTexturedRect(0,0,ScrW()*scale,ScrH()*scale)
end )
