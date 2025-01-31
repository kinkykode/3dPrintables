module ergoHandle(){
    //handle
    difference(){
        union(){
            translate([0,0,20])
            union(){
                cylinder(155, 28, 28);
                translate([0,0,155])
                    cylinder(30, 28,44);
                translate([0,0,185])
                    cylinder(30, 44,44);
            }
            
            translate([0,0,5])
            resize([0,0,50])
            sphere(45);
        }
        
        //hollow      
        translate([0,0,-10])
            cylinder(225, 18, 18);
        translate([0,0,-40])
            cylinder(240, 10, 10);
        
        //termination holes
        rotate([15,0,0])
        translate([35,0,-35])
            cylinder(100,4,4);
        rotate([-15,0,0])
        translate([35,5,-35])
            cylinder(100,4,4);
        rotate([0,30,0])
        translate([40,3,-25])
            cylinder(30,6,6);
    }

    //plug
    translate([0,0,-60])
    union(){
        translate([0,0,4])cylinder(10, 10, 9.5);
        
        cylinder(4, 15, 15);
    }
}

//ergoHandle();