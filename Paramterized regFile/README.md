# 8 x 16 Register File in Verilog

## Register File Overview

The 8 x 16 Register File is a fundamental component designed in Verilog, consisting of eight registers, each with a width of 16 bits. This Register File incorporates essential data buses for reading (RdData) and writing (WrData), as well as a single shared address bus (Address) used for both read and write operations.

## Block Interface
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/c79458fe-45ce-4b3e-94f8-33aede72cfbd)


### Register Access

Registers within the file can be accessed by specifying the desired register address. Notably, only one operation, either read or write, can be performed at any given time. 

- **Write Operation:** Writing to a register occurs when the Write Enable (WrEn) signal is high. 
- **Read Operation:** Reading from a register takes place when the Read Enable (RdEn) signal is high.

### Synchronization and Reset

All register file operations, including read and write, are synchronized to the positive edge of the Clock signal. To ensure a clean and consistent state, all registers within the file can be cleared using the Asynchronous Active Low Reset signal.

## Usage

The 8 x 16 Register File is a versatile component that can be integrated into various digital designs. To incorporate this Register File into your Verilog-based project, refer to the provided documentation and resources for detailed implementation instructions and usage guidelines.

This README offers an introductory overview of the 8 x 16 Register File, outlining its core specifications and functionalities. For more comprehensive technical details, specific use cases, and practical implementations, please consult the accompanying documentation and resources related to the Register File.
