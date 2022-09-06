cable_clip();

module cable_clip(length=50, width=30, height=20, gap=12, thickness=2, fn=50) {
    minkowski() {
        sphere(d=2, $fn=fn);
        skeleton(
            length=length-thickness, width=width-thickness, height=height-thickness,
            gap=gap-thickness);
    }
}

module skeleton(length, width, height, gap, basically_zero=0.001) {
    union() {
        cube([length, width, basically_zero]);
        cube([length, basically_zero, height]);
        translate([0, width])
            difference() {
                cube([length, basically_zero, height]);
                cube([length, basically_zero, gap]);
            }
        translate([0, 0, height])
            cube([length, width, basically_zero]);
    }
}