# I2C Communication Protocol Overview

## Introduction

I2C, short for Inter-Integrated Circuit, is a synchronous serial communication protocol akin to SPI and CAN. It operates in a half-duplex manner, where only one end of the communication can transmit data at any given time. This README delves into the fundamental characteristics of I2C and its practical applications.

### Half-Duplex Nature

In I2C communication, data transfer occurs in a half-duplex fashion. This means that during communication:

- **Master-to-Slave**: When one device sends data, the other device can only receive the data and cannot send data back simultaneously. Data transmission occurs in a unidirectional manner, switching between transmission and reception as required.

- **Slave-to-Master**: The slave device can send data to the master only after the master has stopped sending data. This half-duplex nature is advantageous as it allows devices to share the same frequency for transmission and reception at different times. This method is commonly employed in cost-effective wireless bridging.

- **Multi-Master Communication**: I2C permits multiple masters to engage in the communication, making it a versatile protocol for various applications.

![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/7a47fbc7-2542-4738-b4df-24980871f494)



## I2C Message Format
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/a9af69cb-9aa4-483a-84e2-291c950a7cde)


I2C follows a standard message format consisting of the following components:

1. **Start Condition**: The communication begins with a start condition.

2. **Slave Address**: The address of the target device (slave) is transmitted - (7_bits).

3. **Read/Write Bit**: A bit indicating whether the master intends to read (R) or write (W) data.

4. **Acknowledgment Bit**: An acknowledgment bit signifies the successful reception of data.

5. **Data (8-bit or 10-bit)**: Data is sent in 8-bit or 10-bit format, depending on the mode.

6. **ACK Bit**: An acknowledgment bit is transmitted to confirm the receipt of data.

7. **Stop Condition**: The communication concludes with a stop condition.

![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/1900e0cb-31f9-46dc-b5ec-7ca2fc3bdf82)

## Wave Form
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/8d6a69ec-7d23-44e6-b2e3-f62137143249)

## I2C Communication Modes

I2C supports various communication modes, each with distinct characteristics:

1. **Normal Mode/Standard Mode**: In this mode, 7-bit addresses are used, and communication occurs at a rate of 100KHz.

2. **Fast Mode**: Fast Mode utilizes 10-bit addresses and operates at a faster rate of 400kHz.

3. **High-Speed Mode/Fast Mode Plus**: Communication speed increases to 3.4MHz in this mode.

4. **Ultra-Fast Mode**: In Ultra-Fast Mode, communication reaches a blazing 5MHz.

## Finite state machine [FSM]
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/130bef49-84df-45f6-9eef-4fb8e132cb17)



## Block Interface
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/d0d34968-961a-4564-91f8-fa2723cfa753)

**wr_i2c**    --> enable the controller.

**cmd**       --> 

![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/50c72545-3283-4818-866e-9b2d3ad2e47a)


**din**       --> data to send to slave (address of the slave of data bytes).

**sda_in**    --> it seems like the sda_out from the slave "look at RTL design considerations".

**dout**     --> data received from slave.

**ack**      --> acknowledgement comes from slave after receiving byte.

**ready**     --> master ready for a new cmd.

**done_tick** --> signal high after send or recive a byte.

**sda_out**   --> data output line.

**scl**       --> clock generated line.



## RTL Design Considerations

When implementing I2C in RTL (Register-Transfer Level) design, it's crucial to address the shared SDA (Serial Data) line between the I2C Master and I2C Slave. To mitigate conflicts, the SDA line can be divided into two separate lines: SDA_out for the I2C Master block and SDA_in for the I2C Slave block. This separation ensures proper control of the SDA line by both devices, as illustrated in the Figure.

For more detailed technical information and implementation specifics, refer to the relevant documentation and resources.

![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/c9d51a93-b4e3-4855-ac82-b167b269b0e0)

## References
1) ## Papper
Perspectives in Communication, Embedded-Systems and Signal-Processing (PiCES) – An International Journal
ISSN: 2566-932X, Vol. 4, Issue 9, December 2020
Part of the Proceedings of the 1st All India Paper writing Competition on Emerging Research - PaCER 2020

**"Design of I2C Protocol in Verilog-A New
Approach"**

Link: https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiq9Z_fo9-BAxVV0AIHHc8OAD8QFnoECAkQAQ&url=https%3A%2F%2Fd-nb.info%2F122452540X%2F34&usg=AOvVaw0HdjkEAbv_FTqJB5i3aW1G&opi=89978449

2) ## Anas Salah Eddin channel:
Link: https://youtu.be/64KHN-Z4r2w?si=Hd65olrJ8H8WR2T7





