from solid2 import *
from solid2.utils import *

# Define cup dimensions
body_radius = 50
body_height = 100
handle_radius = 20
handle_thickness = 10

# Create the cup body
body = cylinder(r=body_radius, h=body_height)

# Create the handle
handle = torus(r1=handle_radius, r2=handle_radius - handle_thickness)

# Position the handle appropriately
handle = translate([body_radius + handle_radius, body_height / 2, body_height / 2])(handle)

# Subtract the handle from the body to form the mug
mug = body + handle

# Render to OpenSCAD code
scad_code = scad_render(mug)
print(scad_code)