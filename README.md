# Garry's Mod DepthMap

# Summary:
This leverages RenderTargets for higher detailed depth (8, 16 and 32bit). This can result in much higher detail depth.
This lua file solely uses DepthWrite as a shader to provide accurate results into the rendertarget.

This can be helpful for shader graphics as well.

**Issues/Tradeoffs:**
It may have unexpected results for map decals, SetSubMaterial objects, lighting & effects due to the way rendered here.
These may never be resolved due to the complexity of the rendering process. Still provides better detail

![image](https://github.com/user-attachments/assets/c1a07904-416f-48ca-b191-a5d10624f93f)

# License

## MIT License with Attribution Requirement  

© 2025 - EthanTheGreat 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, subject to the following conditions:  

### Attribution Requirement  
Any derivative works, copies, or distributions of this Software must include the following citation within the source code:  

```plaintext
This software includes code developed by EthanTheGreat.
