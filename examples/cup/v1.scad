// Coffee cup (OpenSCAD)
// Parameters
$fn = 120;

cup_outer_r = 35;       // outer radius at rim (mm)
cup_height   = 80;      // cup height (mm)
wall_thick   = 3;       // wall thickness (mm)
bottom_thick = 3.5;     // bottom thickness (mm)
rim_slope    = 2;       // small outward slope at rim (mm)
handle_major = cup_outer_r + 10; // distance from axis to handle center
handle_minor = 5;       // handle tube radius
handle_attach_z = cup_height*0.5; // height of handle center

module cup() {
    // Outer profile (radius, z)
    outer = [
        [cup_outer_r, 0],                     // outer bottom
        [cup_outer_r + rim_slope, cup_height],// outer rim (slightly flared)
        [0, cup_height],
        [0, 0]
    ];

    // Inner profile (hollow)
    inner = [
        [cup_outer_r - wall_thick, bottom_thick],        // inner bottom
        [cup_outer_r - wall_thick, cup_height - 1],      // inner rim (slightly below outer rim)
        [0, cup_height - 1],
        [0, bottom_thick]
    ];

    difference() {
        // outer shell
        rotate_extrude() polygon(points = outer);
        // hollow
        translate([0,0,0]) rotate_extrude() polygon(points = inner);
        // drain a small gap at bottom so bottom_thick remains (prevents a thin lip due to discretization)
        translate([0,0,0]) rotate_extrude() polygon(points = [[cup_outer_r-0.5, 0],[cup_outer_r-0.5, bottom_thick],[0,bottom_thick],[0,0]]);
    }
}

module handle() {
    // Create a torus-like handle by rotating a circle offset from the axis.
    // The 2D circle is in X-Y plane; rotate_extrude around Z gives a torus.
    translate([0,0,handle_attach_z])
        translate([0,0,0])    // keep z translation earlier for clarity
        rotate([90,0,0])      // orient so it sits beside the cup (optional; handled by how we place it below)
        // build torus centered at origin in X-Y plane, then move in X to desired major radius
        // we instead build in X-Y then translate in X when placing the handle
        children();
}

difference() {
    // Combine cup + handle
    union() {
        cup();
        // handle: build a torus by rotating a circle offset in X; then translate it into position.
        translate([0,0,0]) // no-op, clear anchor
            translate([0,0,0]) rotate([0,0,0]) // clarity
            // create torus centered around Z; major radius = handle_major; minor radius = handle_minor
            translate([0,0,handle_attach_z])
                translate([0,0,0]) // anchor
                // To place the torus to the side of the cup, create it with major radius = handle_major,
                // but then shift it slightly in X so it intersects the cup wall and attaches.
                translate([0,0,0])
                union() {
                    // torus (solid)
                    translate([handle_major,0,0]) rotate_extrude() translate([0,0]) circle(r = handle_minor);
                }
    }
    // carve away where handle would pass through cup interior so handle attaches cleanly to outer wall only
    // subtract a slightly smaller torus (inner hollow of handle) so the handle isn't fully solid through the cup
    translate([0,0,0]) {
        // make inner cut to avoid the handle filling the cup interior
        translate([0,0,handle_attach_z])
            difference() {
                // cylinder to remove intersection inside cup (approx)
                translate([0,0,0])
                    rotate_extrude() translate([handle_major,0]) circle(r = handle_minor - 0.8);
                // also subtract the inner part that would overlap with cup hollow
                rotate_extrude() polygon(points = [
                    [cup_outer_r - wall_thick + 0.5, 0],
                    [cup_outer_r - wall_thick + 0.5, cup_height],
                    [0, cup_height],
                    [0, 0]
                ]);
            }
}