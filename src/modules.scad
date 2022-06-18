// Demos
frame(50, 1*25);
translate([55, 0, 0]) frame(50, 2*25);
translate([25, 55, 0]) frame(
        head_size=[100, 50], head_height=1*25,
        body_size=[100-4.5, 50-4.5], foot_size=[100-6, 50-6]);
translate([-55, 25, 0]) frame(
        head_size=[50, 100], head_height=1*25,
        body_size=[50-4.5, 100-4.5], foot_size=[50-6, 100-6]);

module frameallowed(
        head_size=50, head_height=25, neck_height=2, body_size=45.5, body_height=2,
        leg_height=1, foot_size=44, r=5, fn=30, really_small_number=0.001,
        thickness=2, stacking_body_size_tolerance=0.5,
        stacking_height_sans_head_tolerance=0.5) {
    // Use this for an intersect, to trim protruding elements.

    head_size = head_size[0] == undef ? [head_size, head_size] : head_size;
    body_size = body_size[0] == undef ? [body_size, body_size] : body_size;
    foot_size = foot_size[0] == undef ? [foot_size, foot_size] : foot_size;

    union() {
        frame(
            head_size=head_size, head_height=head_height, neck_height=neck_height,
            body_size=body_size, body_height=body_height, leg_height=leg_height,
            foot_size=foot_size, r=r, fn=fn, 
            really_small_number=really_small_number,
            thickness=thickness, 
            stacking_body_size_tolerance=stacking_body_size_tolerance,
            stacking_height_sans_head_tolerance=stacking_height_sans_head_tolerance);
        framefilled(
            head_size=head_size,
            head_height=head_height-neck_height-body_height-leg_height-
                stacking_height_sans_head_tolerance,
            neck_height=neck_height, body_size=body_size,
            body_height=body_height, leg_height=leg_height,
            foot_size=foot_size, r=r, fn=fn, 
            really_small_number=really_small_number);
    }
}

module frame(
        head_size=50, head_height=25, neck_height=2, body_size=45.5, body_height=2,
        leg_height=1, foot_size=44, r=5, fn=30, really_small_number=0.001,
        thickness=2, stacking_body_size_tolerance=0.5,
        stacking_height_sans_head_tolerance=0.5) {

    head_size = head_size[0] == undef ? [head_size, head_size] : head_size;
    body_size = body_size[0] == undef ? [body_size, body_size] : body_size;
    foot_size = foot_size[0] == undef ? [foot_size, foot_size] : foot_size;

    difference() {
        framefilled(
            head_size=head_size, head_height=head_height, neck_height=neck_height,
            body_size=body_size, body_height=body_height, leg_height=leg_height,
            foot_size=foot_size, r=r, fn=fn, 
            really_small_number=really_small_number);
        translate([0, 0, thickness])
            framefilled(
                head_size=[head_size[0]-2*thickness, head_size[1]-2*thickness],
                head_height=head_height-thickness,
                neck_height=neck_height,
                body_size=[body_size[0]-2*thickness, body_size[1]-2*thickness],
                body_height=body_height, leg_height=leg_height,
                foot_size=[foot_size[0]-2*thickness, foot_size[1]-2*thickness],
                r=r, fn=fn, really_small_number=really_small_number);
        translate([0, 0, head_height-stacking_height_sans_head_tolerance])
            framefilled(
                head_size=head_size, head_height=head_height,
                neck_height=neck_height,
                body_size=[
                    body_size[0]-2*stacking_body_size_tolerance,
                    body_size[1]-2*stacking_body_size_tolerance],
                body_height=body_height, leg_height=leg_height,
                foot_size=[
                    foot_size[0]-2*stacking_body_size_tolerance,
                    foot_size[1]-2*stacking_body_size_tolerance],
                r=r, fn=fn, really_small_number=really_small_number);
    }
}

// NB the body size must be slightly smaller than head_size minus twice
// the thickness, so that the frames can stack.
module framefilled(
        head_size=50, head_height=25, neck_height=2, body_size=45.5, body_height=2,
        leg_height=1, foot_size=44, r=5, fn=30, really_small_number=0.001) {

    head_size = head_size[0] == undef ? [head_size, head_size] : head_size;
    body_size = body_size[0] == undef ? [body_size, body_size] : body_size;
    foot_size = foot_size[0] == undef ? [foot_size, foot_size] : foot_size;

    union() {
        hull() {head(); crown();}
        hull() {body(); head();}
        hull() {leg(); body();}
        hull() {foot(); leg();}
    }

    module crown() {
        translate(
            [0, 0, leg_height+body_height+neck_height+head_height-really_small_number])
        linear_extrude(height=really_small_number)
            roundedsquare(head_size, r=r, center=true, $fn=fn);
    }

    module head() {
        translate([0, 0, leg_height+body_height+neck_height])
        linear_extrude(height=really_small_number)
            roundedsquare(head_size, r=r, center=true, $fn=fn);
    }

    module body() {
        translate([0, 0, leg_height+body_height-really_small_number])
        linear_extrude(height=really_small_number)
            roundedsquare(body_size, r=r, center=true, $fn=fn);
    }

    module leg() {
        translate([0, 0, leg_height])
        linear_extrude(height=really_small_number)
            roundedsquare(body_size, r=r, center=true, $fn=fn);
    }

    module foot() {
        linear_extrude(height=really_small_number)
            roundedsquare(foot_size, r=r, center=true, $fn=fn);
    }
}

module roundedsquare(
        size=1, r=0.5, center=false, fn=30, really_small_number=0.001) {
    // Draw a square or rectangle with rounded corners.
    //
    // - size :: a number for length of the sides of a square, or a vector of
    //           two numbers for the width and height of a rectangle.
    // - r :: a number for radius of the rounded corners, or a vector of four
    //        numbers for the radii of of the top-right, top-left, bottom-left,
    //        and bottom-right rounded corners respectively (top and right are
    //        the positive y and x directions respectively); 0 indicates that
    //        a corner should not be rounded
    // - center :: boolean indicating if the shape should be centered
    // - fn :: the $fn parameter for circles, used for all rounded corners
    // - really_small_number :: a number which is effectively zero but not
    //                          actually zero; used internally to draw points

    size = size[0] == undef ? [size, size] : size;
    r = r[0] == undef ? [r, r, r, r] : r;

    translate(center ? [-size[0]/2, -size[1]/2] : [0, 0])
        hull() {
            // Top-right corner
            if (r[0] == 0) {
                translate(
                        [size[0]-really_small_number,
                         size[1]-really_small_number])
                    square(really_small_number);
            } else {
                translate([size[0]-r[0], size[1]-r[0]])
                    circle(r=r[0], $fn=fn);
             }
             // Top-left corner
            if (r[1] == 0) {
                translate([0, size[1]-really_small_number])
                    square(really_small_number);
            } else {
                translate([r[1], size[1]-r[1]])
                    circle(r=r[1], $fn=fn);
             }
             // Bottom-left corner
            if (r[2] == 0) {
                translate([0, 0])
                    square(really_small_number);
            } else {
                translate([r[2], r[2]])
                    circle(r=r[2], $fn=fn);
             }
             // Bottom-right corner
             if (r[3] == 0) {
                translate([size[0]-really_small_number, 0])
                    square(really_small_number);
            } else {
                translate([size[0]-r[3], r[3]])
                    circle(r=r[3], $fn=fn);
             }
         }
}
