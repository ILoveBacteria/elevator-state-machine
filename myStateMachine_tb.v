`include "myStateMachine.v"

module elevator_tb ();
    wire [1:0] ac;
    wire [1:0] display;
    wire doorOpen;

    reg s1, s2, s3, f1, f2, f3, u1, u2, u3, d1, d2, d3, clk, rst;

    elevator elevator(s1, s2, s3, f1, f2, f3, u1, u2, u3, d1, d2, d3, clk, rst, ac, display, doorOpen); 

    initial begin 
        forever begin
            #10 clk = ~clk;
        end 
    end

    initial begin
        rst = 0;
        clk = 0;
        s1 = 0;
        s2 = 0;
        s3 = 0;
        f1 = 0;
        f2 = 0;
        f3 = 0;
        u1 = 0;
        u2 = 0;
        u3 = 0;
        d1 = 0;
        d2 = 0;
        d3 = 0;

        // test case 1
        #30
        u2 = 1; #1 u2 = 0; // user pressed up button in floor 2
        #100 s2 = 1; #1 s2 = 0; // elevator arrived at floor 2

        // test case 2
        #30
        u3 = 1; #1 u3 = 0; // user pressed up button in floor 3
        #100 s3 = 1; #1 s3 = 0; // elevator arrived at floor 3
        f1 = 1; #1 f1 = 0; // user pressed floor 1 button
        #100 s2 = 1; #1 s2 = 0; // elevator arrived at floor 2 
        #100 s1 = 1; #1 s1 = 0; // elevator arrived at floor 1

        // test case 3
        #30
        d3 = 1; #1 d3 = 0; // user pressed down button in floor 3
        #50 u2 = 1; #1 u2 = 0; // another user pressed up button in floor 2
        #50 s2 = 1; #1 s2 = 0; // elevator arrived at floor 2
        #100 s3 = 1; #1 s3 = 0; // elevator arrived at floor 3

        // test case 4
        #30
        rst = 1; #50 rst = 0; // reset
    end

endmodule

