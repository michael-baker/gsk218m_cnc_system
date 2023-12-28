O00007

G21;
G91;

(Tool 10 diameter #2109)

(Double touch in negative X direction)
(Fast probe to approximate position)
(Slow probe for accurate position)
(Assign axis position to #101)
G31 X10 F800; 
G0 X-0.5;
G31 X1 F4;

G92 X0 Y0;

(Touch position relative)
G65 H01 P#101 Q#5011;
(Touch position machine)
G65 H01 P#102 Q#5006;

G0 X-0.5;

N100 G0 Y-10;
G31 X10 F250;
G65 H01 P#103 Q#5011;
G0 X-0.5;
(If X-axis position < threshold then GOTO)
G65 H84 P100 Q#103 R1;

G0 X2.5;

(Travel threshold exceeded, probe next axis)
G92 Y0;

G31 Y10 F800;
G0 Y-0.5;
G31 Y1 F4;

G92 Y0;

G65 H01 P#104 Q#5012;
G65 H01 P#105 Q#5007;

G0 Y-0.5;
G92 Y0;

N200 G0 X5;
G31 Y1 F250;
G65 H01 P#106 Q#5012;
G0 Y-0.5;
(If Y-axis position < threshold then GOTO)
G65 H84 P200 Q#106 R1;

(Clear part in case probe landed precisely on the corner)
G0 X2.5

G31 Y2.5 F250
G31 X-10 F250
G0 X1
G31 X-1 F4

G65 H01 P#107 Q#5011;
G65 H01 P#108 Q#5006;

G00 X1;

G53 G90 G0 Z0;

(Half of probe's effective tip diameter)
G65 H05 P#117 Q#2109 R2; 

G65 H02 P#113 Q#102 R#117; (Add tip radius to X1)
G65 H03 P#114 Q#108 R#117; (Subtract tip radius to X2)
G65 H02 P#115 Q#113 R#114;
(Calculate center point)
G65 H05 P#116 Q#115 R2;
G53 G90 G0 X#116;

M30