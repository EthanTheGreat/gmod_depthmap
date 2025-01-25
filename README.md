# Garry's Mod DepthMap

# Summary:
This leverages RenderTargets for higher detailed depth (8, 16 and 32bit). This can result in much higher detail depth.
This lua file solely uses DepthWrite as a shader to provide accurate results into the rendertarget.

This can be helpful for shader graphics as well.

**Issues/Tradeoffs:**
It may have unexpected results for map decals, SetSubMaterial objects, lighting & effects due to the way rendered here.
These may never be resolved due to the complexity of the rendering process. Still provides better detail
