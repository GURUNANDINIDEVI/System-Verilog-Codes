//T.Guru Nandini Devi
//nandinidevitekumudi@gmail.com
module axi_lite_master (
    output [31:0] AWADDR, WDATA,
    output        AWVALID, WVALID, BREADY,
    input         AWREADY, WREADY, BVALID
);
    assign AWADDR  = 32'h0000_4140;
    assign WDATA   = 32'h1A2B_3C4D;
    assign AWVALID = 1'b1;
    assign WVALID  = 1'b1;
    assign BREADY  = 1'b1;
endmodule

module axi_lite_slave (
    input         ACLK, ARESETN,
    input  [31:0] AWADDR, WDATA,
    input         AWVALID, WVALID, BREADY,
    output reg    AWREADY, WREADY, BVALID,
    output [1:0]  BRESP,
    output [31:0] reg_out
);
    reg [31:0] reg0;
   // reg        write_en;

    assign BRESP   = 2'b00;
    assign reg_out = reg0;

    always @(posedge ACLK or negedge ARESETN) begin
        if (!ARESETN) begin
            AWREADY <= 0;
            WREADY  <= 0;
            BVALID  <= 0;
           // write_en <= 0;
            reg0    <= 32'h00000000;
        end else begin
            // Accept write address
            if (!AWREADY && AWVALID)
                AWREADY <= 1;
            else
                AWREADY <= 0;

            // Accept write data
            if (!WREADY && WVALID)
                WREADY <= 1;
            else
                WREADY <= 0;

            // Latch data only if both handshakes occurred
            if (AWVALID && AWREADY && WVALID && WREADY && !BVALID) begin
                reg0 <= WDATA;
                BVALID <= 1;
            end

            // Clear BVALID after master accepts response
            if (BVALID && BREADY)
                BVALID <= 0;
        end
    end
endmodule
