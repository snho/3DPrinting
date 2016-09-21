/**

    Parametric Spool
    by snho

**/

/** VARIABLES **/
// Outside flange diameter of the spool
OD = 50;
// Inside diameter of the spool        
ID = 10;
// Outside Rim Thickness        
ODRT = 5;
// Inside shaft wall thickness       
IDRT = 5;
// Shaft Length       
SL = 60;
// Shaft Connector Length        
SCL = 10;
// Shaft Clearance for adhesion and fit       
SCLR = 1;
// Print Quality (Sides)       
SIDES = 100;
// Model Displacement (Distance between models for printing)    
MDLDSP = 10;

/** MODULES **/

module outerRim() {
    linear_extrude(height = ODRT)
    difference() {
        // Outer shape
        circle(d = OD, $fn = SIDES);
        // Inner circle
        circle(d = ID, $fn = SIDES);
    }
}

module innerShaft() {
    linear_extrude(height = SL)
    difference() {
        // Outer circle
        circle(d = ID + IDRT, $fn = SIDES);
        //Inner circle
        circle(d = ID, $fn = SIDES);
    }
}

module innerShaftMale() {
    linear_extrude(height = (SL / 2) - SCL)
    difference() {
        // Outer circle
        circle(d = ID + IDRT, $fn = SIDES);
        //Inner circle
        circle(d = ID, $fn = SIDES);
    }
    translate([0, 0, (SL / 2) - SCL])
    linear_extrude(height = SCL)
    difference() {
        circle(d = (ID + IDRT / 2), $fn = SIDES);
        circle(d = (ID), $fn = SIDES);
    }
}

module innerShaftFemale() {
    linear_extrude(height = (SL / 2) - SCL)
    difference() {
        // Outer circle
        circle(d = ID + IDRT, $fn = SIDES);
        //Inner circle
        circle(d = ID, $fn = SIDES);
    }
    translate([0, 0, (SL / 2) - SCL])
    linear_extrude(height = SCL)
    difference() {
        circle(d = (ID + IDRT), $fn = SIDES);
        circle(d = (ID + IDRT / 2), $fn = SIDES);
    }
}


/** Printer/Render Ready Model **/
outerRim();
translate([0, 0, ODRT])
innerShaftMale();
translate([OD + MDLDSP, 0, 0])
outerRim();
translate([OD + MDLDSP, 0, ODRT])
innerShaftFemale();

