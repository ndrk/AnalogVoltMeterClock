include <volt_meter.scad>;
include <tactile_button.scad>;
use <smooth_prim.scad>;


explodeView     = 0;  // 0=Normal, 1=Exploded
EXPLODE_WIDTH   = 40; // How far apart to explode most parts

RENDER_MODE     = 0;  // 0=Full Model, 1-3=Cylinders, 4-6=Backplates, 7=OuterSpacer, 8=InnerSpacer

showBodies      = false;  // Define which parts of the model to render
showSpacers     = false;
showBackplates  = false;
showMeters      = false;

showBodies      = true;
showSpacers     = true;
showBackplates  = true;
showMeters      = true;

// Volt Meter Cylindrical Housing
BODY_RADIUS = 1;
BODY_LENGTH = 82;
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
BACKPLATE_MOUNT_THICKNESS = 5;
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
BUTTON_LIP_WIDTH = 1;
BUTTON_LIP_HEIGHT = 1;
BUTTON_LIP_CLEARANCE = 0.2;
//POWER_HOLE_LENGTH = 5;
//POWER_HOLE_WIDTH = 10;
POWER_JACK_HOLE_DIAMETER = 11;
POWER_HOLE_OFFSET = -17;
USB_HOLE_WIDTH = 15;
USB_HOLE_HEIGHT = 10;

// Connectors between Volt Meter Housings
SPACE_BETWEEN_CYLINDERS = 5;  // Distance between outside edges of adjacent meter housings
CYLINDER_SPACING = BODY_WIDTH+SPACE_BETWEEN_CYLINDERS;
CONNECTOR_HEIGHT = 30;
CONNECTOR_LENGTH = 35;
INNER_CONNECTOR_WIDTH = 4;
SPACER_OFFSET = 5;
WIRE_RACE_DIAMETER = 12;
CONNECTOR_SCREW_DIAMETER = 4;
CONNECTOR_SCREW_SPACING = 20;

CONTROLLER_MOUNT_CLEARANCE = 0.1;
CONTROLLER_WIDTH = 18.0;
CONTROLLER_WIDTH_CLEAR = CONTROLLER_WIDTH + CONTROLLER_MOUNT_CLEARANCE;
CONTROLLER_LENGTH = 35.0;
CONTROLLER_LENGTH_CLEAR = CONTROLLER_LENGTH + CONTROLLER_MOUNT_CLEARANCE;
CONTROLLER_THICKNESS = 4.1;
CONTROLLER_THICKNESS_CLEAR = CONTROLLER_THICKNESS + CONTROLLER_MOUNT_CLEARANCE;
CONTROLLER_MOUNT_THICKNESS = 3.0;
CONTROLLER_MOUNT_LIP = 2;


//$fn = 40;
$fa = 1;
$fs = 1;


// Create the clock
rotate([90-FOOT_ANGLE,0,0])
  difference() {
  	union() {
  		createBodies();
  		createSpacers();
      createBackplates();
      createMeters();
  	}

    // Cut holes through the bodies and connectors for bolts and wires
    createWireRaces();
  }

/*
  This function creates 3 cylinders - 1 for a wire raceway
  and 2 for bolts to hold adjacent volt meter housings together.
*/
module createWireRaces() {
  xOffset = explodeView*EXPLODE_WIDTH;

  // Wire Race through the Spacers and Bodies
  translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=WIRE_RACE_DIAMETER,center=false);
    }
  }

  // Bolt Hole through the Spacers and Bodies
  translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2+CONNECTOR_SCREW_SPACING/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=CONNECTOR_SCREW_DIAMETER,center=false);
    }
  }

  // Bolt Hole through the Spacers and Bodies
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

  // Bolt Hole through the Spacers and Bodies
  translate([CYLINDER_SPACING+xOffset,0,SPACER_OFFSET+CONNECTOR_LENGTH/2+CONNECTOR_SCREW_SPACING/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=CONNECTOR_SCREW_DIAMETER,center=false);
    }
  }

  // Bolt Hole through the Spacers and Bodies
  translate([CYLINDER_SPACING+xOffset,0,SPACER_OFFSET+CONNECTOR_LENGTH/2-CONNECTOR_SCREW_SPACING/2]) {
    rotate([0,90,0]) {
      cylinder(h=CYLINDER_SPACING+xOffset,d=CONNECTOR_SCREW_DIAMETER,center=false);
    }
  }
}

/*
  This function generates the 2 sets of connectors/spacers that hold adjacent
  volt meter bodies together. The "Outer" spacer is the one between the bodies,
  and the "Inner" spacers are the ones inside the bodies.
*/
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
      createInnerSpacer(-CYLINDER_SPACING-xOffset*2.5,0,SPACER_OFFSET,left=false);
  }
}

/*
  Creates either a left or right "Inner" spacer. These are
  the pieces that are inside the volt meter housing that we bolt
  against to assemble the clock.
*/
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

