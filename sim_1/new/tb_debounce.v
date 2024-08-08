`timescale 1ns / 1ps

module tb_debounce();
    reg clk;
    reg reset;
    reg i_btn;
    wire o_btn;

    debounce dut_debounce(
        .clk(clk),
        .reset(reset),
        .i_btn(i_btn),
        .o_btn(o_btn)
    );

    // gen clk
    always #5 clk = ~clk; // clk period = 10ns

    initial begin
        #00 clk = 0; reset = 1; i_btn = 0;
        #10 reset = 0;
        #100 i_btn = 1;
        // #5반복 : 채터링 생겼다고 가정한 것.
        #5 i_btn = 0;
        #5 i_btn = 1;
        #5 i_btn = 0;
        #5 i_btn = 0;
        #5 i_btn = 0;
        #5 i_btn = 1;
        #5 i_btn = 1; // 1로 쭉 유지
        #200 i_btn = 0; // 손을 뗌
        #100 $finish;
    end
endmodule
