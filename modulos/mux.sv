`include "defines.sv"

module mux #(parameter int LENGTH) (
    input logic sel,
    input logic [LENGTH-1:0] in1, in2,
    output logic [LENGTH-1:0] out
);

    assign out = (sel == 0) ? in1 : in2;

endmodule