$fn = 50;

facewidth = 58;
faceheight = 60+14;
thickness = 4;
cornerrad = 4;

faceoffsety = -5;

switchdiam = 7.2;
leddiam = 5.5;
postheight = 12.75;

wallheight = 28+thickness;


*union() {
    face();
    walls();
}

cover();

translate([-10, -70, 0]) cube([20, 20, 19]);
//translate([0, 20.75+faceoffsety, 13/2+thickness/2]) cube([16, 41.5, 13], true);

module face() {
    translate([0, 0, thickness/2])
    difference() {
        union() {
            cube([facewidth, faceheight, thickness], true);
            
            for(i=[-1, 1])
                translate([i*14.2, 36.2+faceoffsety, thickness/2])
                    difference() {
                        cylinder(r=3, h=postheight, center=false);
                        cylinder(r=1, h=postheight+1, center=false);
                    }
        }
        translate([0, faceoffsety, 0]) { //face void
            cylinder(d=switchdiam, h=thickness*2, center=true);
            for(i=[-1, 1], j=[11.3, 11.3+11.7])
                translate([i*13.9, j, 0])
                    cylinder(d=leddiam, h=thickness*2, center=true);
        }
    }
}

module walls() {
    difference() {
        union() {
            difference() {
                hull() 
                    for(i=[-1, 1], j=[-1, 1])
                        translate([i*(facewidth/2), j*(faceheight/2), 0])
                            cylinder(h=wallheight, center=false, r=cornerrad);
                translate([0, 0, wallheight/2])
                    cube([facewidth, faceheight, wallheight+1], true);
                translate([0, faceheight/2+thickness/2, wallheight/2+thickness])
                    cube([16.5, thickness*2, wallheight], true);
            }
            translate([0, faceoffsety-thickness/2-6.5, wallheight/2])
                difference() {
                    cube([facewidth, thickness, wallheight], true);
                    translate([facewidth/2-6.5, 0, -wallheight/2+4.5+thickness])
                       cube([13, 9, 9], true);
                }
            for(i=[-1, 1], j=[faceheight/2, faceoffsety-thickness/2-6.5])
                translate([i*facewidth/2, j, wallheight/2])
                    cylinder(r=4, h=wallheight, center=true);
        }
        for(i=[-1, 1], j=[faceheight/2, faceoffsety-thickness/2-6.5])
            translate([i*facewidth/2, j, wallheight/2+10])
                cylinder(r=1, h=wallheight, center=true);
        }
}

module cover() {
    difference() {
        union() {
            hull() 
                for(i=[-1, 1], j=[-1, 1])
                    translate([i*(facewidth/2), j*(faceheight/2), 0])
                        cylinder(h=thickness, center=false, r=cornerrad);
            translate([0, faceheight/2+thickness/2, 0])
                plate();
        }
        for(i=[-1, 1], j=[faceheight/2, faceoffsety-thickness/2-6.5])
            translate([i*facewidth/2, j, 0])
                cylinder(r=1.4, h=wallheight, center=true);
    }
 }
 
 module plate(height=14.8) {
     translate([0, 0, height/2+thickness])
     union() {
        cube([16, thickness, height], true);
        translate([0, -thickness/2-1, -1.6])
            cube([20, 2, height], true);
     }
 }