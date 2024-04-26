`include "defines.sv"

module instructionMem (
    input logic rst,
    input logic [`WORD_LEN-1:0] addr,
    output logic [`WORD_LEN-1:0] instruction
);

    localparam int INSTR_MEM_SIZE = `INSTR_MEM_SIZE;
    localparam int MEM_CELL_SIZE = `MEM_CELL_SIZE;

    logic [$clog2(INSTR_MEM_SIZE)-1:0] address;
    logic [MEM_CELL_SIZE-1:0] instMem [0:INSTR_MEM_SIZE-1];

    assign address = addr[$clog2(INSTR_MEM_SIZE)-1:0];

    always_comb begin
        if (rst) begin
            // No nop added in between instructions since there is a hazard detection unit
            instMem[0]   <= 8'b10000000; //-- Addi   r1,r0,10
            instMem[1]   <= 8'b00100000;
            instMem[2]   <= 8'b00000000;
            instMem[3]   <= 8'b00001010;
            // ... (resto del código omitido por brevedad)
            instMem[232] <= 8'b00000000; //-- NOPE
            instMem[233] <= 8'b00000000;
            instMem[234] <= 8'b00000000;
            instMem[235] <= 8'b00000000;
        end
    end

    assign instruction = {instMem[address], instMem[address + 1], instMem[address + 2], instMem[address + 3]};

endmodule