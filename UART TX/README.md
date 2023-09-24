![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/b99f1f93-f0cf-40ac-a7b3-486f0cc2c506)


![UART_TX](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/8b796b50-785a-47e0-8b70-fcca928584bc)

# UART Communication Overview

Serial communication plays a fundamental role in digital systems, with several prominent protocols like I2C, UART, and SPI in use. In this README, we focus on the Universal Asynchronous Receiver/Transmitter (UART) protocol, which is a crucial component for executing serial communication.

## UART Basics

UART operates as a full-duplex protocol, allowing simultaneous data transmission in both directions. It acts as a bridge between parallel and serial data formats, converting data accordingly for seamless communication.

- **Transmitting Data:** UART takes parallel data, often originating from a master device such as a CPU, and converts it into serial format before transmitting it to the receiving UART.
- **Receiving Data:** The receiving UART reverses this process, converting incoming serial data back into parallel data for the receiving device.

## UART Transmitting (UART TX)

For data to be transmitted by UART TX, it's essential for the Data_Valid Signal to be set high. A few key points to note:

- Registers within the UART can be cleared using an asynchronous active low reset signal.
- The Data_Valid Signal remains high for only one clock cycle.
- A busy signal is active as long as UART_TX is transmitting a data frame; it returns to a low state once the transmission is complete.
- During UART_TX processing, the P_DATA Bus cannot accept new data, even if the Data_Valid Signal is high.

## Idle and Configuration

- In the idle state, where no data transmission is occurring, the TX_OUT signal is set high.
- UART configuration includes parameters like PAR_EN, which enables or disables the frame parity bit (0 for disable, 1 for enable), and PAR_TYP, which determines the type of parity bit used (0 for even parity, 1 for odd parity). These configurations enhance UART's adaptability to various communication scenarios.

This README serves as an introductory guide to UART communication. For more detailed information and specific implementation details, please refer to the documentation and resources provided with your UART module or platform.
