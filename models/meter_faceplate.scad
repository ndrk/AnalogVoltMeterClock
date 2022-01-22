FACE_DIAMETER = 62;
LINE_WIDTH = 0.3;

SCALE_ARC_RADIUS = 34;
SCALE_ARC_OFFSET = 18;
SCALE_ARC_DEGREES = 90;
SCALE_ARC_ANGLES = [180-SCALE_ARC_DEGREES/2, SCALE_ARC_DEGREES/2];
SCALE_MARKER_LENGTH = 5;

MOUNT_HOLE_DIAMETER = 2;
MOUNT_HOLE_OFFSET = -9.5;
MOUNT_HOLE_SEPARATION = 30;

LABEL_OFFSET = 22;

$fn=100;

// Ya, this isn't elegant. Deal with it! :-)
hourMarkers = [
  ["0", SCALE_ARC_ANGLES[0]-0*(SCALE_ARC_DEGREES/24)-90,"",1],
  ["", SCALE_ARC_ANGLES[0]-1*(SCALE_ARC_DEGREES/24)-90,1],
  ["", SCALE_ARC_ANGLES[0]-2*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-3*(SCALE_ARC_DEGREES/24)-90,1],
  ["4", SCALE_ARC_ANGLES[0]-4*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-5*(SCALE_ARC_DEGREES/24)-90,1],
  ["", SCALE_ARC_ANGLES[0]-6*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-7*(SCALE_ARC_DEGREES/24)-90,1],
  ["8", SCALE_ARC_ANGLES[0]-8*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-9*(SCALE_ARC_DEGREES/24)-90,1],
  ["", SCALE_ARC_ANGLES[0]-10*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-11*(SCALE_ARC_DEGREES/24)-90,1],
  ["12", SCALE_ARC_ANGLES[0]-12*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-13*(SCALE_ARC_DEGREES/24)-90,1],
  ["", SCALE_ARC_ANGLES[0]-14*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-15*(SCALE_ARC_DEGREES/24)-90,1],
  ["16", SCALE_ARC_ANGLES[0]-16*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-17*(SCALE_ARC_DEGREES/24)-90,1],
  ["", SCALE_ARC_ANGLES[0]-18*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-19*(SCALE_ARC_DEGREES/24)-90,1],
  ["20", SCALE_ARC_ANGLES[0]-20*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-21*(SCALE_ARC_DEGREES/24)-90,1],
  ["", SCALE_ARC_ANGLES[0]-22*(SCALE_ARC_DEGREES/24)-90],
  ["", SCALE_ARC_ANGLES[0]-23*(SCALE_ARC_DEGREES/24)-90,1],
  ["24", SCALE_ARC_ANGLES[0]-24*(SCALE_ARC_DEGREES/24)-90,"",1]
];

minuteMarkers = [
  ["0", SCALE_ARC_ANGLES[0]-0*(SCALE_ARC_DEGREES/12)-90,"",1],
  //["", SCALE_ARC_ANGLES[0]-1/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-2/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-3/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-4/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-1*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-6/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-7/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-8/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-9/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["10", SCALE_ARC_ANGLES[0]-2*(SCALE_ARC_DEGREES/12)-90],
  //["", SCALE_ARC_ANGLES[0]-11/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-12/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-13/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-14/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-3*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-16/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-17/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-18/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-19/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["20", SCALE_ARC_ANGLES[0]-4*(SCALE_ARC_DEGREES/12)-90],
  //["", SCALE_ARC_ANGLES[0]-21/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-22/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-23/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-24/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-5*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-26/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-27/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-28/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-29/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["30", SCALE_ARC_ANGLES[0]-6*(SCALE_ARC_DEGREES/12)-90],
  //["", SCALE_ARC_ANGLES[0]-31/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-32/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-33/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-34/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-7*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-36/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-37/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-38/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-39/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["40", SCALE_ARC_ANGLES[0]-8*(SCALE_ARC_DEGREES/12)-90],
  //["", SCALE_ARC_ANGLES[0]-41/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-42/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-43/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-44/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-9*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-46/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-47/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-48/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-49/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["50", SCALE_ARC_ANGLES[0]-10*(SCALE_ARC_DEGREES/12)-90],
  //["", SCALE_ARC_ANGLES[0]-51/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-52/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-53/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-54/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-11*(SCALE_ARC_DEGREES/12)-90],
  ["", SCALE_ARC_ANGLES[0]-56/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-57/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["", SCALE_ARC_ANGLES[0]-58/5*(SCALE_ARC_DEGREES/12)-90, 1],
  //["", SCALE_ARC_ANGLES[0]-59/5*(SCALE_ARC_DEGREES/12)-90, 1],
  ["60", SCALE_ARC_ANGLES[0]-12*(SCALE_ARC_DEGREES/12)-90,"",1]
];

secondMarkers = minuteMarkers;

translate([35,100,0])
  facePlate(hourMarkers, "Hour");
translate([-30,35,0])
  facePlate(minuteMarkers, "Minute");
translate([-30,100,0])
  facePlate(secondMarkers, "Second");


module facePlate(markers, label) {
  color("Black") {
    //translate([0,0,-1])
    difference() {
      //linear_extrude(height=1)
        circle(d=FACE_DIAMETER+LINE_WIDTH);
      //*linear_extrude(height=1.4) {
        //translate([MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, -0.2])
          //circle(d=MOUNT_HOLE_DIAMETER);

        //translate([-MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, -0.2])
          circle(d=FACE_DIAMETER);
      //}
    }
  }
    color("Black"){
    //linear_extrude(height=1) {
    translate([0,-SCALE_ARC_OFFSET,0]) {
        //linear_extrude(LINE_WIDTH)
          arc(SCALE_ARC_RADIUS, SCALE_ARC_ANGLES, LINE_WIDTH);

        for (marker = markers) {
          if (marker[2] == 1) {
            rotate([0,0,marker[1]]) {
              translate([0,SCALE_ARC_RADIUS+SCALE_MARKER_LENGTH/4,0])
                square([LINE_WIDTH, SCALE_MARKER_LENGTH/2], center=true);
              if (marker[3] == 1)
                translate([0,SCALE_ARC_RADIUS-6,0])
                  text(marker[0], font="Courier", size=2.5, direction = "ltr", spacing=1, halign="center");
              else
                translate([0,SCALE_ARC_RADIUS+6,0])
                  text(marker[0], font="Courier", size=2.5, direction = "ltr", spacing=1, halign="center");
            }
          }
          else {
            rotate([0,0,marker[1]]) {
              translate([0,SCALE_ARC_RADIUS+SCALE_MARKER_LENGTH/2,0])
                square([LINE_WIDTH, SCALE_MARKER_LENGTH], center=true);
              if (marker[3] == 1)
                translate([0,SCALE_ARC_RADIUS-3,0])
                  text(marker[0], font="Courier", size=2.5, direction = "ltr", spacing=1, halign="center");
              else
                translate([0,SCALE_ARC_RADIUS+6,0])
                  text(marker[0], font="Courier", size=2.5, direction = "ltr", spacing=1, halign="center");
            }
          }
        }
      //}

      translate([MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, 0])
        circle(d=MOUNT_HOLE_DIAMETER);

      translate([-MOUNT_HOLE_SEPARATION/2,-MOUNT_HOLE_OFFSET, 0])
        circle(d=MOUNT_HOLE_DIAMETER);

      translate([0,LABEL_OFFSET,0])
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
