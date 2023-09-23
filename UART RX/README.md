# Serial Communication Overview

Serial communication encompasses various protocols like I2C, UART, and SPI, each serving unique purposes in digital systems. This README delves into the Universal Asynchronous Receiver/Transmitter (UART), a critical circuitry component dedicated to serial communication.

## UART Essentials

A Universal Asynchronous Receiver/Transmitter (UART) is a specialized hardware module responsible for facilitating serial communication. Notably, UART operates as a full-duplex protocol, enabling simultaneous data transmission in both directions.

### Data Transmission and Reception

In UART communication, the transmitting UART takes parallel data, often originating from a master device such as a CPU, and converts it into serial format for transmission to the receiving UART. The receiving UART, in turn, performs the reverse process, transforming the received serial data back into parallel form for use by the receiving device.

## UART_RX Specifications

The UART_RX module comes with specific specifications:

- **UART Frame Reception:** UART_RX receives UART frames through the RX_IN interface.
- **Oversampling Support:** It provides oversampling options, allowing for rates of 8, 16, or 32 times the UART_TX clock speed.
- **IDLE State:** In the absence of transmission, the RX_IN signal remains high, indicating the IDLE state.
- **Error Signaling:** PAR_ERR signal goes high if the calculated parity bit does not match the received frame's parity bit, signifying data corruption. STP_ERR signal goes high if the received stop bit is not equal to 1, also indicating frame corruption.
- **Data Extraction and Validation:** Data from the received frame is extracted and sent through the P_DATA bus, but only after confirming the frame's correctness. This confirmation includes checking that PAR_ERR and STP_ERR are both equal to 0.
- **Consecutive Frame Handling:** UART_RX can accept consecutive frames without any gaps in between.
- **Reset Functionality:** Registers within the UART_RX can be cleared using an asynchronous active low reset signal.

### Configuration Options

- **PAR_EN (Parity Bit Configuration):**
  - 0: Disables the frame parity bit.
  - 1: Enables the frame parity bit.

- **PAR_TYP (Parity Bit Type):**
  - 0: Specifies even parity bit.
  - 1: Specifies odd parity bit.

## Oversampling

Oversampling, a crucial aspect of UART_RX, determines the clock speed relationship between UART_RX and UART_TX. For instance, oversampling by 8 implies that UART_RX operates at a clock speed eight times faster than UART_TX, ensuring precise synchronization.

This README provides an introductory overview of UART_RX and its functionalities. For comprehensive technical details, specifications, and practical usage examples, please refer to the accompanying documentation and resources related to UART_RX.
