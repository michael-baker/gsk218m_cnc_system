O00007;
N100 G0 Y-10;
N101 G31 X15 F500;
N102 G65 H01 P#101 Q#5006; 
N103 G0 X-0.5;
(If X-axis position <= threshold then GOTO 100)
N104 G65 H83 P100 Q#101 R#150;
M99;