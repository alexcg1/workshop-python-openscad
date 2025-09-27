![](./images/title.png)

```python
title_text = text(text="Python for 3D Design")

title_text.save_as_scad("title.scad")
```

---

## Background

- Python developer - 10+ years
- Used lots of 3D design software - Rhino, Fusion360, FreeCAD (a bit)
- More of a programmer than a designer
- I live in my text editor
- Building animatronic butterfly jewelry project

---

## OpenSCAD: why I started using it

[OpenSCAD](https://openscad.org/) is a free CAD tool where you program your models instead of drawing them.

- **Open source** - no lock-in or licensing issues (I'm looking at you, Autodesk)
- **Works in text editor** - that's where I live
- **Can store stuff in git** - version control and remote storage
- **Programming-focused, rather than visual**

![](./images/openscad.png)

---

## Example

![](./images/simple/simple.png)

```scad
$fn = 100; // set cylinder resolution globally

// Cube with a hole along the Y-axis, cylinder shifted directly in translate
cube_size = 20;
hole_diameter = 7;

// Subtract cylindrical hole
difference() {
    cube(cube_size, center=true);
    translate([5, 0, 3])  // X=5, Y=0, Z=3
        rotate([90,0,0])  // align cylinder along Y-axis
        cylinder(d=hole_diameter, h=cube_size + 1, center=true);
}
```

---

## Can I round the top of the cube?

OpenSCAD doesn't support rounding out of the box. But how hard can it be?

### What I want

![](./images/simple-rounded/bosl.png)

### What I get

GPT to the rescue?

| Attempt 1                               | Attempt 2                               | Attempt 3                               |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| ![](./images/simple-rounded/fail-1.png) | ![](./images/simple-rounded/fail-2.png) | ![](./images/simple-rounded/fail-3.png) |

### Code from attempt 3

```scad
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
```

Phew, that's a lot of code that doesn't even work!

---

## Enter BOSL2

[Belfry OpenSCAD Library v2](https://github.com/BelfrySCAD/BOSL2) extends OpenSCAD with:

- Rounding and filleting
- Shorthands - `up(3)` instead of `translate([0, 0, 3]`)
- Parts library - screws, threads, gears, hinges, clips
- And much more

---

## Rounding the cube with BOSL2

![](./images/simple-rounded/bosl.png)

```scad[11, 13-15]
include <BOSL2/std.scad>;

$fn = 100; // global resolution

cube_size = 20;
hole_diameter = 7;
rounding = 3;

difference() {
    // Round top-front edge only
    cuboid([cube_size, cube_size, cube_size], rounding=rounding, edges=[TOP]);

    right(5)
        up(3)
            ycyl(d=hole_diameter, h=cube_size + 1);
}
```

---

## Why I (sorta) stopped using OpenSCAD

I mean, I use it more indirectly now, which we'll go over later

- **Limited functionality** - no chamfering, filleting, etc
- **Unintuitive** - thinking in terms of X/Y/Z axes plus positive/negative movement hurts my brain
- **Verbose** - it's difficult to keep track of where I am in the file since there's so much stuff

---

## Enter SolidPython

[SolidPython](https://github.com/jeff-dh/SolidPython) is a Python frontend for solid modelling that compiles to OpenSCAD.

> [!TIP]
> Be sure to get **SolidPython2** (not `master` branch)

![](./images/simple-rounded-bosl.png)

```python

```
