# Writeup
Byron Wasti, Franton Lin, Tom Heale

## ALU Component Design

We built each of the operations for our ALU separately and selected which operation to output from the ALU using a MUX with a 3(?) bit selector.

### Adder

We implemented a full adder as in prrevious labs and homeworks. It has 3 single bit inputs: a, b, and carry-in. 

### Subtractor

### Set Less Than

### XOR

### And & NAND

### NOR & OR

## Bitslice Implementation

## Timing Analysis

|Component   |  Predicted Worst Delay  |  Measured Worst Delay |
------------ | :---------------------: | --------------------: |
Adder        | number                  | number                |
Subtractor   | number                  | number                |
Set Less Than|||
XOR |||
OR |||
NOR |||
AND |||
NAND |||


## Implementation

> Discuss any interesting design choices you made along the way.
> Include block diagrams of your ALU at an appropriate level of detail: the top-level diagram above is too abstract to say anything about your particular design, while a single figure with every AND gate and wire would be unintelligible. Use your hierarchy and organization to show the important pieces. If you took a Bitslice approach, you should show a single bit and how they fit together.


Chose to merge subtractor and adder and have ALU utilize adder for subtraction.
Have each bit flipped for bit-slice, and just use a carry-in=1 for the first adder

Chose to use a Mux at the end instead of in each bit slice to allow for SLT to function properly

## Test Results

> For each ALU operation, include the following in your report:

> A written description of what tests you chose, and why you chose them. This should be roughly a paragraph or two per operation.
> Specific instances where your test bench caught a flaw in your design.
> As your ALU design evolves, you may find that new test cases should be added to your test bench. This is a good thing. When this happens, record specifically why these tests were added.


-> Basic gates test bench caught misnaming of variables.

-> ALU test showed that gates were not connected

-> Testing showed the MUX was not wired up (quite) correctly. The 6 & 7th inputs of the MUX are disconnected, but we revered the inputs into the MUX so we were using them when we didn't expect to

## Timing Analysis

> Provide the worst case propagation delay for each of the operations of the ALU. This can be calculated or simulated (preferably both). Note: the propagation delay for some operations depends heavily on your choice of operands.

## Work Plan Reflection
> Compare how long each unit work actually took to how long you predicted it would take. This will help you better schedule future labs.
