use <modules.scad>;

// Demos
translate([5, 5]) grid(3, 2);
translate([-105, 5]) grid(2, 3);
translate([-105, -55]) grid(2, 1);
translate([5, -105]) grid(2, 2);

module grid(n, m) {
    union() {
        for (i = [0 : n-1]) {
            for (j = [0 : m-1]) {
                translate([i*50, j*50]) grid_leftbot_align();
            }
        }
    }
}

module grid_leftbot_align() {
    difference() {
        translate([25, 25]) frameallowed(head_height=7.5); 
        translate([0, 0, 5 + 7.5 - 2]) linear_extrude(height=2)
            roundedsquare(size=50, r=5);
    }
}
