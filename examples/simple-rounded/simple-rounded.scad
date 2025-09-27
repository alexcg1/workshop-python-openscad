$fn = 100;

cube_size = 20;
hole_diameter = 7;
round_radius = 3;  // radius for top corners

difference() {
    union() {
        // Bottom: plain cube
        translate([0, 0, -round_radius/2])
            cube([cube_size, cube_size, cube_size - round_radius], center=true);
        
        // Top: flat plate + quarter cylinders for rounded corners
        translate([0, 0, cube_size/2 - round_radius])
            union() {
                // Top flat part
                cube([cube_size - 2*round_radius, cube_size, round_radius], center=true);
                cube([cube_size, cube_size - 2*round_radius, round_radius], center=true);

                // Quarter cylinders in each corner
                for (x = [-1, 1], y = [-1, 1]) {
                    translate([x*(cube_size/2 - round_radius), 
                               y*(cube_size/2 - round_radius), 0])
                        cylinder(r=round_radius, h=round_radius, center=true);
                }
            }
    }

    // Hole after rounding
    translate([5, 0, 3])
        rotate([90, 0, 0])
        cylinder(d=hole_diameter, h=cube_size + 2, center=true);
}
