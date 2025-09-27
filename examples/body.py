# from solid2 import set_global_fn
from solid2.extensions.bosl2 import *

from helper import get_name

NAME = get_name()

anchor = FRONT
shell_thickness = 0.8


class Padding:
    loose = 0.4
    tight = 0.2
    snug = 0.25


class Rod:
    """
    Defines size of rod holes. Wings attach to rods
    """

    diameter = 2.1
    padding = Padding.loose
    distance = 5.4  # distance between rod holes
    y = 22  # add extra padding for testing


class Body:
    """
    Overall body dimensions
    """

    x = 4 + Rod.distance + (Rod.diameter + Rod.padding) * 2
    y = 43
    z = 10
    z_offset = 1.6  # move body down so magnets fit nicer
    rounding = 3


class Motor:
    """
    Defines size of motor hole. Motor drives a geared rod
    """

    diameter = 6 + Padding.tight
    y = 34.8


class GlueCavity:
    """
    Place to apply glue to attach motor to body
    """

    x = 4
    y = 10
    z = 1
    rounding = 0.5


class Gearbox:
    """
    Defines where gears go. Gears move rods, which move wings
    """

    x = Body.x - (shell_thickness * 2)
    y = 12
    z = Body.z - 1


# class Gear:
#     """
#     Defines gear stuff. Reciprocal motion happens through gears meshing
#     """

#     thickness = 3.8


class Magnet:
    """
    Defines magnet holes, for attachment to clothing etc
    """

    x = 10 + Padding.snug
    y = 5.4
    z = 1.4
    distance = 30  # distance between magnets


class RodCoverSlot:
    """
    Cover to stop free rod running away or shaking. Cover slots into body
    """

    x = 1
    y = 6
    z = 4
    padding = Padding.tight
    # distance = 10


class WingStop:
    """
    Prevents wing from angling too low and hitting what's below
    """

    x = 0.8
    y = 6
    z = 1.8
    rounding = 0.4


motor_rod_hole = teardrop(d=Rod.diameter + Rod.padding, h=Rod.y, anchor=anchor).left(
    Rod.distance / 2
)
free_rod_hole = motor_rod_hole.right(Rod.distance)

# motor hole
motor_hole = (
    ycyl(d=Motor.diameter, h=Motor.y + 2, anchor=anchor)
    .left(Rod.distance / 2)
    .forward(12)
)


gearbox = cuboid([Gearbox.x, Gearbox.y, Gearbox.z], anchor=anchor).forward(1).up(0.6)

# chop off top and top bit of front
top_chopper = cuboid([Body.x, Body.y, 5], anchor=anchor).up(2.6).forward(1)
front_chopper = cuboid([Body.x, 3, 4], anchor=anchor).up(4)

# main body block
body = cuboid(
    [Body.x, Body.y, Body.z + Body.z_offset],
    anchor=anchor,
    rounding=Body.rounding,
    edges=[TOP + LEFT, TOP + RIGHT, BOTTOM],
).down(Body.z_offset / 2)

# wing stops
wing_stop_left = (
    cuboid(
        [WingStop.x, WingStop.y, WingStop.z],
        rounding=WingStop.rounding,
        edges=[TOP + FRONT, TOP + BACK],
        anchor=BOTTOM + FRONT,
    )
    .left((Body.x / 2) - 0.4)
    .forward(4)
    .up(0.1)
)

wing_top_right = wing_stop_left.right(Body.x - 0.8)

rod_cover_slot = (
    cuboid(
        [
            RodCoverSlot.x + RodCoverSlot.padding,
            RodCoverSlot.y + RodCoverSlot.padding,
            RodCoverSlot.z + RodCoverSlot.padding,
        ]
    )
    .forward(17.6)
    .right(5.5)
    .down(1)
)

glue_cavity = (
    cuboid([GlueCavity.x, GlueCavity.y, GlueCavity.z], rounding=GlueCavity.rounding)
    .left(Rod.distance / 2)
    .forward(34)
    .down(3.2)
)

magnet_hole_front = (
    cuboid([Magnet.x, Magnet.y, Magnet.z], anchor=anchor)
    .forward(3.5)
    .down(((Body.z + Body.z_offset) / 2) + 0.2)
)

magnet_hole_back = magnet_hole_front.forward(Magnet.distance)

model = (
    body
    - motor_rod_hole
    - free_rod_hole
    - top_chopper
    - motor_hole
    - gearbox
    + wing_stop_left
    + wing_top_right
    - rod_cover_slot
    - glue_cavity
    - magnet_hole_front
    - magnet_hole_back
    - front_chopper
)

if __name__ == "__main__":
    model.save_as_scad(f"../scad/{NAME}.scad")

    stl_filename = f"../stl/{NAME}.stl"
    model.save_as_stl(stl_filename)
