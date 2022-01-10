include <tactile_button.scad>;


explodeView     = 0;    // 0=Normal, 1=Exploded
EXPLODE_WIDTH   = 40;

RENDER_MODE     = 0;  // 0=Full Model, 1-3=Cylinders, 4-6=Backplates, 7=OuterSpacer, 8=InnerSpacer

showBodies      = false;
showSpacers     = false;
showBackplates  = false;
showMeters      = false;

showBodies      = true;
showSpacers     = true;
showBackplates  = true;
showMeters      = true;

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

// Volt Meter Cylindrical Housing
BODY_RADIUS = 1;
BODY_LENGTH = 80;
BODY_WIDTH = METER_FLANGE_DIAMETER + 2*BODY_RADIUS;
WALL_THICKNESS = 10;
FOOT_WIDTH = 30;
FOOT_LENGTH = 60;
FOOT_HEIGHT = 25;
FOOT_ANGLE = 15;
FOOT_RADIUS = 3;

// Volt Meter Housing Backplate
BACKPLATE_MOUNT_WIDTH = BODY_WIDTH;
BACKPLATE_MOUNT_HEIGHT = 20;
BACKPLATE_MOUNT_THICKNESS = 10;
BACKPLATE_MOUNT_SCREW_HOLE_DIAMETER = 3.5;
BACKPLATE_MOUNT_SCREW_HOLE_OFFSET = BODY_WIDTH/2-15;
BACKPLATE_CLEARANCE = 0.5;
BACKPLATE_WIDTH = BODY_WIDTH-(2*WALL_THICKNESS)-BACKPLATE_CLEARANCE;
BACKPLATE_THICKNESS = 3;
BACKPLATE_SCREW_HOLE_DIAMETER = 5;
BACKPLATE_SCREW_HOLE_OFFSET = BACKPLATE_MOUNT_SCREW_HOLE_OFFSET;
LOUVER_LENGTH = BACKPLATE_WIDTH*0.85;
LOUVER_WIDTH = 3;
LOUVER_SPACING = 6;
BUTTON_HOLE_DIAMETER = BUTTON_DIAMETER1+1;
BUTTON_HOLE_SPACING = 30;
BUTTON_HOLE_OFFSET = 17;
//POWER_HOLE_LENGTH = 5;
//POWER_HOLE_WIDTH = 10;
POWER_JACK_HOLE_DIAMETER = 11;
POWER_HOLE_OFFSET = -17;

// Connectors between Volt Meter Housings
SPACE_BETWEEN_CYLINDERS = 5;
CYLINDER_SPACING = BODY_WIDTH+SPACE_BETWEEN_CYLINDERS;
CONNECTOR_HEIGHT = 30;
CONNECTOR_LENGTH = 35;
INNER_CONNECTOR_WIDTH = 4;
SPACER_OFFSET = 5;
WIRE_RACE_DIAMETER = 12;
CONNECTOR_SCREW_DIAMETER = 4;
CONNECTOR_SCREW_SPACING = 20;


//$fn = 40;
$fa = 1;
$fs = 1;


rotate([90-FOOT_ANGLE,0,0])
  difference() {
  	union() {
  		createBodies();
  		createSpacers();
      createBackplates();
      createMeters();
  	}

    createWireRaces();
  }


module createWireRaces() {
  xOffset = explodeView*EXPLODE_WIDTH;

