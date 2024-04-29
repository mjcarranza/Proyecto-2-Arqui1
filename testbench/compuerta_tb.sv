module compuerta_tb;
    // Inputs
    reg zeroE, jumpE, branchE;
    // Output
    wire pcSrcE;

    // Instantiate the compuerta module
    compuerta dut(
        .zeroE(zeroE),
        .jumpE(jumpE),
        .branchE(branchE),
        .pcSrcE(pcSrcE)
    );

    // Stimulus
    initial begin
        // Test case 1
        zeroE = 1'b0; jumpE = 1'b0; branchE = 1'b0;
        #10;
        // Test case 2
        zeroE = 1'b1; jumpE = 1'b0; branchE = 1'b0;
        #10;
        // Test case 3
        zeroE = 1'b0; jumpE = 1'b1; branchE = 1'b0;
        #10;
        // Test case 4
        zeroE = 1'b0; jumpE = 1'b0; branchE = 1'b1;
        #10;
        // Test case 5
        zeroE = 1'b1; jumpE = 1'b1; branchE = 1'b1;
        #10;
        // Test case 6
        zeroE = 1'b1; jumpE = 1'b1; branchE = 1'b0;
        #10;
        // Test case 7
        zeroE = 1'b0; jumpE = 1'b1; branchE = 1'b1;
        #10;
        // Test case 8
        zeroE = 1'b1; jumpE = 1'b0; branchE = 1'b1;
        #10;
        // Test case 9
        zeroE = 1'b1; jumpE = 1'b0; branchE = 1'b0;
        #10;
        // Test case 10
        zeroE = 1'b0; jumpE = 1'b1; branchE = 1'b0;
        #10;
        // End simulation
        
    end
endmodule