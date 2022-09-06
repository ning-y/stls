scoop();

module scoop() {
    difference() {
        translate([-16, 0, 33]) handle();
        hull() {cup();}
        translate([18, -4, 35.5]) 
            linear_extrude(1) text("15g", font="Liberation Mono");
    }
    cup();
}

// To be consistent with module cup, the radius, height, and length arguments do not
// consider thickness, i.e. true printed height if height=3 and thickness=1 is 4.
module handle(radius=16, height=3, length=64, thickness=1, fn_big=50, fn_small=10) {
    minkowski() {
        sphere(d=thickness, $fn=fn_small);
        translate([radius, 0, 0])
        linear_extrude(height)
            hull() {
                circle(r=radius, $fn=fn_big);
                translate([length-2*radius, 0, 0]) circle(r=radius, $fn=fn_big);
            }
    }
}

// The /skeleton/ of the cup's bottom face is at z=0; i.e. the actual printed bottom
// face of the cup is at z = -thickness/2. The radius refers to the radius of the
// skeleton, as does the height.
module cup(
        radius=16, height=38, hole_radius=1, 
        thickness=1, fn_big=50, fn_small=10) {
    difference() {
        translate([-radius, 0, height])
            minkowski() {
                sphere(d=thickness, $fn=fn_small);
                translate([radius, 0, -height])
                    skeleton_cup(radius=radius, height=height, fn=fn_big);
        }
        translate([0, 0, -thickness])
                cylinder(h=2*thickness, r=hole_radius, $fn=fn_small);
    }
}

module skeleton_cup(radius=16, height=38, thickness=0.001, fn=50) {
    difference() {
        cylinder(h=height, r=radius, $fn=fn);
        translate([0, 0, thickness])
            cylinder(h=height, r=radius-thickness, $fn=fn);
    }
}