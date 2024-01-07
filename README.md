# gsk218m_cnc_system
GCode snippets and tooling for a GSK218M CNC System


The G-code in the context of GSK218M CNC system

The GSK218M CNC system uses several macro commands in conjunction with the G65 command. 
These macro commands are identified by the H code and each performs a specific arithmetic or logical operation. Here's a list of these macro commands and their functions:

    H01: Value assignment (#i = #j). This macro assigns the value of variable #j to variable #i.

    H02: Addition (#i = #j + #k). This macro adds the values of variables #j and #k and stores the result in variable #i.

    H03: Subtraction (#i = #j - #k). This macro subtracts the value of variable #k from variable #j and stores the result in variable #i.

    H04: Multiplication (#i = #j * #k). This macro multiplies the values of variables #j and #k and stores the result in variable #i.

    H05: Division (#i = #j / #k). This macro divides the value of variable #j by variable #k and stores the result in variable #i​
    ​

Each of these macros is called by using the G65 command followed by the macro identifier (H01, H02, etc.) and the necessary parameters.
For example, to add two variables using the H02 macro, you would use a command like G65 H02 P#i Q#j R#k, where P#i is the variable to store the result, Q#j and R#k are the variables whose values are to be added.

This syntax is refered to as MACRO A.

A controller bug prevents the use of G65 PXXXXX calls when a macro itself contains a G31 move. In this situation the machine alarm with 078 'program not found'.
This situation makes it impossible to us the DRY princuple and instead the macro must be a single monolithic program.

I have attempted placing the macro(s) in the MACRO folder, SUB PROGRAM and PART directories as well as using different naming schemes (9xxxx prefix or 8xxxxx) prefix but this does not workaround the behaviour. 

Center measurement
o External diameter
o Internal diameter
o External length - width
o Internal length - width
o Depth of a feature
o Angle of a feature
