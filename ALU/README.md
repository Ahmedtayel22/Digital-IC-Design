# 16-bit Arithmetic Logic Unit (ALU) - ALU_TOP

## Introduction

ALU_TOP serves as the foundational building block of a processor, playing a vital role in executing a diverse set of functions:

- **Arithmetic Functions:** Performed through the ARITHMETIC_UNIT block.
- **Logic Functions:** Executed via the LOGIC_UNIT block.
- **Shift Functions:** Controlled by the SHIFT_UNIT block.
- **Comparison Functions:** Handled by the CMP_UNIT block.
- **Function Decoding:** The Decoder Unit enables specific functions based on the most significant 2 bits of the ALU_FUNC control bus (ALU_FUNC[3:2]).

## Specifications

### Core Characteristics

- **Registered Outputs:** All outputs from ALU_TOP are registered to ensure reliable and stable operation.
- **Reset Functionality:** Asynchronous active low reset signals are employed to clear all registers.
- **Functional Flags:**
  - **Arith_flag:** Activated to "High" exclusively during arithmetic operations, including addition, subtraction, multiplication, or division; otherwise, it remains "LOW."
  - **Logic_flag:** Raised to "High" only when the ALU executes Boolean operations like AND, OR, NAND, or NOR; otherwise, it stays "LOW."
  - **CMP_flag:** Set to "High" during comparison operations (Equal, Greater than, Less than) or when a NOP operation is performed; otherwise, it remains "LOW."
  - **Shift_flag:** Becomes "High" solely when the ALU engages in shifting operations, such as shift right or shift left; otherwise, it remains "LOW."
- **Function Selection:** ALU_TOP's operation is determined by the ALU_FUN input signal, as specified in the table below.

### Function Block Enable

- **Arith_Enable, Logic_Enable, SHIFT_Enable, and CMP_Enable:** These are block enable signals responsible for enabling or disabling the respective function blocks within ALU_TOP.

## Usage

The 16-bit ALU_TOP is a versatile and crucial component of a processor, capable of performing a wide range of operations. To integrate ALU_TOP into your project, please consult the provided documentation and resources for comprehensive implementation instructions and usage guidelines.

This README offers an introductory overview of ALU_TOP, highlighting its core specifications and functional components. For detailed technical insights, specific use cases, and practical implementations, refer to the accompanying documentation and resources related to ALU_TOP.
