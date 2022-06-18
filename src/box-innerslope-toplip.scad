use <modules.scad>;

// Demos
box_sloped_lipped(50, 1*25);
translate([55, 0, 0]) box_sloped_lipped(50, 2*25);
translate([25, 55, 0]) box_sloped_lipped([100, 50], 1*25);
translate([-55, 25, 0]) box_sloped_lipped([50, 100], 1*25);

module box_sloped_lipped(head_size=1*50, head_height=1*25) {
    // - head_size:: a number for length of the sides of the head, or a vector of
    //               two numbers for the breadth (x) and width (y) of the head.

    head_size = head_size[0] == undef ? [head_size, head_size] : head_size;
    body_size = [head_size[0]-4.5, head_size[1]-4.5];
    foot_size = [head_size[0]-6, head_size[1]-6];

    intersection() {
        frameallowed(
            head_size=head_size, head_height=head_height,
            body_size=body_size, foot_size=foot_size);
        union() {
            frame(
                head_size=head_size, head_height=head_height,
                body_size=body_size, foot_size=foot_size);
            // The slope
            translate([0, head_size[1]/2-12.5, 2])
            difference() {
                translate([-head_size[0]/2, -12.5, 0])
                    cube([head_size[0], 25, 25]);
                translate([-head_size[0]/2, -12.5, 25])
                    rotate([0, 90, 0])
                    cylinder(h=head_size[0], r=25);
            }
            // The lip
            translate([-head_size[0]/2, -head_size[1]/2, head_height-0.5-2])
                linear_extrude(height=2)
                roundedsquare([head_size[0], head_size[1]/3], r=[0, 0, 5, 5]);
        }
    }
}
