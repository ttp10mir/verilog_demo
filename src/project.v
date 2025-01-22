/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Internal 8-bit counter register
    reg [7:0] counter;

    // Assign the counter value to dedicated output
    assign uo_out = counter;

    // IO output mirrors the counter value
    assign uio_out = counter;

    // IO enable is set to output mode (active high)
    assign uio_oe = 8'b11111111;

    // Counter logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset the counter to 0 when rst_n is low
            counter <= 8'b0;
        end else begin
            // Increment the counter on each clock cycle
            counter <= counter + 1;
        end
    end

endmodule
