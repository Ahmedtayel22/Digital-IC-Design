# 16-bit Arithmetic Logic Unit (ALU)

## Introduction

The 16-bit Arithmetic Logic Unit (ALU) serves as a foundational component within a processor, responsible for executing a wide range of operations, including arithmetic calculations, logical functions, shifts, and comparisons.

## Specification

### Key Components

- **ALU Operands (A, B):** The ALU accepts two 16-bit operands, denoted as A and B.
- **ALU Result (ALU_OUT):** The output of the ALU, also 16 bits wide, is referred to as ALU_OUT. It is registered to ensure stability and reliability.

### ALU Functionality

The ALU carries out its operations based on the value of the ALU_FUN input signal, as defined in the table below. If the ALU_FUN input signal specifies an operation not listed in the table, the ALU_OUT result must be 16’b0.

### Flags

- **Arith_flag:** This flag is set to "High" only when the ALU performs one of the arithmetic operations, which include addition, subtraction, multiplication, or division; otherwise, it remains "LOW."
- **Logic_flag:** The Logic_flag is activated "High" exclusively during Boolean operations, such as AND, OR, NAND, NOR, XOR, or XNOR; otherwise, it remains "LOW."
- **CMP_flag:** When the ALU executes a comparison operation (Equal, Greater than, Less than), the CMP_flag is set to "High"; otherwise, it remains "LOW."
- **Shift_flag:** This flag becomes "High" only when the ALU is engaged in shifting operations, such as shift right or shift left; otherwise, it stays "LOW."

## Usage

The 16-bit ALU is a fundamental component of a processor and can be seamlessly integrated into various digital designs. To incorporate this ALU into your project, please refer to the accompanying documentation and resources for comprehensive implementation instructions and usage guidance.

This README provides an introductory overview of the 16-bit ALU, highlighting its core specifications and functional characteristics. For in-depth technical details, specific use cases, and practical implementations, please consult the associated documentation and resources related to the ALU.
