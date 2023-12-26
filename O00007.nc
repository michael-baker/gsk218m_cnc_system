O00007
(Centre of boss probe routine for GSK218M);

G21;
G91;
G54;

(Save X-axis position to G54);
G65 H01 P#5206 Q#5006;

(Travel threshold 1%)
G65 H01 P#149 Q1.01;

(Double touch in negative X direction)
(Fast probe to approximate position)
(Slow probe for accurate position)
(Assign axis position to #101)
G31 X10 F800; 
G00 X-0.5;
G31 X10 F4; 
G65 H01 P#101 Q#5006; 

(Target position = (current + threshold %)
G65 H04 P#150 Q#5006 R#149;

G00 X-0.5;

N100 G0 Y-10;
G31 X10 F250;
G65 H01 P#101 Q#5006;
G0 X-0.5;
(If X-axis position <= threshold then GOTO)
G65 H86 P100 Q#101 R#150;

(Travel threshold exceeded, probe next axis)
G31 Y10 F800;
G00 Y-0.5;
G31 Y1 F4;
G65 H01 P#102 Q#5007;

(Target position = (current + threshold %)
G65 H04 P#151 Q#102 R#149;

G00 Y-0.5;

N200 G0 X10;
G31 Y1 F4;
G65 H01 P#102 Q#5007;
G0 Y-0.5;
(If Y-axis position <= threshold then GOTO)
G65 H86 P200 Q#102 R#151;

M30