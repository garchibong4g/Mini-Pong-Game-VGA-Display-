# Two-Player Pong on FPGA (Basys 3 / Artix-7)

A fully playable two-player Pong game written in Verilog for the Digilent Basys 3
(Xilinx Artix-7). The game renders to a monitor over VGA at 640×480 @ 60 Hz, with
two players controlling paddles via the on-board push buttons.

> Game logic adapted from [Nandland's open-source Project 10](https://nandland.com)
> and ported to the Basys 3 (Artix-7) with MMCM-based clocking, 4-bit-per-channel
> color mapping, custom constraints, and hardware bring-up.

## Demo

*(Add a photo/GIF of the board driving a monitor here.)*

## Features

- 640×480 @ 60 Hz VGA output
- 25 MHz pixel clock generated from the 100 MHz system clock via an MMCM
  (Vivado Clocking Wizard)
- Two-player paddle control with on-board push buttons
- Ball physics with wall and paddle reflection
- Finite state machine for game flow and scoring
- Debounced button inputs
- Single clock domain (no CDC) across the entire video + game pipeline

## Hardware

| | |
|---|---|
| Board | Digilent Basys 3 |
| FPGA | Xilinx Artix-7 `xc7a35tcpg236-1` |
| System clock | 100 MHz (W5) |
| Pixel clock | 25 MHz (MMCM) |
| Display | 640×480 @ 60 Hz, 12-bit color over VGA |
| Toolchain | Xilinx Vivado 2025.2 |

## Controls

| Button | Action |
|--------|--------|
| BTNC (center) | Start round |
| BTNU / BTND | Player 1 paddle up / down |
| BTNL / BTNR | Player 2 paddle up / down |

## Architecture

```
Project10_Pong_Top        top level: I/O, clocking, color mapping
├── clk_wiz_0             MMCM, 100 MHz -> 25 MHz pixel clock
├── VGA_Sync_Pulses       HSync / VSync generation
├── Debounce_Switch x5    button debouncing
├── Pong_Top              game core
│   ├── Sync_To_Count     row/col counters aligned to sync
│   ├── Pong_Paddle_Ctrl  paddle position + draw (x2)
│   ├── Pong_Ball_Ctrl    ball position, bounce, draw
│   └── FSM               IDLE / RUNNING / P1_WINS / P2_WINS / CLEANUP
└── VGA_Sync_Porch        front/back porch + video pipeline alignment
```

The pixel counters are divided by 16 to form a 40×30 tile grid; all game objects
operate in this coordinate space. Each object outputs a "draw" signal; these are
OR-ed to decide whether a pixel is lit, then mapped to the Basys 3's 4-bit-per-
channel VGA pins.

## Repository Layout

```
src/
  Project10_Pong_Top.v    top level
  Pong_Top.v              game core + FSM
  Pong_Paddle_Ctrl.v      paddle control
  Pong_Ball_Ctrl.v        ball control
  Debounce_Switch.v       button debouncer
  VGA_Sync_Pulses.v       sync generation
  Sync_To_Count.v         sync -> row/col counters
  VGA_Sync_Porch.v        porch timing + video alignment
constraints/
  pong.xdc                Basys 3 pin + clock constraints
ip/
  clk_wiz_0               Clocking Wizard (MMCM) IP
docs/
  Pong_FPGA_Project_Documentation.md   full design writeup
```

## Build & Run

1. Open the project in Vivado 2025.2 (target `xc7a35tcpg236-1`).
2. Generate the `clk_wiz_0` IP output products if not already present
   (Generate Output Products → Global).
3. Set `Project10_Pong_Top` as the top module.
4. Run synthesis → implementation → **Generate Bitstream**.
5. Open Hardware Manager → Open Target → Auto Connect → Program Device.
6. Connect a monitor to the VGA port, press the center button to start, and play.

## Notes

- The pixel clock is generated with an MMCM rather than a counter-based divider,
  placing it on dedicated clock-management hardware and global routing for clean
  timing — the correct approach for a real design.
- The VGA timing front end (sync pulses, sync-to-count, porch) is modular and is
  reused from a companion VGA test-pattern project.

## Possible Improvements

- Seven-segment scorekeeping (P1 left digits, P2 right digits)
- Per-object color and UART-selectable color palettes
- Block RAM framebuffer for a larger playfield
- Variable bounce angle based on paddle contact point

## License / Attribution

Game logic adapted from Nandland's open-source FPGA course material (Project 10).
Basys 3 port, MMCM clocking, constraints, and hardware integration by the author.
