include <BottleNeck.scad>
include <BottleCap.scad>
include <handleOnly.scad>

translate([0,0,100])
rotate([0,180,0])
threeEighthRopeCap();

union(){

threeEighthThreads();
    color("gray")
translate([0,0,-228])
ergoHandle();
    
//color("gray")
//    translate([0,0,-176])
//    cylinder(180,44,44);
    
//color("gray")
//    translate([0,0,-188])
//    resize([0,0,60])
//    sphere(48);
}