  // Wire Race through the Spacers and Bodies
  translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=WIRE_RACE_DIAMETER,center=false);
    }
  }

  translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2+CONNECTOR_SCREW_SPACING/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=CONNECTOR_SCREW_DIAMETER,center=false);
    }
  }

  translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2-CONNECTOR_SCREW_SPACING/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=CONNECTOR_SCREW_DIAMETER,center=false);
    }
  }

  // Wire Race through the Spacers and Bodies
  translate([CYLINDER_SPACING+xOffset,0,SPACER_OFFSET+CONNECTOR_LENGTH/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=WIRE_RACE_DIAMETER,center=false);
    }
  }

  translate([CYLINDER_SPACING+xOffset,0,SPACER_OFFSET+CONNECTOR_LENGTH/2+CONNECTOR_SCREW_SPACING/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=CONNECTOR_SCREW_DIAMETER,center=false);
    }
  }

  translate([CYLINDER_SPACING+xOffset,0,SPACER_OFFSET+CONNECTOR_LENGTH/2-CONNECTOR_SCREW_SPACING/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=CONNECTOR_SCREW_DIAMETER,center=false);
    }
  }
}

module createSpacers() {
  xOffset = explodeView*EXPLODE_WIDTH;

  color("Grey") {
    if ((RENDER_MODE==0 && showSpacers) || RENDER_MODE==7)
      createOuterSpacer(0+xOffset/2,0,SPACER_OFFSET);
    if ((RENDER_MODE==0 && showSpacers) || RENDER_MODE==8)
      createInnerSpacer(0-xOffset/2,0,SPACER_OFFSET,left=true);
    if (RENDER_MODE==0 && showSpacers)
      createInnerSpacer(0-xOffset*1.5,0,SPACER_OFFSET,left=false);

    if (RENDER_MODE==0 && showSpacers)
      createOuterSpacer(CYLINDER_SPACING+xOffset*1.5,0,SPACER_OFFSET);
    if (RENDER_MODE==0 && showSpacers)
      createInnerSpacer(CYLINDER_SPACING+xOffset/2,0,SPACER_OFFSET,left=true);
    if (RENDER_MODE==0 && showSpacers)
      #createInnerSpacer(-CYLINDER_SPACING-xOffset*2.5,0,SPACER_OFFSET,left=false);
  }
}

module createInnerSpacer(X, Y, Z, left=true) {
  if (left)
  	translate([X,Y,Z])
  	    intersection() {
	        translate([(BODY_WIDTH-2*WALL_THICKNESS)/2-INNER_CONNECTOR_WIDTH,-CONNECTOR_HEIGHT/2,0])
            SmoothCube([INNER_CONNECTOR_WIDTH+0,CONNECTOR_HEIGHT,CONNECTOR_LENGTH], 1);
	        translate([0,0,0])
            createInnerBody();
        }
    else
      translate([CYLINDER_SPACING,0,0])
        rotate([0,0,180])
          translate([X,Y,Z])
              intersection() {
                translate([(BODY_WIDTH-2*WALL_THICKNESS)/2-INNER_CONNECTOR_WIDTH,-CONNECTOR_HEIGHT/2,0])
                  SmoothCube([INNER_CONNECTOR_WIDTH+0,CONNECTOR_HEIGHT,CONNECTOR_LENGTH], 1);
                translate([0,0,0])
                  createInnerBody();
              }
}

module createOuterSpacer(X, Y, Z) {
	translate([X,Y,Z]) {
	    difference() {
	        translate([0,-CONNECTOR_HEIGHT/2,0]) {
				roundedCube(CONNECTOR_LENGTH, CONNECTOR_HEIGHT, CYLINDER_SPACING, 4);
			}
	        translate([0,0,-1]) {
	            createOuterBody(rounded=false);
	        };
	        translate([CYLINDER_SPACING,0,-1]) {
	            createOuterBody(rounded=false);
	        };
	    };
	};
}

module createBodies() {
	xOffset = explodeView*EXPLODE_WIDTH;

  if ((RENDER_MODE==0 && showBodies) || RENDER_MODE==1)
  	createBody(0, 0, 0);
  if ((RENDER_MODE==0 && showBodies) || RENDER_MODE==2)
    createBody(CYLINDER_SPACING+xOffset, 0, 0);
  if ((RENDER_MODE==0 && showBodies) || RENDER_MODE==3)
    #createBody((CYLINDER_SPACING+xOffset)*2, 0, 0);
}

