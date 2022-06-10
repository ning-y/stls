use <modules.scad>

union() {
    translate([ 25,  25]) slot();
    translate([-25,  25]) slot();
    translate([ 25, -25]) slot();
    translate([-25, -25]) slot();
}