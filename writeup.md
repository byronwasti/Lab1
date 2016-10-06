# Writeup

## Implementation

Discuss interesting design choices we made along the way

-- Chose to merge subtractor and adder and have ALU utilize adder for subtraction.
Have each bit flipped for bit-slice, and just use a carry-in=1 for the first adder

## Test Results

-> Basic gates test bench caught misnaming of variables.

-> ALU test showed that gates were not connected

-> Testing showed the MUX was not wired up (quite) correctly. The 6 & 7th inputs of the MUX are disconnected, but we revered the inputs into the MUX so we were using them when we didn't expect to

## Timing Analysis

## Work Plan Reflection