module createBackplates() {
  xOffset = explodeView*EXPLODE_WIDTH;

  if ((RENDER_MODE==0 && showBackplates) || RENDER_MODE==4)
    createBackplate(0, 0, -xOffset, power=false, buttons=true, buttonLabels=["+","-"]);

  if ((RENDER_MODE==0 && showBackplates) || RENDER_MODE==5)
    createBackplate(CYLINDER_SPACING+xOffset, 0, -xOffset, power=false, buttons=true, buttonLabels=["H","M"]);

  if ((RENDER_MODE==0 && showBackplates) || RENDER_MODE==6)
    #createBackplate((CYLINDER_SPACING+xOffset)*2, 0, -xOffset, power=true, buttons=true, buttonLabels=["1","2"]);
}

module createBody(X, Y, Z) {
  meterXOffset = explodeView*(METER_BODY_DEPTH + EXPLODE_WIDTH);

	translate([X,Y,Z]) {
    color("Grey") {
      union() {
        difference() {
          createOuterBody(rounded=true);

          createInnerBody();

          rotate([0,0,0])
            translate([0,METER_HOLE_OFFSET,BODY_LENGTH-METER_SCREW_HOLE_DEPTH])
              cylinder(d=METER_SCREW_HOLE_DIAMETER, h=METER_SCREW_HOLE_DEPTH);

          rotate([0,0,120])
            translate([0,METER_HOLE_OFFSET,BODY_LENGTH-METER_SCREW_HOLE_DEPTH])
              cylinder(d=METER_SCREW_HOLE_DIAMETER, h=METER_SCREW_HOLE_DEPTH);

          rotate([0,0,-120])
            translate([0,METER_HOLE_OFFSET,BODY_LENGTH-METER_SCREW_HOLE_DEPTH])
              cylinder(d=METER_SCREW_HOLE_DIAMETER, h=METER_SCREW_HOLE_DEPTH);
        }

        createFoot();

        rotate([0,0,0])
            createBackplateMount();

        rotate([0,0,180])
            createBackplateMount();
      }
    }
	}
}

module createOuterBody(rounded=true) {
	if (rounded)
		roundedCylinder(hgt=BODY_LENGTH, diam=BODY_WIDTH, radius=BODY_RADIUS);
	else
		cylinder(h=BODY_LENGTH, d=BODY_WIDTH);
}

module createInnerBody() {
	translate([0,0,-0.5])
		cylinder(h=BODY_LENGTH+1, d=BODY_WIDTH-(2*WALL_THICKNESS));
}

module createBackplateMount() {
  difference() {
    intersection() {
      translate([-BACKPLATE_MOUNT_WIDTH/2,BODY_WIDTH/2-BACKPLATE_MOUNT_HEIGHT,BACKPLATE_THICKNESS])
        roundedCube(length=BACKPLATE_MOUNT_THICKNESS, width=BACKPLATE_MOUNT_HEIGHT, height=BACKPLATE_MOUNT_WIDTH, radius=2);
      createInnerBody();
    }

    translate([0,BACKPLATE_MOUNT_SCREW_HOLE_OFFSET,1])
      cylinder(d=BACKPLATE_MOUNT_SCREW_HOLE_DIAMETER, h=BACKPLATE_MOUNT_THICKNESS+2);
  }
}

module createFoot() {
  difference() {
  	translate([-FOOT_WIDTH/2,-BODY_WIDTH/2+10,FOOT_LENGTH+10])
      rotate([FOOT_ANGLE,0,0])
        rotate([-90,0,-90])
          SmoothCube([FOOT_HEIGHT+FOOT_RADIUS+10,FOOT_LENGTH,FOOT_WIDTH],FOOT_RADIUS);
    createOuterBody(rounded=false);
  }
}

