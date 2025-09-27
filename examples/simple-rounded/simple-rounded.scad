$fn = 100; // resolution

cube_size = 20;
hole_diameter = 7;
rounding = 3;

module rounded_top_front_edge_cube(size, r) {
    // Base cube
    cube(size, center = false);

    // Round top-front edge by subtracting quarter cylinder
    translate([0, size, size - r])
        rotate([90, 0, 0])
            cylinder(r = r, h = r, center = false, $fn = 100);

    // Round top-front edge by subtracting quarter cylinder along Y direction
    translate([r, size - r, size])
        rotate([-90, 90, 0])
            cylinder(r = r, h = r, center = false, $fn = 100);
}

difference() {
    rounded_top_front_edge_cube(cube_size, rounding);

    // Hole (cylinder) shifted right 5 and up 3
    translate([5, 0, 3])
        cylinder(d = hole_diameter, h = cube_size + 1, center = false);
}