calibration_axes();

module calibration_axes(side=150, thickness=10, text_height=2, text_size=7) {
    // X-axis
    difference() {
        cube([side, thickness, thickness]);
        translate([
                side/2-text_size/2,
                (thickness-text_size)/2,
                thickness-text_height])
            linear_extrude(text_height)
            text("X", size=text_size);
    }
    // Y-axis
    difference() {
        translate([thickness, 0, 0])
            rotate([0, 0, 90])
            cube([side, thickness, thickness]);
        translate([
                (thickness-text_size)/2,
                side/2-text_size/2,
                thickness-text_height])
            linear_extrude(text_height)
            text("Y", size=text_size);
    }
    // Z-axis
    difference() {
        translate([thickness, 0, 0])
            rotate([0, -90, 0])
            cube([side, thickness, thickness]);
        translate([
                (thickness-text_size)/2,
                (thickness-text_size)/2,
                side-text_height])
            linear_extrude(text_height)
            text("Z", size=text_size);
    }
}