/*
  Creates an "Outer" spacer. This is the piece that goes between
  the volt meter housings to join them together.
*/
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

/*
  Instantiates the 3 volt meter housings
*/
module createBodies() {
	xOffset = explodeView*EXPLODE_WIDTH;

  if ((RENDER_MODE==0 && showBodies) || RENDER_MODE==1)
  	createBody(0, 0, 0, 1);
  if ((RENDER_MODE==0 && showBodies) || RENDER_MODE==2)
    createBody(CYLINDER_SPACING+xOffset, 0, 0);
  if ((RENDER_MODE==0 && showBodies) || RENDER_MODE==3)
    createBody((CYLINDER_SPACING+xOffset)*2, 0, 0, 1);
}

/*
  Instantiates the 3 volt meter housing backplates.
*/
module createBackplates() {
  xOffset = explodeView*EXPLODE_WIDTH;

  if ((RENDER_MODE==0 && showBackplates) || RENDER_MODE==4)
    createBackplate(0, 0, -xOffset, power=false, usb=true, buttons=true, buttonLabels=["+","-"]);

  if ((RENDER_MODE==0 && showBackplates) || RENDER_MODE==5)
    createBackplate(CYLINDER_SPACING+xOffset, 0, -xOffset, power=true, usb=false, buttons=true, buttonLabels=["H","M"]);

  if ((RENDER_MODE==0 && showBackplates) || RENDER_MODE==6)
    createBackplate((CYLINDER_SPACING+xOffset)*2, 0, -xOffset, power=false, usb=true, buttons=true, buttonLabels=["1","2"]);
}

/*
  This function creates a volt meter housing.
*/
module createBody(X, Y, Z, controller=0) {
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
            createBackplateMount(controllerMount=controller);
      }
    }
	}
}

/*
  This function creates the overall volt meter housing cylinder.
*/
module createOuterBody(rounded=true) {
	if (rounded)
		roundedCylinder(hgt=BODY_LENGTH, diam=BODY_WIDTH, radius=BODY_RADIUS);
	else
		cylinder(h=BODY_LENGTH, d=BODY_WIDTH);
}

/*
  This function generates the interior portion of the vold meter
  housing that will be hollowed out of it.
*/
module createInnerBody() {
	translate([0,0,-0.5])
		cylinder(h=BODY_LENGTH+1, d=BODY_WIDTH-(2*WALL_THICKNESS));
}

/*
  Create a surface for the backplate to rest against and be
  screwed to.
*/
module createBackplateMount(controllerMount=0) {
  mountLength = BACKPLATE_MOUNT_THICKNESS + (controllerMount*(CONTROLLER_LENGTH_CLEAR+CONTROLLER_MOUNT_THICKNESS-BACKPLATE_MOUNT_THICKNESS));

  difference() {
    intersection() {
      union() {
        translate([-BACKPLATE_MOUNT_WIDTH/2,BODY_WIDTH/2-BACKPLATE_MOUNT_HEIGHT,BACKPLATE_THICKNESS])
          roundedCube(length=mountLength, width=BACKPLATE_MOUNT_HEIGHT, height=BACKPLATE_MOUNT_WIDTH, radius=2);
        if (controllerMount == 1)
          createControllerMount(mountLength);
      }
      createInnerBody();
    }

    translate([0,BACKPLATE_MOUNT_SCREW_HOLE_OFFSET,1])
      cylinder(d=BACKPLATE_MOUNT_SCREW_HOLE_DIAMETER, h=mountLength+2);
  }
}

/*
  Generates a solid food piece that is added to the volt meter
  housing to angle it upwards and give it something to rest on.
*/
module createFoot() {
  difference() {
  	translate([-FOOT_WIDTH/2,-BODY_WIDTH/2+10,FOOT_LENGTH+10])
      rotate([FOOT_ANGLE,0,0])
        rotate([-90,0,-90])
          SmoothCube([FOOT_HEIGHT+FOOT_RADIUS+10,FOOT_LENGTH,FOOT_WIDTH],FOOT_RADIUS);
    createOuterBody(rounded=false);
  }
}

/*
  This function creates a cube that has a radius
  on 4 of its edges.
*/
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

/*
  Generates a cylinder that has a radius on its edges
  on both ends.
  */
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

/*
  Generate a backplate. The backplate is configurable. It can be with
  or without louvers, buttons, button labels or a hole for the power cord.
*/
module createBackplate(X, Y, Z, louvers=true, buttons=true, power=true, usb=true, buttons=true, buttonLabels) {
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
        // Left Push Button Label
        translate([-4+BUTTON_HOLE_SPACING/2,14,-BACKPLATE_THICKNESS/2])
          linear_extrude(height = BACKPLATE_THICKNESS)
            rotate([0,180,0])
              text(buttonLabels[0], font="Courier:style=Bold", size=7, direction = "ltr", spacing=0);

