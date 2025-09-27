use <BOSL2/std.scad>;

$fn = 100; // global resolution

// Cube with a hole along the Y-axis, cylinder shifted using BOSL2 helpers
cube_size = 20;
hole_diameter = 7;

difference() {
    cube(cube_size, center=true);
    right(5)
        up(3)
            ycyl(d=hole_diameter, h=cube_size + 1);
}