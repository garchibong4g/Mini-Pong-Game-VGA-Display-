`timescale 1ns/1ps
module minipong(
    input wire clk,
    input wire rst,
    input wire up,
    input wire down,
    output reg hsync,
    output reg vsync,
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue
);

    localparam H_VISIBLE = 640, H_FRONT = 16, H_SYNC = 96, H_BACK = 48;
    localparam V_VISIBLE = 480, V_FRONT = 10, V_SYNC = 2, V_BACK = 33;
    localparam H_TOTAL = H_VISIBLE + H_FRONT + H_SYNC + H_BACK;
    localparam V_TOTAL = V_VISIBLE + V_FRONT + V_SYNC + V_BACK;

    localparam PADDLE_X = 20;
    localparam PADDLE_HEIGHT = 60;
    localparam PADDLE_SPEED = 2;
    localparam BALL_SIZE = 8;

    reg [1:0] clk_div;
    wire pixel_clk = clk_div[1];
    always @(posedge clk or posedge rst)
        clk_div <= rst ? 0 : clk_div + 1;

    reg [9:0] h_count, v_count;
    always @(posedge pixel_clk or posedge rst) begin
        if (rst) begin
            h_count <= 0;
            v_count <= 0;
        end else begin
            if (h_count == H_TOTAL-1) begin
                h_count <= 0;
                v_count <= (v_count == V_TOTAL-1) ? 0 : v_count + 1;
            end else
                h_count <= h_count + 1;
        end
    end

    always @(posedge pixel_clk) begin
        hsync <= ~(h_count >= (H_VISIBLE + H_FRONT) && h_count < (H_VISIBLE + H_FRONT + H_SYNC));
        vsync <= ~(v_count >= (V_VISIBLE + V_FRONT) && v_count < (V_VISIBLE + V_FRONT + V_SYNC));
    end

    // Paddle FSM
    reg [9:0] paddle_y;
    reg [1:0] paddle_state;
    localparam P_IDLE = 2'b00, P_UP = 2'b01, P_DOWN = 2'b10;

    always @(posedge pixel_clk or posedge rst) begin
        if (rst) begin
            paddle_y <= 210;
            paddle_state <= P_IDLE;
        end else begin
            case (paddle_state)
                P_IDLE:
                    if (up && paddle_y > 0) paddle_state <= P_UP;
                    else if (down && paddle_y < V_VISIBLE-PADDLE_HEIGHT) paddle_state <= P_DOWN;
                P_UP: if (!(up && paddle_y > 0)) paddle_state <= P_IDLE;
                P_DOWN: if (!(down && paddle_y < V_VISIBLE-PADDLE_HEIGHT)) paddle_state <= P_IDLE;
            endcase

            case (paddle_state)
                P_UP: paddle_y <= paddle_y - PADDLE_SPEED;
                P_DOWN: paddle_y <= paddle_y + PADDLE_SPEED;
                P_IDLE: paddle_y <= paddle_y;
            endcase
        end
    end

    // Ball FSM
    reg [9:0] ball_x, ball_y;
    reg [1:0] ball_state;
    localparam UP_LEFT = 2'b00, UP_RIGHT = 2'b01, DOWN_LEFT = 2'b10, DOWN_RIGHT = 2'b11;

    always @(posedge pixel_clk or posedge rst) begin
        if (rst) begin
            ball_x <= 320;
            ball_y <= 240;
            ball_state <= DOWN_RIGHT;
        end else begin
            case (ball_state)
                UP_LEFT: begin
                    ball_x <= ball_x - 1;
                    ball_y <= ball_y - 1;
                    if (ball_y <= 0) ball_state <= DOWN_LEFT;
                    else if (ball_x <= PADDLE_X+8 && ball_y >= paddle_y && ball_y < paddle_y+PADDLE_HEIGHT) ball_state <= UP_RIGHT;
                    else if (ball_x >= H_VISIBLE-BALL_SIZE) ball_state <= UP_LEFT;
                end
                UP_RIGHT: begin
                    ball_x <= ball_x + 1;
                    ball_y <= ball_y - 1;
                    if (ball_y <= 0) ball_state <= DOWN_RIGHT;
                    else if (ball_x <= PADDLE_X+8 && ball_y >= paddle_y && ball_y < paddle_y+PADDLE_HEIGHT) ball_state <= UP_LEFT;
                    else if (ball_x >= H_VISIBLE-BALL_SIZE) ball_state <= UP_LEFT;
                end
                DOWN_LEFT: begin
                    ball_x <= ball_x - 1;
                    ball_y <= ball_y + 1;
                    if (ball_y >= V_VISIBLE-BALL_SIZE) ball_state <= UP_LEFT;
                    else if (ball_x <= PADDLE_X+8 && ball_y >= paddle_y && ball_y < paddle_y+PADDLE_HEIGHT) ball_state <= DOWN_RIGHT;
                    else if (ball_x >= H_VISIBLE-BALL_SIZE) ball_state <= DOWN_LEFT;
                end
                DOWN_RIGHT: begin
                    ball_x <= ball_x + 1;
                    ball_y <= ball_y + 1;
                    if (ball_y >= V_VISIBLE-BALL_SIZE) ball_state <= UP_RIGHT;
                    else if (ball_x <= PADDLE_X+8 && ball_y >= paddle_y && ball_y < paddle_y+PADDLE_HEIGHT) ball_state <= DOWN_LEFT;
                    else if (ball_x >= H_VISIBLE-BALL_SIZE) ball_state <= DOWN_LEFT;
                end
            endcase
        end
    end

    // Draw paddle and ball
    always @(posedge pixel_clk) begin
        red <= 0; green <= 0; blue <= 0;

        if (h_count >= PADDLE_X && h_count < PADDLE_X+8 && v_count >= paddle_y && v_count < paddle_y+PADDLE_HEIGHT)
            green <= 15;

        if (h_count >= ball_x && h_count < ball_x+BALL_SIZE && v_count >= ball_y && v_count < ball_y+BALL_SIZE)
            red <= 15;
    end

endmodule