module roundedCube(length, width, height, radius) {
	hull() {
		rotate([0,90,0]) {
			translate([-radius,radius,0]) {
				cylinder(r=radius, h=height);
			}
		}
		rotate([0,90,0]) {
			translate([-radius,width-radius,0]) {
				cylinder(r=radius, h=height);
			}
		}
		rotate([0,90,0]) {
			translate([-length+radius,radius,0]) {
				cylinder(r=radius, h=height);
			}
		}
		rotate([0,90,0]) {
			translate([-length+radius,width-radius,0]) {
				cylinder(r=radius, h=height);
			}
		}
	}
}

module roundedCylinder(diam, hgt, radius) {
	union() {
		translate([0,0,radius])
			cylinder(h=hgt-(radius*2), d=diam);

		rotate_extrude(convexity = 10, $fn=100)
			translate([BODY_WIDTH/2-radius, radius, 0])
				circle(r = radius);
		cylinder(h=(2*radius), d=diam-(2*radius));

		translate([0,0,hgt-2*radius]) {
			rotate_extrude(convexity = 10)
				translate([BODY_WIDTH/2-radius, radius, 0])
					circle(r = radius);
			cylinder(h=(2*radius), d=diam-(2*radius));
		}
	}
}


module createBackplate(X, Y, Z, louvers=true, buttons=true, power=true, buttons=true, buttonLabels) {
  xOffset = explodeView*EXPLODE_WIDTH/2;

  translate([X,Y,Z]) {
  	difference() {
  		// Plate
      color("Grey")
  		  cylinder(h=BACKPLATE_THICKNESS, d=BACKPLATE_WIDTH);

  		// Louver
  		translate([-LOUVER_LENGTH/2+LOUVER_SPACING/2,-LOUVER_WIDTH/2+LOUVER_SPACING,BACKPLATE_THICKNESS+1])
  			rotate([0,90,0])
  				roundedCube(length=LOUVER_LENGTH-LOUVER_SPACING, width=LOUVER_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);

  		// Louver
  		translate([-LOUVER_LENGTH/2,-LOUVER_WIDTH/2,BACKPLATE_THICKNESS+1])
  			rotate([0,90,0])
  				roundedCube(length=LOUVER_LENGTH, width=LOUVER_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);

  		// Louver
  		translate([-LOUVER_LENGTH/2+LOUVER_SPACING/2,-LOUVER_WIDTH/2-LOUVER_SPACING,BACKPLATE_THICKNESS+1])
  			rotate([0,90,0])
  				roundedCube(length=LOUVER_LENGTH-LOUVER_SPACING, width=LOUVER_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);

      // Mounting Screw Hole
      rotate([0,0,0])
        translate([0,BACKPLATE_SCREW_HOLE_OFFSET,-1])
          cylinder(d=BACKPLATE_SCREW_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+20);

      // Mounting Screw Hole
      rotate([0,0,180])
        translate([0,BACKPLATE_SCREW_HOLE_OFFSET,-1])
          cylinder(d=BACKPLATE_SCREW_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+20);

      if (buttons) {
        translate([-4+BUTTON_HOLE_SPACING/2,14,-BACKPLATE_THICKNESS/2])
          linear_extrude(height = BACKPLATE_THICKNESS)
            rotate([0,180,0])
              text(buttonLabels[0], font="Courier:style=Bold", size=7, direction = "ltr", spacing=0);

        translate([10.5-BUTTON_HOLE_SPACING/2,14,-BACKPLATE_THICKNESS/2])
          linear_extrude(height = BACKPLATE_THICKNESS)
            rotate([0,180,0])
              text(buttonLabels[1], font="Courier:style=Bold", size=7, direction = "ltr", spacing=0);

    		// Push Button Hole
    		translate([-BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,-1])
    			rotate([0,0,0])
    				cylinder(d=BUTTON_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+2);

    		// Push Button Hole
    		translate([BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,-1])
    			rotate([0,0,0])
    				cylinder(d=BUTTON_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+2);
      }

  		// Power Jack Hole
  		if (power)
        translate([0,POWER_HOLE_OFFSET,-1])
          rotate([0,0,90])
            cylinder(d=POWER_JACK_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+2);
  					//roundedCube(length=POWER_HOLE_LENGTH, width=POWER_HOLE_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);
  	}

    // Button
    if (buttons && RENDER_MODE==0)
      translate([-BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,BACKPLATE_THICKNESS+xOffset])
        rotate([180,0,0])
          tactileButton();

    // Button
    if (buttons && RENDER_MODE==0)
      translate([BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,BACKPLATE_THICKNESS+xOffset])
        rotate([180,0,0])
          tactileButton();
  }
}

