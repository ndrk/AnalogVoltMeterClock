BODY_LENGTH = 80;
BODY_WIDTH = 70;
WALL_THICKNESS = 8;
CYLINDER_SPACING = 80;
CONNECTOR_HEIGHT = 20;
CONNECTOR_LENGTH = 40;
INNER_CONNECTOR_WIDTH = 8;
SPACER_OFFSET = 5;
WIRE_RACE_DIAMETER = 8;
CONNECTOR_SCREW_DIAMETER = 4;
CONNECTOR_SCREW_SPACING = 20;
BACKPLATE_THICKNESS = 3;
EXPLODE_WIDTH = 40;
LOUVER_LENGTH = 30;
LOUVER_WIDTH = 3;
LOUVER_SPACING = 6;
BUTTON_HOLE_DIAMETER = 3;
BUTTON_HOLE_SPACING = 20;
BUTTON_HOLE_OFFSET = 12;
POWER_HOLE_LENGTH = 5;
POWER_HOLE_WIDTH = 10;
POWER_HOLE_OFFSET = -20;


$fn = 40;


explodeView = 0;
showBodies = true;
showSpacers = true;
showBackplates = true;


difference() {
	union() {
		createBodies();
		if (showSpacers)		createSpacers();
	}
	// Wire Race through the Spacers and Bodies
	translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2]) {
		rotate([0,90,0]) {
			cylinder(h=CYLINDER_SPACING*2,d=WIRE_RACE_DIAMETER,center=false);
		}
	}

	translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2+CONNECTOR_SCREW_SPACING/2]) {
		rotate([0,90,0]) {
			cylinder(h=CYLINDER_SPACING*2,d=CONNECTOR_SCREW_DIAMETER,center=false);
		}
	}

	translate([0,0,SPACER_OFFSET+CONNECTOR_LENGTH/2-CONNECTOR_SCREW_SPACING/2]) {
		rotate([0,90,0]) {
			cylinder(h=CYLINDER_SPACING*2,d=CONNECTOR_SCREW_DIAMETER,center=false);
		}
	}
};


module createSpacers() {
	xOffset = explodeView*EXPLODE_WIDTH;

	createOuterSpacer(0+xOffset/2,0,SPACER_OFFSET);
	createInnerSpacers(0,0,SPACER_OFFSET);

	createOuterSpacer(CYLINDER_SPACING+1.5*xOffset,0,SPACER_OFFSET);
	createInnerSpacers(CYLINDER_SPACING+1*xOffset,0,SPACER_OFFSET);
}

module createInnerSpacers(X, Y, Z) {
	xOffset = explodeView*10;
	explodeWidth = explodeView*EXPLODE_WIDTH;

	translate([X,Y,Z]) {
		translate([-xOffset,0,0])
	    intersection() {
	        translate([(BODY_WIDTH-2*WALL_THICKNESS)/2-INNER_CONNECTOR_WIDTH,-CONNECTOR_HEIGHT/2,0]) {
	            cube([INNER_CONNECTOR_WIDTH,CONNECTOR_HEIGHT,CONNECTOR_LENGTH],false);
	        };
	        translate([0,0,0]) {
	            createInnerBody();
	        };
	    };

		translate([explodeWidth+xOffset,0,0])
	    intersection() {
	        translate([CYLINDER_SPACING-(BODY_WIDTH-2*WALL_THICKNESS)/2,-CONNECTOR_HEIGHT/2,0]) {
	            cube([INNER_CONNECTOR_WIDTH,CONNECTOR_HEIGHT,CONNECTOR_LENGTH],false);
	        };
	        translate([CYLINDER_SPACING,0,0]) {
	            createInnerBody();
	        };
	    };
	};
}

