# CSE_Bubble

**Course Project under Prof. Urbi Chatterjee, Dept. of CSE, IIT Kanpur**

CSE_Bubble is a processor simulator designed to execute MIPS assembly code. The processor operates through a 5-stage pipeline, each stage responsible for different aspects of instruction execution. This architecture helps in understanding how modern processors handle and execute instructions.

## Stages of Execution

### 1. Instruction Fetch Phase
- **Objective:** Fetch instructions from instruction memory.
- **Details:** The program counter (PC) is used to retrieve the next instruction to be executed. The fetched instruction is then passed to the decoding phase. The instruction memory is designed to store the MIPS instructions that the processor will execute sequentially.

### 2. Decoding Phase
- **Objective:** Decode the instruction to determine its type and the required operations.
- **Details:** The fetched instruction is parsed based on its opcode. This phase identifies the instruction type (R-type, I-type, or J-type) and extracts necessary operands. The decoding process also involves identifying control signals for the subsequent phases.

### 3. Memory Access Phase
- **Objective:** Access data from the main memory.
- **Details:** For instructions that involve data memory operations (such as `load` and `store`), the effective address is calculated, and data is accessed from the memory  if needed. 

### 4. Arithmetic Logic Unit Phase
- **Objective:** Perform arithmetic and logical operations.
- **Details:** The Arithmetic Logic Unit (ALU) performs the required operations based on the decoded instruction. This phase handles operations such as addition, subtraction, logical AND/OR, and comparisons. The ALU output is then prepared for the memory write phase or used as a result.

### 5. Memory Write Phase
- **Objective:** Write the results back to the main memory or registers.
- **Details:** The result from the ALU is written back to the memory or updated in the processor's register file. For store instructions, data is written to memory. For instructions that modify registers, the register file is updated accordingly.

## Features
- **Pipeline Architecture:** Simulates a 5-stage pipeline to understand the flow of instructions through various stages.
- **MIPS Instruction Set:** Supports a range of MIPS instructions including arithmetic, logical, memory, and control instructions.
