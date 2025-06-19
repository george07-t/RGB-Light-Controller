# RGB Light Controller (FPGA/Verilog)

## Overview
This project implements a fully-featured RGB LED controller using Verilog, designed for FPGA platforms. The controller allows users to adjust brightness, select and mix colors, apply fade-in/fade-out effects, and activate preset color patterns. The design is modular, testable, and suitable for digital system design labs or embedded hardware projects.

## Features
- **Brightness Control:** Increment or decrement LED brightness.
- **Color Selection:** Choose Red, Green, Blue, or any combination (including white and off).
- **Fade In/Out:** Smoothly transition brightness up or down.
- **Preset Patterns:** Cycle through predefined color patterns and effects.
- **PWM Output:** Dimming control for LEDs using Pulse Width Modulation.
- **Memory Storage:** Store and recall RGB values for persistent settings.
- **Testbenches:** Simulation files for verifying each module and the full system.

## Directory Structure
```
RGB_Controller/
├── breadboard/
│   ├── src/
│   │   ├── addition8bit.v
│   │   ├── ALU.v
│   │   ├── alubreadboard.v
│   │   ├── breadboard.v
│   │   ├── clk_gen.v
│   │   ├── control_logic.v
│   │   ├── controlunit.v
│   │   ├── decoder.v
│   │   ├── dflipflop.v
│   │   ├── fulladder.v
│   │   ├── membreadboard.v
│   │   ├── memory.v
│   │   ├── memory8bit.v
│   │   ├── memoryunit.v
│   │   ├── pwmbreadboard.v
│   │   ├── pwmgen.v
│   │   ├── rgb_processor_tb.v
│   │   ├── RGB_processor.v
│   │   ├── sequenceckt.v
│   │   ├── subtraction8bit.v
│   │   └── ...
│   └── ...
├── README.md
├── library.cfg
├── RGB_Controller.aws
├── RGB_Controller.wsw
└── ...
```

## Main Modules
- **ALU.v:** 8-bit arithmetic logic unit for color/brightness operations.
- **addition8bit.v, subtraction8bit.v, fulladder.v:** Arithmetic building blocks.
- **memory.v, memory8bit.v, memoryunit.v:** Store RGB values and settings.
- **control_logic.v, controlunit.v:** State machine and main controller logic.
- **decoder.v, sequenceckt.v:** State decoding and sequencing.
- **pwmgen.v:** PWM signal generator for LED dimming.
- **RGB_processor.v:** Integrates ALU and memory for RGB control.
- **breadboard.v, alubreadboard.v, membreadboard.v, rgb_processor_tb.v:** Testbenches for simulation and verification.

## How It Works
1. **User Inputs:** Buttons or switches control brightness, color, fade, and preset patterns.
2. **State Machine:** Determines the current mode (e.g., brightness up, color select, fade, preset).
3. **ALU:** Performs arithmetic for adjusting color and brightness.
4. **Memory:** Stores the current RGB values for persistence.
5. **PWM Generator:** Outputs modulated signals to control LED brightness.
6. **Testbenches:** Used to verify the correct operation of each module and the overall system.

## Usage
1. **Simulation:**
   - Use the provided testbenches (e.g., `breadboard.v`, `rgb_processor_tb.v`) with your Verilog simulator (ModelSim, Vivado, etc.) to verify functionality.
2. **Synthesis:**
   - Synthesize the top-level module (`RGB_processor.v` or `controlunit.v`) for your FPGA board.
   - Connect physical buttons/switches to the input pins as per your board's constraints.
   - Connect the PWM outputs to RGB LED pins.

## Inputs and Controls
- **Brightness Up/Down:** Increases or decreases the intensity of the LEDs.
- **Color Select:** Cycles through Red, Green, Blue, and their combinations.
- **Fade In/Out:** Gradually increases or decreases brightness.
- **Preset:** Activates predefined color patterns (e.g., blinking, cycling).
- **On/Off:** Turns the LED system on or off.

## Customization
- Modify the state machine in `control_logic.v` to add new effects or patterns.
- Adjust PWM parameters in `pwmgen.v` for different dimming resolutions.
- Expand memory modules for more complex color storage.

## Authors
- [Your Name Here]
- [Lab Partners, if any]

## License
This project is for educational purposes. Please credit the original authors if reused or modified.

---

For questions or improvements, please open an issue or contact the maintainer.
