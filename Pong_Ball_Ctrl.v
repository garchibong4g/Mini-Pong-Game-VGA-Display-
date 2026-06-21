module Pong_Paddle_Ctrl
  #(parameter c_PLAYER_PADDLE_X=0,
    parameter c_PADDLE_HEIGHT=6,
    parameter c_GAME_HEIGHT=30)
  (input            i_Clk,
   input [5:0]      i_Col_Count_Div,
   input [5:0]      i_Row_Count_Div,
   input            i_Paddle_Up,
   input            i_Paddle_Dn,
   output reg       o_Draw_Paddle,
   output reg [5:0] o_Paddle_Y);

  parameter c_PADDLE_SPEED = 1250000;
  reg [31:0] r_Paddle_Count = 0;
  wire w_Paddle_Count_En;

  assign w_Paddle_Count_En = i_Paddle_Up ^ i_Paddle_Dn;

  always @(posedge i_Clk)
  begin
    if (w_Paddle_Count_En == 1'b1)
    begin
      if (r_Paddle_Count == c_PADDLE_SPEED)
        r_Paddle_Count <= 0;
      else
        r_Paddle_Count <= r_Paddle_Count + 1;
    end

    if (i_Paddle_Up == 1'b1 && r_Paddle_Count == c_PADDLE_SPEED && o_Paddle_Y !== 0)
      o_Paddle_Y <= o_Paddle_Y - 1;
    else if (i_Paddle_Dn == 1'b1 && r_Paddle_Count == c_PADDLE_SPEED &&
             o_Paddle_Y !== c_GAME_HEIGHT-c_PADDLE_HEIGHT-1)
      o_Paddle_Y <= o_Paddle_Y + 1;
  end

  always @(posedge i_Clk)
  begin
    if (i_Col_Count_Div == c_PLAYER_PADDLE_X && i_Row_Count_Div >= o_Paddle_Y &&
        i_Row_Count_Div <= o_Paddle_Y + c_PADDLE_HEIGHT)
      o_Draw_Paddle <= 1'b1;
    else
      o_Draw_Paddle <= 1'b0;
  end

endmodule
