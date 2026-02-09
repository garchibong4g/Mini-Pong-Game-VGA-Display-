# 🎮 Mini Pong Game – FPGA Project

This repository contains the **Verilog HDL source code, testbenches, and documentation** for a **real-time Pong game** implemented on a **Basys 3 FPGA board**. The project demonstrates **digital logic design, finite state machines (FSMs), and VGA graphics output** for embedded hardware systems.

---

## 📌 Project Overview

The Mini Pong Game integrates **digital logic**, **FSM-based control**, and **VGA timing management**. It features a paddle and ball controlled by FSMs, collision detection logic, and outputs a **640 × 480 @ 60Hz VGA display**. The design is modular and simulation-ready for hardware verification.

---

## 🛠️ Design

- Paddle and ball **FSMs** for movement and collision handling  
- **VGA synchronization** for horizontal and vertical scan lines  
- **Clock division** to generate a stable pixel clock  
- Modular design for **easy simulation and hardware testing**

---

## ⚙️ Hardware Components

- 🖥️ **Basys 3 FPGA Board** (Xilinx Artix-7)  
- 🟢 4-bit VGA output (RGB)  
- ⏹️ Push-button inputs for paddle movement  
- ⏱️ On-board 100 MHz system clock  

---

## 💻 Software

- Verilog HDL for:
  - Paddle and ball FSMs
  - Collision detection logic
  - VGA sync generation
- Testbenches for simulation and verification
- Clock division logic for pixel-level timing

---

## 📚 Libraries/Tools Used

- `Vivado` – FPGA synthesis and implementation  
- `ModelSim` – Simulation and waveform analysis  
- `Basys 3 Reference Manual` – Hardware timing specifications  

---

## 📋 Features

- 🕹️ Real-time paddle and ball control  
- 🔁 FSM-based movement and collision logic  
- 🖼️ VGA 640 × 480 display output  
- 🛠️ Modular and reusable Verilog code  
- ⚡ Smooth gameplay with synchronized clock division  

---

## 📦 Hardware Requirements

- Basys 3 FPGA board  
- VGA monitor  
- Push-buttons for input  
- Power supply for FPGA  

---

## 🖥️ Software Requirements

- Xilinx Vivado (or compatible FPGA IDE)  
- ModelSim or Vivado simulator  
- Text editor for Verilog coding  

---

## 🚀 Future Improvements

- Add **scoring and game reset functionality**  
- Implement **sound effects on collisions**  
- Expand to **multi-paddle or AI-controlled gameplay**  
- Optimize FSMs for **lower resource utilization**

---

## 🙏 Acknowledgements

- Digilent Basys 3 documentation  
- FPGA design tutorials and Verilog guides  
- Team members and mentors who provided guidance  

---

## ✍️ Authors

Developed as part of an **Electrical Engineering FPGA Project**.
