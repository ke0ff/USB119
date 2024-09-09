// OpenSCAD 2019.05
// K5TRA USB 119B spacer frame, REV-001
// Joe Haas, KE0FF, 2/15/2023
// This is a clip for the IC7K frame prop rod.
//
// Rev-001, 2/15/2023
//	initial code

//use <char.scad>

// Version 1 and 2 are 0.2" larger in the X dimension.
//	Set "version" to match the target version PCB

version = 3;

//----------------------------------------------------------------------------------------------------------------------
// User defined parameters.  Modify these to suit a particular application
// NOTE: All operational data in this file is in mm
in2mm = 25.4;
mm2in = 1/in2mm;

//----------------------------------------------------------------------------------------------------------------------
// parametric variables:

x1 = 2.3*in2mm;
y1 = 1.85*in2mm;
z1 = 1;

x2 = 2.12*in2mm;
y2 = 1.67*in2mm;
z2 = (1/16)*in2mm;

x3 = 1.68*in2mm;
y3 = 1.23*in2mm;
z3 = -1;
z3t = 20;

bdia = .22*in2mm;
sdia = 0.13 * in2mm;			// MTG hole dia
bz = (3/16)*in2mm;

flat_dia = 0.2 * in2mm;
flat_ht = 0.1 * in2mm;

/////////////////////////////////////

if(version<3){
	body(dwid=.2*in2mm);
}else{
	body();
}
//translate([0,0,(z1/2)+bz]) cube([x1,y1,z1], center = true);

//////////////////****************\\\\\\\\\\\\\\\\\\
				//    modules     \\
//////////////////****************\\\\\\\\\\\\\\\\\\

///////////////
// 
// dwid "stretches" the X dimension (it is zero by default)

module body(dwid = 0){
	xm = x2+dwid;
	difference(){
		union(){
			translate([0,0,z2/2]) cube([xm,y2,z2], center = true);
			// bosses
			translate([-(xm/2)+(bdia/2),-(y2/2)+(bdia/2),0]) cylinder(r=bdia/2, h=bz, $fn=32);
			translate([-(xm/2)+(bdia/2),+(y2/2)-(bdia/2),0]) cylinder(r=bdia/2, h=bz, $fn=32);
			translate([+(xm/2)-(bdia/2),-(y2/2)+(bdia/2),0]) cylinder(r=bdia/2, h=bz, $fn=32);
			translate([+(xm/2)-(bdia/2),+(y2/2)-(bdia/2),0]) cylinder(r=bdia/2, h=bz, $fn=32);
		}
		// holes
		translate([-(xm/2)+(bdia/2),-(y2/2)+(bdia/2),-1]) cylinder(r=sdia/2, h=bz+4, $fn=32);
		translate([-(xm/2)+(bdia/2),+(y2/2)-(bdia/2),-1]) cylinder(r=sdia/2, h=bz+4, $fn=32);
		translate([+(xm/2)-(bdia/2),-(y2/2)+(bdia/2),-1]) cylinder(r=sdia/2, h=bz+4, $fn=32);
		translate([+(xm/2)-(bdia/2),+(y2/2)-(bdia/2),-1]) cylinder(r=sdia/2, h=bz+4, $fn=32);
		// center hogout
		translate([0,0,(z3t/2)+z3]) cube([x3,y3,z3t], center = true);
		
	}
}

/////////////////////////
// csk hole (from top)

module csk_hole(len=20){
	translate([0,0,-.01]) cylinder(r=flat_dia/2, h=flat_ht, $fn = 32);
	translate([0,0,-flat_ht+.01]) cylinder(r2=flat_dia/2, r1=0, h=flat_ht, $fn = 32);
	translate([0,0,-len+.01]) cylinder(r=screw_dia/2, h=len, $fn = 32);
}

/////////////////////////
// drill hole (from top)

module drill_hole(len=20){
	translate([0,0,-len+.01]) cylinder(r=thread_dia/2, h=len, $fn = 32);
}

/////////////////////////
// coax_channel (from top)

module coax_channel(clen = 20){
	rotate([0,90,0]) cylinder(r=coax_dia/2, h=clen, $fn = 16);
	translate([clen/2,0,coax_dia/4]) cube([clen,coax_dia,coax_dia/2], center = true);
}

// EOF
