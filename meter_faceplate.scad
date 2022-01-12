FACE_DIAMETER = 61;
LINE_WIDTH = 0.5;

SCALE_ARC_RADIUS = 30;
SCALE_ARC_OFFSET = 18;
SCALE_ARC_DEGREES = 90;
SCALE_ARC_ANGLES = [180-SCALE_ARC_DEGREES/2, SCALE_ARC_DEGREES/2];
SCALE_MARKER_LENGTH = 5;

MOUNT_HOLE_DIAMETER = 2;
MOUNT_HOLE_OFFSET = 10;
MOUNT_HOLE_SEPARATION = 30;

$fn=100;

// Ya, this isn't elegant. Deal with it! :-)
hourMarkers = [
  ["0", SCALE_ARC_ANGLES[0]-0*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-1*(SCALE_ARC_DEGREES/12)-90],
  ["2", SCALE_ARC_ANGLES[0]-2*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-3*(SCALE_ARC_DEGREES/12)-90],
  ["4", SCALE_ARC_ANGLES[0]-4*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-5*(SCALE_ARC_DEGREES/12)-90],
  ["6", SCALE_ARC_ANGLES[0]-6*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-7*(SCALE_ARC_DEGREES/12)-90],
  ["8", SCALE_ARC_ANGLES[0]-8*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-9*(SCALE_ARC_DEGREES/12)-90],
  ["10", SCALE_ARC_ANGLES[0]-10*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-11*(SCALE_ARC_DEGREES/12)-90],
  ["12", SCALE_ARC_ANGLES[0]-12*(SCALE_ARC_DEGREES/12)-90]
];

minuteMarkers = [
  ["0", SCALE_ARC_ANGLES[0]-0*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-1*(SCALE_ARC_DEGREES/12)-90],
  ["10", SCALE_ARC_ANGLES[0]-2*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-3*(SCALE_ARC_DEGREES/12)-90],
  ["20", SCALE_ARC_ANGLES[0]-4*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-5*(SCALE_ARC_DEGREES/12)-90],
  ["30", SCALE_ARC_ANGLES[0]-6*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-7*(SCALE_ARC_DEGREES/12)-90],
  ["40", SCALE_ARC_ANGLES[0]-8*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-9*(SCALE_ARC_DEGREES/12)-90],
  ["50", SCALE_ARC_ANGLES[0]-10*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-11*(SCALE_ARC_DEGREES/12)-90],
  ["60", SCALE_ARC_ANGLES[0]-12*(SCALE_ARC_DEGREES/12)-90]
];

secondMarkers = [
  ["0", SCALE_ARC_ANGLES[0]-0*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-1*(SCALE_ARC_DEGREES/12)-90],
  ["10", SCALE_ARC_ANGLES[0]-2*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-3*(SCALE_ARC_DEGREES/12)-90],
  ["20", SCALE_ARC_ANGLES[0]-4*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-5*(SCALE_ARC_DEGREES/12)-90],
  ["30", SCALE_ARC_ANGLES[0]-6*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-7*(SCALE_ARC_DEGREES/12)-90],
  ["40", SCALE_ARC_ANGLES[0]-8*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-9*(SCALE_ARC_DEGREES/12)-90],
  ["50", SCALE_ARC_ANGLES[0]-10*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-11*(SCALE_ARC_DEGREES/12)-90],
  ["60", SCALE_ARC_ANGLES[0]-12*(SCALE_ARC_DEGREES/12)-90]
];

translate([0,0,0])
  facePlate(hourMarkers, "H");
translate([70,0,0])
  facePlate(minuteMarkers, "M");
translate([140,0,0])
  facePlate(secondMarkers, "S");


module facePlate(markers, label) {
  color("White") {  
    translate([0,0,-1])
    //difference() {
      linear_extrude(height=1)
        circle(d=FACE_DIAMETER);
      *linear_extrude(height=1.4) {
        translate([MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, -0.2])
          circle(d=MOUNT_HOLE_DIAMETER);

        translate([-MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, -0.2])
          circle(d=MOUNT_HOLE_DIAMETER);
      }
    //}
  }
    color("Black"){
    linear_extrude(height=1) {
    translate([0,-SCALE_ARC_OFFSET,0]) {
        //linear_extrude(LINE_WIDTH)
          arc(SCALE_ARC_RADIUS, SCALE_ARC_ANGLES, LINE_WIDTH);
      
        for (marker = markers) {
          rotate([0,0,marker[1]]) {
            translate([0,SCALE_ARC_RADIUS+SCALE_MARKER_LENGTH/2,0])
              square([LINE_WIDTH, SCALE_MARKER_LENGTH], center=true);
            translate([0,SCALE_ARC_RADIUS+6,0])
              text(marker[0], font="Courier", size=2, direction = "ltr", spacing=1, halign="center");
          }
        }
      }
      
      translate([MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, 0])
        circle(d=MOUNT_HOLE_DIAMETER);

      translate([-MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, 0])
        circle(d=MOUNT_HOLE_DIAMETER);

      text(label, font="Courier", size=4, direction="ltr", spacing=1, halign="center");      
  }
}
}

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 50) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 