        // Right Push Button Label
        translate([10.5-BUTTON_HOLE_SPACING/2,14,-BACKPLATE_THICKNESS/2])
          linear_extrude(height = BACKPLATE_THICKNESS)
            rotate([0,180,0])
              text(buttonLabels[1], font="Courier:style=Bold", size=7, direction = "ltr", spacing=0);

    		// Left Push Button Hole
    		translate([-BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,-1])
    			rotate([0,0,0])
    				cylinder(d=BUTTON_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+2);

    		// Right Push Button Hole
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

      if (usb)
        translate([0,-20,BACKPLATE_THICKNESS/2])
          rotate([0,0,0])
            cube([USB_HOLE_WIDTH, USB_HOLE_HEIGHT, BACKPLATE_THICKNESS+2],center=true);
  	}

    if (buttons && RENDER_MODE==0) {
      // Button
      translate([-BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,BACKPLATE_THICKNESS+xOffset])
        rotate([180,0,0])
          tactileButton();

      // Button Alignment Lip
      translate([-BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,BACKPLATE_THICKNESS+BUTTON_LIP_HEIGHT/2]) {
        outerSize = BUTTON_BODY_LENGTH+2*BUTTON_LIP_WIDTH+BUTTON_LIP_CLEARANCE;
        innerSize = BUTTON_BODY_LENGTH+BUTTON_LIP_CLEARANCE;

        difference() {
          translate([-outerSize/2,-outerSize/2,-BUTTON_LIP_HEIGHT-0.5])
            SmoothCube([outerSize, outerSize,BUTTON_LIP_HEIGHT*2], 0.5);
          translate([0,-0.1,0])
            cube([innerSize, innerSize,BUTTON_LIP_HEIGHT+0.2], center=true);
        }
      }

      // Button
      translate([BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,BACKPLATE_THICKNESS+xOffset])
        rotate([180,0,0])
          tactileButton();

      // Button Alignment Lip
      translate([BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,BACKPLATE_THICKNESS+BUTTON_LIP_HEIGHT/2]) {
        outerSize = BUTTON_BODY_LENGTH+2*BUTTON_LIP_WIDTH+BUTTON_LIP_CLEARANCE;
        innerSize = BUTTON_BODY_LENGTH+BUTTON_LIP_CLEARANCE;

        difference() {
          translate([-outerSize/2,-outerSize/2,-BUTTON_LIP_HEIGHT-0.5])
            SmoothCube([outerSize, outerSize,BUTTON_LIP_HEIGHT*2], 0.5);
          translate([0,-0.1,0])
            cube([innerSize, innerSize,BUTTON_LIP_HEIGHT+0.2], center=true);
        }
      }
    }
  }
}

/*
  Generate all 3 volt meters. These are for visual purposes only.
  They will not be used in a final rendering.
*/
module createMeters() {
  xOffset = explodeView*EXPLODE_WIDTH;
  meterXOffset = explodeView*(METER_BODY_DEPTH + EXPLODE_WIDTH);

  if (RENDER_MODE==0 && showMeters) {
    createMeter(0,0,BODY_LENGTH+meterXOffset);
    createMeter(CYLINDER_SPACING+xOffset,0,BODY_LENGTH+meterXOffset);
    createMeter((CYLINDER_SPACING+xOffset)*2,0,BODY_LENGTH+meterXOffset);

  }
}

module createControllerMount(length) {
  //length = CONTROLLER_LENGTH_CLEAR + CONTROLLER_MOUNT_THICKNESS;
  width = CONTROLLER_WIDTH_CLEAR + 2*CONTROLLER_MOUNT_THICKNESS;
  thickness = CONTROLLER_THICKNESS_CLEAR + CONTROLLER_MOUNT_THICKNESS;
  vertOffset = BODY_WIDTH/2-BACKPLATE_MOUNT_HEIGHT-thickness;

  openingWidth = CONTROLLER_WIDTH-2*CONTROLLER_MOUNT_LIP;
  openingLength = CONTROLLER_LENGTH-CONTROLLER_MOUNT_LIP;

  //translate([-BACKPLATE_MOUNT_WIDTH/2,BODY_WIDTH/2-BACKPLATE_MOUNT_HEIGHT,BACKPLATE_THICKNESS])
  translate([-width/2,vertOffset,BACKPLATE_THICKNESS])
    difference() {
      //SmoothCube([width, thickness+5, length],2);
      roundedCube(length, thickness+5, width, 2);
      translate([CONTROLLER_MOUNT_THICKNESS+CONTROLLER_MOUNT_LIP,-0.5,-1])
        cube([openingWidth,CONTROLLER_MOUNT_THICKNESS+1,openingLength+1]);
      translate([CONTROLLER_MOUNT_THICKNESS,CONTROLLER_MOUNT_THICKNESS,-1])
        cube([CONTROLLER_WIDTH_CLEAR, CONTROLLER_THICKNESS_CLEAR, CONTROLLER_LENGTH_CLEAR+1]);
    }
}



