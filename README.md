# RDM32-V Processor

> A 32-bit, 5-stage pipelined RISC-V processor capable of running Linux, compliant with the RISC-V RV32I specification.

---

## Overview

**RDM32-V** is a high-performance, 32-bit RISC-V processor featuring a classic 5-stage pipeline architecture.  
Designed for efficiency, Linux compatibility, and educational exploration, it offers a solid foundation for embedded systems and custom SoC development.

---

## Features(Hopefully)

- ✅ **RISC-V RV32I Instruction Set** compliant
- ✅ **5-Stage Pipeline**: Fetch, Decode, Execute, Memory Access, Writeback
- ✅ **Hazard Detection** and **Data Forwarding** support
- ✅ **Memory Management Unit (MMU)** for Linux compatibility
- ✅ **Exception and Interrupt Handling**
- ✅ **Supervisor (S) Mode Support**
- ✅ **Optional Floating Point (F) Extension**
- ✅ **Linux Kernel Booting** Supported
- ✅ Designed for **Area Efficiency** and **Performance**

---

## Pipeline Stages

1. **Instruction Fetch (IF)**
2. **Instruction Decode (ID)**
3. **Execute (EX)**
4. **Memory Access (MEM)**
5. **Writeback (WB)**

Each stage is carefully optimized to minimize stalls and maximize throughput using standard pipeline techniques.

---

## Project Structure (Planned)

```
/rtl           - Verilog RTL files
/tb            - Testbenches
/docs          - Design Documentation
/scripts       - Build and Simulation Scripts
/linux_support - Linux Bootloader and Support Files
```

---

## License

This project will be released under the **MIT License**.

---
