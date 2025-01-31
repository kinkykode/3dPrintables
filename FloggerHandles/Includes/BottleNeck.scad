//1=rough, 2=test; 3=final
precision=3; 
//thickness of the cap
wallThickness=4; 
//inner diameter of cap, excluding thread (i.e. outer diameter of neck plus threads)
innerDiameter=90; 
//inner depth of cap
innerDepth=30; 
//thread pitch (inter-thread pitch if multiple)
threadPitch=3.81; 
//thread depth
threadDepth=1.25; 
//thread width
threadWidth=1.3; 
//number of turns per thread
threadTurns=7; 
//number of threads
threads=1; 
//start of thread from cap bottom
threadStart=1.3; 
//number of ridges on cap
ridges=25;
//number of facets on thread and ridges
smoothness=(precision==1)?4:((precision==2)?6:20); 
//number of thread segments in asingle turn
facets=(precision==1)?6:((precision==10)?20:50);
segments=facets*threadTurns;
$fn=max(20,facets);




module neckThread()
{
  union()
  {
    for(thread=[0:threads-1])
    {
      rotate([0,0,360*thread/threads])
      translate([innerDiameter/2-threadDepth,0,wallThickness+innerDepth-threadStart-threadTurns*threadPitch*threads-threadWidth/2])
      scale([threadDepth,threadDepth,threadWidth/2])
      sphere(r=1,$fn=smoothness);
      rotate([0,0,360*thread/threads+threadTurns*360])
      translate([innerDiameter/2-threadDepth,0,wallThickness+innerDepth-threadStart-threadWidth/2])
      scale([threadDepth,threadDepth,threadWidth/2])
      sphere(r=1,$fn=smoothness);
    }
    for(twist=[0:segments-1])//
    {
      translate([0,0,wallThickness+innerDepth-threadStart-threadPitch*threadTurns*threads-threadWidth/2])
      union()
      {
        for(thread=[0:threads-1])
        {
          translate([0,0,threadPitch*threads*twist/segments*threadTurns])
          rotate([0,0,360*(thread/threads)+twist*360*threadTurns/segments])
          rotate([atan(threadPitch*threads/(innerDiameter*3.1416)),0,0])
          rotate_extrude(convexity = 10,angle=360/facets,$fn=50)
          translate([innerDiameter/2-threadDepth, 0, 0])
          scale([threadDepth,threadWidth/2,0])circle(r=1,$fn=smoothness);
        }
      }
    }
  }
}


module threeEighthThreads()
{
    color("gray")

    translate([0,0,innerDepth+wallThickness*2])
    rotate([180,0,0])
    union()
    {
      neckThread();
      //neck body
      difference()
      {
        union()
        {
          //neck
          translate([0,0,innerDepth/2+wallThickness*1.75])
          cylinder(h=innerDepth+wallThickness/2,r=innerDiameter/2-threadDepth,center=true);

          translate([0, 0, wallThickness*1.5])
          rotate_extrude(convexity = 10)
          translate([innerDiameter/2-threadDepth-wallThickness/2, 0, 0])
          circle(r = wallThickness/2, $fn = smoothness);
          
//          //rim
//          translate([0,0,innerDepth+wallThickness*1.5])
//          cylinder(h=wallThickness,r=innerDiameter/2+threadDepth*2-wallThickness/2,center=true);
//          
//          translate([0, 0, innerDepth+wallThickness*1.5])
//          rotate_extrude(convexity = 10)
//          translate([innerDiameter/2+threadDepth*2-wallThickness/2, 0, 0])
//          circle(r = wallThickness/2, $fn = smoothness);
        }
        translate([0,0,innerDepth])
        cylinder(h=innerDepth*2,r=(innerDiameter)/2-wallThickness-threadDepth,center=true);
        
      }
      translate([0,0,6]) 
        cylinder(32, 40, 40);
    }
}

