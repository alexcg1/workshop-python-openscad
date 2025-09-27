$fn = 120;

// Parameters
cup_outer_r = 35;      // outer radius at rim (mm)
cup_height   = 80;     // cup height (mm)
wall_thick   = 3;      // wall thickness (mm)
bottom_thick = 3.5;    // bottom thickness (mm)
rim_slope    = 2;      // small outward slope at rim (mm)
handle_major = cup_outer_r + 10; // distance from axis to handle center
handle_minor = 5;      // handle tube radius
handle_attach_z = cup_height * 0.5; // height of handle center

// Cup body
module cup() {
    difference() {
        // Outer shape
        rotate_extrude()
            polygon([
                [cup_outer_r, 0],
                [cup_outer_r + rim_slope, cup_height],
                [0, cup_height],
                [0, 0]
            ]);

        // Inner hollow
        rotate_extrude()
            polygon([
                [cup_outer_r - wall_thick, bottom_thick],
                [cup_outer_r - wall_thick, cup_height - 1],
                [0, cup_height - 1],
                [0, bottom_thick]
            ]);
    }
}

// Handle as a torus segment
module handle() {
    translate([0, 0, handle_attach_z])
        rotate_extrude(angle = 200)  // only part of a circle for the handle
            translate([handle_major, 0])
                circle(r = handle_minor);
}

// Final assembly
cup();
handle();