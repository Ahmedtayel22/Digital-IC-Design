# Debouncing Circuit

## Introduction

Buttons or mechanical switches often introduce noise or bouncing effects in digital systems. This debouncing circuit addresses these issues using a "delay detection debouncing technique."

## Block Interface
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/5eb0b1ca-17c8-4bc8-b35a-6603e32df17d)

## Block Diagram
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/23d5308b-7447-450b-b3ec-a770e57d59b0)
## WAVE FORM
![image](https://github.com/Ahmedtayel22/Digital-IC-Design/assets/105231666/a40fbff5-0ae7-4d8d-af34-f893b6d41f91)


## Design Overview

- **Inputs:** noisy_IN, CLK, RST
- **Output:** Debouncing_Out
- **Parameters:** Customizable (desired_delay, number_of_sync_stages, counter_bit_width)

## States of Operation

### Idle State

- All outputs set to zero.
- Remains in idle state with low noisy input.
- Transitions on noisy input change.

### Check High State

- Checks if high input remains high for the desired delay.
- Debouncing_Out is low.
- Timer_en is enabled.
- Returns to idle on low noisy input.
- Stays in this state if high, but the delay is not met.
- Transitions to high_state on a successful delay.

### High State

- Debouncing_Out is set high (indicating a stable high signal).
- Timer_en is disabled.
- Transitions to check_low on low noisy input.
- Remains in this state if noisy input remains high.

### Check Low State

- Checks if the low input remains low for the desired delay.
- Debouncing_Out is set high.
- Timer_en is enabled.
- Transitions to high_state on a noisy input change.
- Stays in this state if low, but the delay is not met.
- Transitions to idle on a successful delay.

This debouncing circuit ensures that noisy button inputs are properly debounced, preventing erroneous or unreliable readings in digital systems.

