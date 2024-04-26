module mux_3input #(parameter int LENGTH) (
    input logic [LENGTH-1:0] in1, in2, in3,
    input logic [1:0] sel,
    output logic [LENGTH-1:0] out
);

    assign out = (sel == 2'b00) ? in1 :
                 (sel == 2'b01) ? in2 : in3;

endmodule