module createOuterSpacer(X, Y, Z) {
	translate([X,Y,Z]) {
	    difference() {
	        translate([0,-CONNECTOR_HEIGHT/2,0]) {
				roundedCube(CONNECTOR_LENGTH, CONNECTOR_HEIGHT, CYLINDER_SPACING, 4);
				*hull() {
					rotate([0,90,0]) {
						translate([-2,2,0]) {
							cylinder(d=4, h=CYLINDER_SPACING);
						}
					}
					rotate([0,90,0]) {
						translate([-2,CONNECTOR_HEIGHT-2,0]) {
							cylinder(d=4, h=CYLINDER_SPACING);
						}
					}
					rotate([0,90,0]) {
						translate([-CONNECTOR_LENGTH+2,2,0]) {
							cylinder(d=4, h=CYLINDER_SPACING);
						}
					}
					rotate([0,90,0]) {
						translate([-CONNECTOR_LENGTH+2,CONNECTOR_HEIGHT-2,0]) {
							cylinder(d=4, h=CYLINDER_SPACING);
						}
					}
				}
			}
	        translate([0,0,0]) {
	            createOuterBody(rounded=false);
	        };
	        translate([CYLINDER_SPACING,0,0]) {
	            createOuterBody(rounded=false);
	        };
	    };
	};
}

module createBodies() {
	xOffset = explodeView*EXPLODE_WIDTH;
	
	createBody(0, 0, 0, power=false);
	createBody(CYLINDER_SPACING+xOffset, 0, 0);
	createBody((CYLINDER_SPACING+xOffset)*2, 0, 0, power=false);
}

module createBody(X, Y, Z, power=true) {
	xOffset = -explodeView*EXPLODE_WIDTH;

	translate([X,Y,Z]) {
		if (showBodies) {
			union() {
			    difference() {
			        createOuterBody(rounded=true);
			        createInnerBody();
			    };
				createFoot();
			};
		}

		if (showBackplates)
			translate([0,0,xOffset])
				createBackplate(power=power);
	};
}

module createOuterBody(rounded=true) {
	if (rounded)
		roundedCylinder(hgt=BODY_LENGTH, diam=BODY_WIDTH, radius=3);
	else
		cylinder(h=BODY_LENGTH, d=BODY_WIDTH);
}

module createInnerBody() {
	translate([0,0,-0.5])
		cylinder(h=BODY_LENGTH+1, d=BODY_WIDTH-(2*WALL_THICKNESS));
}

module createFoot() {
	translate([-20/2,-BODY_WIDTH/2+1,60]) {
	rotate([-90,0,-90]) {
		linear_extrude(height=20) {
			polygon([[0,0],[0,50],[20,0]]);
		};
	};
	};
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


module createBackplate(louvers=true, buttons=true, power=true) {
	difference() {
		// Plate
		cylinder(h=BACKPLATE_THICKNESS, d=BODY_WIDTH-(2*WALL_THICKNESS)-0.1);

		// Louver
		translate([-LOUVER_LENGTH/2,-LOUVER_WIDTH/2+LOUVER_SPACING,BACKPLATE_THICKNESS+1])
			rotate([0,90,0])
				roundedCube(length=LOUVER_LENGTH, width=LOUVER_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);

		// Louver
		translate([-LOUVER_LENGTH/2,-LOUVER_WIDTH/2,BACKPLATE_THICKNESS+1])
			rotate([0,90,0])
				roundedCube(length=LOUVER_LENGTH, width=LOUVER_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);

		// Louver
		translate([-LOUVER_LENGTH/2,-LOUVER_WIDTH/2-LOUVER_SPACING,BACKPLATE_THICKNESS+1])
			rotate([0,90,0])
				roundedCube(length=LOUVER_LENGTH, width=LOUVER_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);

		// Push Button Hole
		translate([-BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,-1])
			rotate([0,0,0])
				cylinder(d=BUTTON_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+2);

		// Push Button Hole
		translate([BUTTON_HOLE_SPACING/2,BUTTON_HOLE_OFFSET,-1])
			rotate([0,0,0])
				cylinder(d=BUTTON_HOLE_DIAMETER, h=BACKPLATE_THICKNESS+2);

		// Power Jack Hole
		if (power)
			translate([POWER_HOLE_WIDTH/2,POWER_HOLE_OFFSET,BACKPLATE_THICKNESS+1])
				rotate([0,90,90])
					roundedCube(length=POWER_HOLE_LENGTH, width=POWER_HOLE_WIDTH, height=BACKPLATE_THICKNESS+2, radius=1);
	}
}
