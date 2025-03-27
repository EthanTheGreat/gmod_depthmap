local dw = CreateMaterial("_DepthWrite"..math.random(1,1000000), "DepthWrite", {
    ["$no_fullbright"] = "1",
    ["$color_depth"] = "1",
    ["$model"] = "1",
})

local textureRT = GetRenderTargetEx("_rt_depthpro", 
    ScrW(), ScrH(), -- Downsample for higher FPS
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

        render.RenderView() -- This can be edited to suit shadow depth

        render.SetShadowColor(255,255,255)

    render.MaterialOverride(nil);
    render.BrushMaterialOverride( nil )
    render.WorldMaterialOverride( nil )
    render.ModelMaterialOverride( nil )
    render.OverrideDepthEnable( false, false ) 

	render.PopRenderTarget()
end )
 

-- To Fix Skybox
local min = Vector(1,1,1)*16000;
local max = Vector(1,1,1)*16000;
hook.Add("PostDraw2DSkyBox", "DepthWriteSkybox", function()
    local rt = render.GetRenderTarget()
    if !rt or rt:GetName() != "_rt_depthpro" then  
        return
    end
    local cViewSetup = render.GetViewSetup();

    render.SetMaterial( dw )
    render.SetColorMaterial()
    render.DrawScreenQuad();
end)

-- To Debug Depth Buffer --
local scale = 0.4;
hook.Add("HUDPaint", "debug_view", function()
    surface.SetDrawColor(255,255,255,255)
    surface.SetMaterial(renderMat)
    surface.DrawTexturedRect(0,0,ScrW()*scale,ScrH()*scale)
end )

-- Use: +mat_texture_list with top left checkbox marked, click RTs to see the textures at work.
-- Improves depth calculations from 8 to 16 bit, doubling the precision. 
