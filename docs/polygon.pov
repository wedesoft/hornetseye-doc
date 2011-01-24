#include "colors.inc"

#switch (clock)
   #range (0.00,0.25)
      #declare help = clock * 4;
      #declare trans1 = < -4.0, +4.0 - help * 8.0, 0.0 >;
      #declare phi1 = 0.0;
      #declare trans2 = < 4.0, -4.0, 0 >;
      #declare phi2 = help * 150.0;
      #break
   #range (0.25,0.5)
      #declare help = ( clock - 0.25 ) * 4;
      #declare trans1 = < -4.0 + help * 8.0, -4.0, 0.0 >;
      #declare phi1 = 0.0;
      #declare trans2 = < 4.0, -4.0 - 5.0 * help, 0 >;
      #declare phi2 = 150.0;
      #break
   #range (0.5,0.75)
      #declare help = ( clock - 0.5 ) * 4;
      #declare trans1 = < +4.0, -4.0, 0.0 >;
      #declare phi1 = help * 180;
      #declare trans2 = < 4.0, -9.0, 0 >;
      #declare phi2 = help * 150 + 150;
      #break
   #range (0.75,1.0)
      #declare help = ( clock - 0.75 ) * 4;
      #declare trans1 = < 4.0 - help * 8.0, -4.0 + 8.0 * help, 0.0 >;
      #declare phi1 = 180.0 - 180.0 * help;
      #declare trans2 = < 4.0, -9.0 + 5.0 * help, 0 >;
      #declare phi2 = help * 60 + 300;
      #break
#end

global_settings {
  assumed_gamma 2.2
  max_trace_level 5
  ambient_light White
}

background { color White }

#declare dist = 10000;

camera {
   location < 0.0, 0.0, -dist >
   look_at 0
   angle atan( 20.0 / dist ) * 180.0 / pi
}

polygon {
   6,
   < -2, -2 >, < -1, -2 >, < -1, 1 >, < 4, 0 >, < 4, 1 >, < -2, 2 >
   texture {
      finish { ambient 1 diffuse 0 }
      pigment { color DimGray }
  }
  scale 0.7
  rotate phi1 * z
  translate trans1
}

polygon {
   4,
   < -2, -1 >, < 2, -1 >, < -1, 1 >, < -2, -1 >
   texture {
      finish { ambient 1 diffuse 0 }
      pigment { color LightGray }
  }
  scale 0.7
  rotate phi2 * z
  translate trans2
}

