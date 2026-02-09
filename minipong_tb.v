`timescale 1ns/1ps

`include "mini_pong.v"
module minipong_tb;

    reg clk;
    reg rst;
    reg up;
    reg down;
    wire hsync, vsync;
    wire [3:0] red, green, blue;

    // Instantiate the Pong module
    minipong uut (
        .clk(clk),
        .rst(rst),
        .up(up),
        .down(down),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );

    // Clock generation: 100 MHz
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns period

    initial begin
        // Initialize inputs
        rst = 1;
        up = 0;
        down = 0;

        // Apply reset
        #20;
        rst = 0;

        // Simulate paddle moving up for a while
        #50;
        up = 1;
        #100;
        up = 0;

        // Paddle moving down
        #50;
        down = 1;
        #100;
        down = 0;

        // Let the simulation run for a bit to watch ball movement
        #500;

        $finish;
    end

    // Optional: monitor some signals
    initial begin
        $monitor("Time: %0t | Paddle_y: %0d | Ball_x: %0d | Ball_y: %0d | Ball_state: %b", 
                  $time, uut.paddle_y, uut.ball_x, uut.ball_y, uut.ball_state);
    end

endmodule