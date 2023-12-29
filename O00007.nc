O00007
G21;
G91;

G65 H01 P#10 Q0;

(Tool 10 diameter #2109)
(Double touch in negative X direction)
(Fast probe to approximate position)
(Slow probe for accurate position)
G31 X10 F800; 
G0 X-1;
G31 X1 F2;

G92 X0 Y0;

(X axis position machine)
G65 H01 P#102 Q#5006;

G0 X-0.5;

N100 G0 Y-10;
G31 X10 F350;
G65 H01 P#10 Q#1015;
G0 X-0.5;
(If touch occured then repeat)
G65 H81 P100 Q#10 R1;

(Probe next axis)
G92 Y0;

G31 Y10 F800;
G0 Y-0.5;
G31 Y1 F2;

G0 Y-0.5;
G92 Y0;

N200 G0 X5;
G31 Y1 F350;
G65 H01 P#10 Q#1015;
G0 Y-0.5;
(If touch occured then repeat)
G65 H81 P200 Q#10 R1;

(Clear part in case probe landed precisely on the corner)
G0 X20;

G31 Y2.5 F250;
G31 X-10 F250;
G0 X1;
G31 X-1 F2;
G65 H01 P#108 Q#5006;
G00 X1;

(Half of probe's effective tip diameter)
G65 H05 P#117 Q#2109 R2; 

G65 H02 P#113 Q#102 R#117; (Add tip radius to X1)
G65 H03 P#114 Q#108 R#117; (Subtract tip radius from X2)
G65 H02 P#115 Q#113 R#114;
(Calculate center point)
G65 H05 P#116 Q#115 R2;
(Width of the part)
G65 H03 P#118 Q#114 R#113;

G53 G90 G0 Z0;
G53 G90 G0 X#116;

M99