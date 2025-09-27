![](./images/title.png)

```python
title_text = text(text="Python for 3D Design")

title_text.save_as_scad("title.scad")
```

---

## Contents

- OpenSCAD: why I (kinda) use it
- Supercharging OpenSCAD with BOSL2
- Supersupercharging OpenSCAD with SolidPython2
- Example part
- What can't it do?
- Can I use an LLM to generate 3D objects?
- Q + A

---

# OpenSCAD: why I started using it

[OpenSCAD](https://openscad.org/) is a free CAD tool where you program your models instead of drawing them.

- **Open source** - no lock-in or licensing issues (I'm looking at you, Autodesk)
- **Works in text editor** - that's where I live
- **Can store stuff in git** - version control and remote storage

![](./images/openscad.png)

---

![](./images/simple.png)

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

# Can I round the top of the cube?

How hard can it be?

Too hard for me and ChatGPT apparently

---

# Enter BOSL2

[Belfry OpenSCAD Library v2](https://github.com/BelfrySCAD/BOSL2)

Extends OpenSCAD with:

- Rounding and filleting
- Shorthands - `up(3)` instead of `translate([0, 0, 3]`)
- Parts library - screws, threads, gears, hinges, clips
- And much more

---

# Image

![](./images/simple-rounded-bosl.png)

---

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

<!--s-->
<!--s-->

# Why I (sorta) stopped using it

I mean, I use it more indirectly now, which we'll go over later

- **Limited functionality** - no chamfering, filleting, etc
- **Unintuitive** - thinking in terms of X/Y/Z axes plus positive/negative movement hurts my brain
- **Verbose** - it's difficult to keep track of where I am in the file since there's so much stuff
