module compuerta (
    input zeroE, jumpE, branchE,
    output reg pcSrcE
);

    always @* begin
        // AND gate
        logic resAND;
        resAND = zeroE & branchE;
        
        // OR gate
        pcSrcE = jumpE | resAND;
    end

endmodule
