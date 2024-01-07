# GSK 218M CNC Controller
G-code probing snippets for a GSK218M CNC System

The G-code in the context of GSK218M.

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

This syntax is often referred to as MACRO A.

The default ladder has been modified to set variable #1015 when on the SKIP signal is triggered. This allows easy querying from programs to check if the probe is currently contacting a part and allows for a crude 'protected move'. 

There is a lag between the SKIP signal and the variable state changing. 
It is assumed this is due to the SKIP signal raising an interrupt to stop motion or the perhaps the variables are only refreshed in the second tier of the PLC ladder. To work around this a dwell is added after each G31 move to ensure the variable state is correct.

A controller issue prevents the use of G65 PXXXXX calls when a macro itself contains a G31 move and that move triggers a SKIP signal. In this situation the machine will alarm with 078 'program not found'. This situation makes it impossible to use the DRY principle and instead the macro(s) must be a monolithic.

Various workarounds have been attempted including 
-   Placing the macro(s) in the MACRO folder, SUB PROGRAM and PART directories 
-   Using different naming schemes (9xxxx prefix or 8xxxxx) 
-   Extra end of block statements
-   Extra dwells
None of these techniques change the behaviour.