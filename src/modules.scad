// In the base: The largest rounded cuboid (in terms of length and width) with
// sides perpendicular to the ground (not-slanted) is called the body. The
// second largest of the same description is the leg. The bottom 2d surface is
// the foot. The trapezoid connecting body to leg is the hip, and the trapezoid
// from hip to foot is the ankle.

module slot(
        mm_length=1*50, mm_width=1*50, mm_radius=5,
        mm_length_body_diff_leg=5, mm_length_leg_diff_foot=1,
        mm_width_body_diff_leg=5, mm_width_leg_diff_foot=1,
        mm_height_leg=3, mm_height_ankle=1, mm_base_thickness=5) {
    difference() {
        linear_extrude(height=mm_height_leg+mm_height_ankle+mm_base_thickness)
        roundedsquare(
            size=[mm_length, mm_width],
            center=true, r=mm_radius);
        translate([0, 0, mm_base_thickness])
        base(
            mm_length=mm_length, mm_width=mm_width,
            mm_height=0, mm_radius=mm_radius,
            mm_length_body_diff_leg=mm_length_body_diff_leg,
            mm_length_leg_diff_foot=mm_length_leg_diff_foot,
            mm_width_body_diff_leg=mm_width_body_diff_leg,
            mm_width_leg_diff_foot=mm_width_leg_diff_foot,
            mm_height_hip=0,
            mm_height_leg=mm_height_leg, mm_height_ankle=mm_height_ankle);
    }
}

module base_hollowed(
        mm_thickness=5,
        mm_length=1*50, mm_width=1*50, mm_height=10, mm_radius=5,
        mm_length_body_diff_leg=5, mm_length_leg_diff_foot=1,
        mm_width_body_diff_leg=5, mm_width_leg_diff_foot=1,
        mm_height_hip=3, mm_height_leg=3, mm_height_ankle=1) {
    difference() {
        base(
            mm_length, mm_width, mm_height, mm_radius,
            mm_length_body_diff_leg, mm_length_leg_diff_foot,
            mm_width_body_diff_leg, mm_width_leg_diff_foot,
            mm_height_hip, mm_height_leg, mm_height_ankle);
        translate([0, 0, mm_thickness])
            base(
                mm_length, mm_width, mm_height, mm_radius,
                mm_length_body_diff_leg, mm_length_leg_diff_foot,
                mm_width_body_diff_leg, mm_width_leg_diff_foot,
                mm_height_hip, mm_height_leg, mm_height_ankle);
    }
}

module base(
        mm_length=1*50, mm_width=1*50, mm_height=10, mm_radius=5,
        mm_length_body_diff_leg=5, mm_length_leg_diff_foot=1,
        mm_width_body_diff_leg=5, mm_width_leg_diff_foot=1,
        mm_height_hip=3, mm_height_leg=3, mm_height_ankle=1) {
    union() {
        // Draws the body
        translate([0, 0, mm_height_ankle+mm_height_leg+mm_height_hip])
        linear_extrude(height=mm_height-mm_height_hip-mm_height_leg-mm_height_ankle)
        roundedsquare(size=[mm_length, mm_width], center=true, r=mm_radius);

        // Draws the hip
        translate([0, 0, mm_height_ankle+mm_height_leg])
        linear_extrude(
            height=mm_height_hip, scale=[
                mm_length / (mm_length - mm_length_body_diff_leg),
                mm_width  / (mm_width  - mm_width_body_diff_leg)])
        roundedsquare(
            size=[mm_length - mm_length_body_diff_leg,
                mm_width  - mm_width_body_diff_leg],
            center=true, r=mm_radius);

        // Draws the leg
        translate([0, 0, mm_height_ankle])
        linear_extrude(height=mm_height_leg)
        roundedsquare(
            size=[mm_length - mm_length_body_diff_leg,
                  mm_width  - mm_width_body_diff_leg],
            center=true, r=mm_radius);

        // Draws the ankle
        linear_extrude(
            height=mm_height_ankle, scale=[
                (mm_length-mm_length_body_diff_leg)/
                    (mm_length-mm_length_body_diff_leg-mm_length_leg_diff_foot),
                (mm_length-mm_length_body_diff_leg)/
                    (mm_length-mm_length_body_diff_leg-mm_length_leg_diff_foot)])
        roundedsquare(
            size=[mm_length - mm_length_body_diff_leg - mm_length_leg_diff_foot,
                  mm_width  - mm_width_body_diff_leg  - mm_width_leg_diff_foot],
            center=true, r=mm_radius);
    }
}

module roundedsquare(size=1, center=false, r=0.5) {
    size = (size[0] == undef) ? [size, size] : size;
    move_by = center ? [-(size[0])/2, -(size[1])/2] : [0, 0];
    translate(move_by) {
        hull() {
            // Top-left corner
            translate([r, r]) circle(r=r);
            // Top-right corner
            translate([size[0]-r, r]) circle(r=r);
            // Bottom-right corner
            translate([size[0]-r, size[1]-r]) circle(r=r);
            // Bottom-left corner
            translate([r, size[1]-r]) circle(r=r);
        }
    }
}
