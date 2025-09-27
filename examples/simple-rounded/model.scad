include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/version.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/constants.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/transforms.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/distributors.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/miscellaneous.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/color.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/attachments.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/beziers.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/shapes3d.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/shapes2d.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/drawing.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/masks3d.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/masks2d.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/math.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/paths.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/lists.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/comparisons.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/linalg.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/trigonometry.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/vectors.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/affine.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/coords.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/geometry.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/regions.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/strings.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/vnf.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/structs.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/rounding.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/skin.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/utility.scad>;
include </home/alexcg/personal/repos/xhain/python-openscad/.venv/lib/python3.13/site-packages/solid2/extensions/bosl2/BOSL2/partitions.scad>;

$fn = 100;

difference() {
	cuboid(edges = TOP, rounding = 3, size = 20);
	up(z = 3) {
		right(x = 5) {
			ycyl(d = 7, l = 20);
		}
	}
}
