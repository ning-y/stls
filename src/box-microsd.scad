use <modules.scad>;

// The dimensions of a micro SD card
microsd_size = [11, 1, 15];
// The difference between dimensions of the slot and the aforementioned
microsd_tolerance = [1, 0, -2];
// Estimated space between top of a slotted SD card and frame stacked above
microsd_stack_gap = 2;
// Gap for a paper note
paper_size = [1.5, 40, 20];

thickness_wall = 2;
slot_left_margin = 6;
font_size = 5;
font_height = 0.5;

union() {
    difference() {
        // Easier to compute offsets if corner is at 0, 0
        translate([25, 25]) frameallowed();

        // Clearance between a frame stacked above, and the tip of a slotted SD
        // The z-translation is head height minus stacking_height_sans_head_tolerance,
        // minus height of the clearance.
        translate([25, 25, 25-0.5-(microsd_stack_gap-microsd_tolerance[2])])
        linear_extrude(height=microsd_stack_gap-microsd_tolerance[2])
            roundedsquare(size=[46, 46], r=5, center=true);

        // Slot A; the z-translation is the head height minus
        // stacking_height_sans_head_tolerance minus the clearance from the
        // previous statement minus the z-size of the slot.
        translate([
                thickness_wall + slot_left_margin, 
                thickness_wall + 3*46/4 - microsd_size[1],
                25 - 0.5 -
                    (microsd_stack_gap-microsd_tolerance[2]) -
                    (microsd_size + microsd_tolerance)[2]])
            cube(microsd_size+microsd_tolerance);

        // Slot C
        translate([
                thickness_wall + slot_left_margin, 
                thickness_wall + 2*46/4 -microsd_size[1],
                25 - 0.5 -
                    (microsd_stack_gap-microsd_tolerance[2]) -
                    (microsd_size + microsd_tolerance)[2]])
            cube(microsd_size+microsd_tolerance);

        // Slot E
        translate([
                thickness_wall + slot_left_margin, 
                thickness_wall + 46/4 - microsd_size[1],
                25 - 0.5 -
                    (microsd_stack_gap-microsd_tolerance[2]) -
                    (microsd_size + microsd_tolerance)[2]])
            cube(microsd_size+microsd_tolerance);

        // Slot B
        translate([
                thickness_wall + slot_left_margin + 
                    microsd_size[0]+microsd_tolerance[0] + slot_left_margin, 
                thickness_wall + 3*46/4 - microsd_size[1],
                25 - 0.5 -
                    (microsd_stack_gap-microsd_tolerance[2]) -
                    (microsd_size + microsd_tolerance)[2]])
            cube(microsd_size+microsd_tolerance);

        // Slot D
        translate([
                thickness_wall + slot_left_margin + 
                    microsd_size[0]+microsd_tolerance[0] + slot_left_margin,
                thickness_wall + 2*46/4 - microsd_size[1],
                25 - 0.5 -
                    (microsd_stack_gap-microsd_tolerance[2]) -
                    (microsd_size + microsd_tolerance)[2]])
            cube(microsd_size+microsd_tolerance);

        // Slot F
        translate([
                thickness_wall + slot_left_margin +
                    microsd_size[0]+microsd_tolerance[0] + slot_left_margin, 
                thickness_wall + 46/4 - microsd_size[1],
                25 - 0.5 -
                    (microsd_stack_gap-microsd_tolerance[2]) -
                    (microsd_size + microsd_tolerance)[2]])
            cube(microsd_size+microsd_tolerance);

        // Slot for paper
        translate([
                thickness_wall + slot_left_margin + 
                    microsd_size[0]+microsd_tolerance[0] + slot_left_margin +
                    microsd_size[0]+microsd_tolerance[0] + slot_left_margin -
                    paper_size[0],
                thickness_wall + 3,
                25 - 0.5 -
                    (microsd_stack_gap-microsd_tolerance[2]) -
                    (microsd_size + microsd_tolerance)[2]])
        cube(paper_size+microsd_tolerance);
    }

    // Slot A
    translate([
            thickness_wall + slot_left_margin + 
                (microsd_size+microsd_tolerance)[0]/2,
            thickness_wall + 3*46/4 + 1.5*microsd_size[1],
            25-0.5-(microsd_stack_gap-microsd_tolerance[2])])
        linear_extrude(height=font_height)
        text("A", font="Liberation Mono", size=font_size, halign="center");

    // Slot C
    translate([
            thickness_wall + slot_left_margin +
                (microsd_size+microsd_tolerance)[0]/2,
            thickness_wall + 2*46/4 + 1.5*microsd_size[1],
            25-0.5-(microsd_stack_gap-microsd_tolerance[2])])
        linear_extrude(height=font_height)
        text("C", font="Liberation Mono", size=font_size, halign="center");

    // Slot E
    translate([
            thickness_wall + slot_left_margin +
                (microsd_tolerance+microsd_size)[0]/2,
            thickness_wall + 46/4 + 1.5*microsd_size[1],
            25-0.5-(microsd_stack_gap-microsd_tolerance[2])])
        linear_extrude(height=font_height)
        text("E", font="Liberation Mono", size=font_size, halign="center");

    // Slot B
    translate([
            thickness_wall + slot_left_margin +
                microsd_size[0]+microsd_tolerance[0] + slot_left_margin +
                (microsd_size+microsd_tolerance)[0]/2,
            thickness_wall + 3*46/4 + 1.5*microsd_size[1],
            25-0.5-(microsd_stack_gap-microsd_tolerance[2])])
        linear_extrude(height=font_height)
        text("B", font="Liberation Mono", size=font_size, halign="center");

    // Slot D
    translate([
            thickness_wall + slot_left_margin + 
                microsd_size[0]+microsd_tolerance[0] + slot_left_margin +
                (microsd_size+microsd_tolerance)[0]/2,
            thickness_wall + 2*46/4 + 1.5*microsd_size[1],
            25-0.5-(microsd_stack_gap-microsd_tolerance[2])])
        linear_extrude(height=font_height)
        text("D", font="Liberation Mono", size=font_size, halign="center");

    // Slot F
    translate([
            thickness_wall + slot_left_margin + 
                microsd_size[0]+microsd_tolerance[0] + slot_left_margin +
                (microsd_size+microsd_tolerance)[0]/2,
            thickness_wall + 46/4 + 1.5*microsd_size[1],
            25-0.5-(microsd_stack_gap-microsd_tolerance[2])])
        linear_extrude(height=font_height)
        text("F", font="Liberation Mono", size=font_size, halign="center");
}
