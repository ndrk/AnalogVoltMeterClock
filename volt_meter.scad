// Analog Volt Meter Dimensions
METER_FLANGE_DIAMETER = 88;
METER_FLANGE_THICKNESS = 4;
METER_BODY_DIAMETER = 69;
METER_BODY_DEPTH = 40;
METER_HOLE_DIAMETER = 3.5;
METER_SCREW_HOLE_DIAMETER = 2;
METER_SCREW_HOLE_DEPTH = 10;
METER_HOLE_OFFSET = METER_FLANGE_DIAMETER/2-5;
METER_FACE_DIAMETER = 62;
METER_FACE_DEPTH = 4;


module createMeter(X, Y, Z) {
  translate([X,Y,Z])
    difference() {
        union() {
            color("White")
                difference() {
                    translate([0,0,METER_FACE_DEPTH])
                        cylinder(d=METER_FACE_DIAMETER, h=METER_FACE_DEPTH);
                    translate([-METER_FACE_DIAMETER/2,-METER_FACE_DIAMETER/2-7,METER_FACE_DEPTH-2])
                        cube([METER_FACE_DIAMETER,METER_FACE_DIAMETER/3,METER_FACE_DEPTH+4], false);
                }
            color("Black")
                cylinder(d=METER_FLANGE_DIAMETER, h=METER_FLANGE_THICKNESS);
            color("Black")
                translate([0,0,-METER_BODY_DEPTH])
                    cylinder(d=METER_BODY_DIAMETER, h=METER_BODY_DEPTH);
        }

        rotate([0,0,0])
            translate([0,METER_HOLE_OFFSET,-1])
                cylinder(d=METER_HOLE_DIAMETER, h=METER_FLANGE_THICKNESS+2);

        rotate([0,0,120])
            translate([0,METER_HOLE_OFFSET,-1])
                cylinder(d=METER_HOLE_DIAMETER, h=METER_FLANGE_THICKNESS+2);

        rotate([0,0,-120])
            translate([0,METER_HOLE_OFFSET,-1])
                cylinder(d=METER_HOLE_DIAMETER, h=METER_FLANGE_THICKNESS+2);
    }
}
