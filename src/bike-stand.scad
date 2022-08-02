bike_stand();

module bike_stand(
    width=150, height=180, thickness=10, fn=100,
    gap_wheel_width=50, gap_wheel_height=130,
    gap_interlock_width=15, gap_interlock_height=11) {
        minkowski() {
            sphere(thickness/2, $fn=fn);
            skeleton(
                width=width-thickness, height=height-thickness,
                gap_wheel_width=gap_wheel_width, 
                gap_wheel_height=gap_wheel_height,
                gap_interlock_width=gap_interlock_width+thickness,
                gap_interlock_height=gap_interlock_height+thickness);
        }
}

module skeleton(
        width=100, height=150, thickness=.001,
        gap_wheel_width=50, gap_wheel_height=130,
        gap_interlock_width=15, gap_interlock_height=15) {
    difference() {
        cube([width, height, thickness]);
        translate([(width-gap_wheel_width)/2, height-gap_wheel_height])
            cube([gap_wheel_width, gap_wheel_height, thickness]);
        translate([0, height-2*gap_interlock_height])
            cube([gap_interlock_width, gap_interlock_height, thickness]);
        translate([width-(width-gap_wheel_width)/2, height-2*gap_interlock_height])
            cube([gap_interlock_width, gap_interlock_height, thickness]);
    }
}