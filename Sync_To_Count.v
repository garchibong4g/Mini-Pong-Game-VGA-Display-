module Project10_Pong_Top
  (input  i_Clk,        // 100 MHz Basys 3 clock (W5)
   input  i_Switch_1,   // BTNU - P1 up
   input  i_Switch_2,   // BTND - P1 down
   input  i_Switch_3,   // BTNL - P2 up
   input  i_Switch_4,   // BTNR - P2 down
   input  i_Game_Start, // BTNC - start
   output o_VGA_HSync,
   output o_VGA_VSync,
   output [3:0] o_VGA_Red,
   output [3:0] o_VGA_Grn,
   output [3:0] o_VGA_Blu
   );

  parameter c_VIDEO_WIDTH = 3;
  parameter c_TOTAL_COLS  = 800;
  parameter c_TOTAL_ROWS  = 525;
  parameter c_ACTIVE_COLS = 640;
  parameter c_ACTIVE_ROWS = 480;

  wire w_Clk_25;
  wire w_HSync_VGA, w_VSync_VGA;
  wire w_HSync_Pong, w_VSync_Pong;
  wire w_Switch_1, w_Switch_2, w_Switch_3, w_Switch_4, w_Game_Start_db;

  wire [c_VIDEO_WIDTH-1:0] w_Red_Video_Pong, w_Red_Video_Porch;
  wire [c_VIDEO_WIDTH-1:0] w_Grn_Video_Pong, w_Grn_Video_Porch;
  wire [c_VIDEO_WIDTH-1:0] w_Blu_Video_Pong, w_Blu_Video_Porch;

  clk_wiz_0 clk_inst
    (.clk_in1(i_Clk),
     .clk_out1(w_Clk_25));

  VGA_Sync_Pulses #(.TOTAL_COLS(c_TOTAL_COLS),
                    .TOTAL_ROWS(c_TOTAL_ROWS),
                    .ACTIVE_COLS(c_ACTIVE_COLS),
                    .ACTIVE_ROWS(c_ACTIVE_ROWS)) VGA_Sync_Pulses_Inst
  (.i_Clk(w_Clk_25),
   .o_HSync(w_HSync_VGA),
   .o_VSync(w_VSync_VGA),
   .o_Col_Count(),
   .o_Row_Count());

  Debounce_Switch Switch_1 (.i_Clk(w_Clk_25), .i_Switch(i_Switch_1), .o_Switch(w_Switch_1));
  Debounce_Switch Switch_2 (.i_Clk(w_Clk_25), .i_Switch(i_Switch_2), .o_Switch(w_Switch_2));
  Debounce_Switch Switch_3 (.i_Clk(w_Clk_25), .i_Switch(i_Switch_3), .o_Switch(w_Switch_3));
  Debounce_Switch Switch_4 (.i_Clk(w_Clk_25), .i_Switch(i_Switch_4), .o_Switch(w_Switch_4));
  Debounce_Switch Switch_5 (.i_Clk(w_Clk_25), .i_Switch(i_Game_Start), .o_Switch(w_Game_Start_db));

  Pong_Top #(.c_TOTAL_COLS(c_TOTAL_COLS),
             .c_TOTAL_ROWS(c_TOTAL_ROWS),
             .c_ACTIVE_COLS(c_ACTIVE_COLS),
             .c_ACTIVE_ROWS(c_ACTIVE_ROWS),
             .c_VIDEO_WIDTH(c_VIDEO_WIDTH)) Pong_Inst
  (.i_Clk(w_Clk_25),
   .i_HSync(w_HSync_VGA),
   .i_VSync(w_VSync_VGA),
   .i_Game_Start(w_Game_Start_db),
   .i_Paddle_Up_P1(w_Switch_1),
   .i_Paddle_Dn_P1(w_Switch_2),
   .i_Paddle_Up_P2(w_Switch_3),
   .i_Paddle_Dn_P2(w_Switch_4),
   .o_HSync(w_HSync_Pong),
   .o_VSync(w_VSync_Pong),
   .o_Red_Video(w_Red_Video_Pong),
   .o_Grn_Video(w_Grn_Video_Pong),
   .o_Blu_Video(w_Blu_Video_Pong));

  VGA_Sync_Porch #(.VIDEO_WIDTH(c_VIDEO_WIDTH),
                   .TOTAL_COLS(c_TOTAL_COLS),
                   .TOTAL_ROWS(c_TOTAL_ROWS),
                   .ACTIVE_COLS(c_ACTIVE_COLS),
                   .ACTIVE_ROWS(c_ACTIVE_ROWS)) VGA_Sync_Porch_Inst
   (.i_Clk(w_Clk_25),
    .i_HSync(w_HSync_Pong),
    .i_VSync(w_VSync_Pong),
    .i_Red_Video(w_Red_Video_Pong),
    .i_Grn_Video(w_Grn_Video_Pong),
    .i_Blu_Video(w_Blu_Video_Pong),
    .o_HSync(o_VGA_HSync),
    .o_VSync(o_VGA_VSync),
    .o_Red_Video(w_Red_Video_Porch),
    .o_Grn_Video(w_Grn_Video_Porch),
    .o_Blu_Video(w_Blu_Video_Porch));

  assign o_VGA_Red = {w_Red_Video_Porch, 1'b0};
  assign o_VGA_Grn = {w_Grn_Video_Porch, 1'b0};
  assign o_VGA_Blu = {w_Blu_Video_Porch, 1'b0};

endmodule