module createMeters() {
  xOffset = explodeView*EXPLODE_WIDTH;
  meterXOffset = explodeView*(METER_BODY_DEPTH + EXPLODE_WIDTH);

  if (RENDER_MODE==0 && showMeters) {
    createMeter(0,0,BODY_LENGTH+meterXOffset);
    createMeter(CYLINDER_SPACING+xOffset,0,BODY_LENGTH+meterXOffset);
    createMeter((CYLINDER_SPACING+xOffset)*2,0,BODY_LENGTH+meterXOffset);

  }
}

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

module SmoothCube(size, smooth_rad) {
  $fa = ($fa >= 12) ? 1 : $fa;
  $fs = ($fs >= 2) ? 0.4 : $fs;

  size = is_num(size) ? [size, size, size] : size;
  smooth_rad = is_num(smooth_rad) ? [smooth_rad, smooth_rad, smooth_rad] :
    smooth_rad;
  smooth_base = smooth_rad[0];
  scales = smooth_rad / smooth_base;

  scalex = scales[0] * ((smooth_rad[0] < size[0]/2) ? 1 : size[0]/(2*smooth_rad[0]));
  scaley = scales[1] * ((smooth_rad[1] < size[1]/2) ? 1 : size[1]/(2*smooth_rad[1]));
  scalez = scales[2] * ((smooth_rad[2] < size[2]/2) ? 1 : size[2]/(2*smooth_rad[2]));
  smoothx = smooth_rad[0] * scalex / scales[0];
  smoothy = smooth_rad[1] * scaley / scales[1];
  smoothz = smooth_rad[2] * scalez / scales[2];

  hull() {
    translate([smoothx, smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
    translate([size[0]-smoothx, smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
    translate([smoothx, size[1]-smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
    translate([smoothx, smoothy, size[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
    translate([size[0]-smoothx, size[1]-smoothy, smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
    translate([size[0]-smoothx, smoothy, size[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
    translate([smoothx, size[1]-smoothy, size[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
    translate([size[0]-smoothx, size[1]-smoothy, size[2]-smoothz])
      scale([scalex, scaley, scalez])
      sphere(r=smooth_base);
  }
}

module SmoothXYCube(size, smooth_rad) {
  $fa = ($fa >= 12) ? 1 : $fa;
  $fs = ($fs >= 2) ? 0.4 : $fs;

  size = is_num(size) ? [size, size, size] : size;

  scalex = (smooth_rad < size[0]/2) ? 1 : size[0]/(2*smooth_rad);
  scaley = (smooth_rad < size[1]/2) ? 1 : size[1]/(2*smooth_rad);
  smoothx = smooth_rad * scalex;
  smoothy = smooth_rad * scaley;

  linear_extrude(size[2]) hull() {
    translate([smoothx, smoothy])
      scale([scalex, scaley])
      circle(r=smooth_rad);
    translate([size[0]-smoothx, smoothy])
      scale([scalex, scaley])
      circle(r=smooth_rad);
    translate([smoothx, size[1]-smoothy])
      scale([scalex, scaley])
      circle(r=smooth_rad);
    translate([size[0]-smoothx, size[1]-smoothy])
      scale([scalex, scaley])
      circle(r=smooth_rad);
  }
}

