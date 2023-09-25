# Automatic Garage Door Controller

## Introduction

The Automatic Garage Door Controller employs a Finite State Machine (FSM) as a fundamental tool for implementing controllers and sequencers. The FSM features finite inputs, outputs, and a specific number of states. At each clock edge, combinational logic computes outputs and determines the next state based on inputs and the current state. Two types of FSMs are employed: Moore FSM (where outputs change with the clock edge) and Mealy FSM (where outputs change independently of the clock edge).

## Block Interface
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/c2a40071-b693-4ddb-b246-72a7b49f83b4)

## FSM
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/dd99457f-fc40-4309-8ad1-9c4a218d5e74)


## Specifications

The Controller operates with three crucial inputs:

1. **Activate Push Button (User):** This input triggers the Up motor when the door is down and activates the Down motor when the door is up.
2. **UP_Max (Sensor):** This sensor signal becomes high when the door is completely open.
3. **DN_Max (Sensor):** This sensor signal becomes high when the door is completely closed.

Notably, the system ensures that the door is always either completely closed or completely open. Additionally, the Finite State Machine is initialized to the IDLE state using an asynchronous reset signal.

## States Diagram

The Garage Door Controller features the following states:

- **IDLE State:** This state represents the default and reset state of the Finite State Machine.
- **Mv_Up State:** In this state, the controller enables the up motor to open the garage door.
- **Mv_Dn State:** This state activates the down motor to close the garage door.

This README provides an overview of the Automatic Garage Door Controller, highlighting its core functionalities and specifications. For detailed technical information, system operation, and practical implementation details, please refer to the accompanying documentation and resources.
