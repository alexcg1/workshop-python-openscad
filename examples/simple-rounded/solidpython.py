from solid2.extensions.bosl2 import cuboid, ycyl, TOP
from solid2 import set_global_fn

set_global_fn(100)

cube_size = 20
hole_diameter = 7
rounding = 3

cube = cuboid(cube_size, rounding=rounding, edges=TOP)
hole = ycyl(d=hole_diameter, l=cube_size).right(5).up(3)

model = cube - hole

model.save_as_scad("model.scad")