module elevator(s1, s2, s3, f1, f2, f3, u1, u2, u3, d1, d2, d3, ac, display, doorOpen, clk);
    input s1, s2, s3, f1, f2, f3, u1, u2, u3, d1, d2, d3, clk;
    output reg [1:0] ac;
    output reg [1:0] display;
    output reg doorOpen;

    reg [2:0] reg_f;
    reg [2:0] reg_u;
    reg [2:0] reg_d;

    reg [3:0] state;

    always @(posedge f1) reg_f[1] = 1;
    always @(posedge f2) reg_f[2] = 1;
    always @(posedge f3) reg_f[3] = 1;
    always @(posedge u1) reg_u[1] = 1;
    always @(posedge u2) reg_u[2] = 1;
    always @(posedge u3) reg_u[3] = 1;
    always @(posedge d1) reg_d[1] = 1;
    always @(posedge d2) reg_d[2] = 1;
    always @(posedge d3) reg_d[3] = 1;

    always @(posedge clk, posedge s1, posedge s2, posedge s3) begin
        case (state)
            0: if (reg_f[2] || reg_f[3] || reg_d[2] || reg_d[3] || reg_u[2] || reg_u[3]) state = 1;
            
            1: begin
                if (s2) begin
                    if (reg_f[2] || reg_u[2]) state = 2;
                    else if (reg_f[3] || reg_u[3] || reg_d[3]) state = 3;
                    else if (reg_d[2]) state = 6;
                end
            end

            2: begin
                if (reg_f[3] || reg_u[3] || reg_d[3]) state = 3;
                else state = 8;
            end

            3: begin
                if (s3) state = 4;
            end

            4: begin
                if (reg_f[1] || reg_f[2] || reg_d[1] || reg_d[2] || reg_u[1] || reg_u[2]) state = 5;
            end

            5: begin
                if (s2) begin
                    if (reg_f[2] || reg_d[2]) state = 6;
                    else if (reg_f[1] || reg_u[1] || reg_d[1]) state = 7;
                    else if (reg_u[2]) state = 2;
                end
            end

            6: begin
                if (reg_f[1] || reg_u[1] || reg_d[1]) state = 7;
                else state = 8;
            end

            7: begin
                if (s1) state = 0;
            end

            8: begin
                if (reg_f[3] || reg_u[3] || reg_d[3] || reg_u[2]) state = 2;
                else if (reg_f[1] || reg_u[1] || reg_d[1] || reg_d[2]) state = 6;
            end
    end

endmodule
