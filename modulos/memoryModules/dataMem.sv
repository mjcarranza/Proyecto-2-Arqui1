`include "defines.sv"

module dataMem (
    input logic clk, rst, readEn, writeEn,
    input logic [`WORD_LEN-1:0] address, dataIn,
    output logic [`WORD_LEN-1:0] dataOut
);

    localparam int DATA_MEM_SIZE = `DATA_MEM_SIZE;
    localparam int MEM_CELL_SIZE = `MEM_CELL_SIZE;

    logic [MEM_CELL_SIZE-1:0] dataMem [0:DATA_MEM_SIZE-1];
    logic [`WORD_LEN-1:0] base_address;

    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < DATA_MEM_SIZE; i++) begin
                dataMem[i] <= '0;
            end
        end else if (writeEn) begin
            {dataMem[base_address], dataMem[base_address + 1], dataMem[base_address + 2], dataMem[base_address + 3]} <= dataIn;
        end
    end

    assign base_address = ((address & 32'h1FFFFFFC) >> 2) << 2;
    assign dataOut = (address < 1024) ? '0 : {dataMem[base_address], dataMem[base_address + 1], dataMem[base_address + 2], dataMem[base_address + 3]};

endmodule