# Writeup
Byron Wasti, Franton Lin, Tom Heale

## Implementation

### Bitslice

We designed our ALU in a Bitslice manner. This means that each bit of the two operands was operated on individually, starting with the least significant bit and going up to the most significant bit. To really explain our design, we will talk about what each bit-slice consisted of.

```
               ________________
              |                |
       a[i]---|                |---Adder/Subtractor
              |                |---AND
       b[i]---|                |---NAND
              |                |---NOR
 carryin[i]---|                |---OR
              |                |---XOR
     invert---|                |---carryout
              |________________|

    Figure 1: Inputs and Outputs of a single
              bit-slice in the ALU
```

As shown in Figure 1, every bit-slice of the ALU took in a single bit of _a_ and a single bit of _b_, as well as a _carryin_ and an _invert_ flag.  The output of the bit-slice is the output of all the operations that the ALU is able to do.

For most of the operations, such as the base binary logic gates, the bits of _a_ and _b_ are put through those logic gates and the output is the output of the logic gate. The unique case is for the Adder and Subtractor. To avoid unnecessary duplication, the Subtractor is an extension of the Adder and both return values on the same line.

In order to have the Subtractor and Adder work together, we use the _invert_ flag of the bit-slice. The _b[i]_ bit is XOR-ed with the _invert_ bit. Thus, if _invert_ is set, _b[i]_ is inverted otherwise it remains the same. By also setting the _carryin_ of the first bit-slice to the value of _invert_, we effectively invert the value of _b_ and then add 1, and then add that to _a_ which is the same thing as subtracting. Thus the Adder and Subtractor take up the same amount of space.


### All Together now

In order to actually construct the ALU, 32 bit-slices are enumerated. For most of the basic logic gates, there are no cross-connections between bit-slices. However, for the Adder/Subtractor, the _carryout_ of the previous bit-slice is tied to the _carryin_ of the current bit-slice. This is true for all of the bit-slices except for the first one, which does not have a previous bit-slice, and is tied to the _invert_ flag which allows for subtraction as talked about in the previous section. The last _carryout_ is also an exception, as it is used for overflow detection and SLT operation, both of which will be talked about later.

Figure 2 shows how the different bit-slices are connected to each other.

```

         a[0]   b[0]      a[1]   b[1]      a[2]   b[2]             a[31]   b[31]   
          |      |         |      |         |      |                |      |
         _|______|_       _|______|_       _|______|_              _|______|_
        |          |     |          |     |          |            |          |
invert--|cin   cout|-----|cin   cout|-----|cin   cout|---      ---|cin   cout|---{overflow
        |          |     |          |     |          |     ....   |          |    detection}
        |          |     |          |     |          |            |          |
        |          |     |          |     |          |            |          |
        | {outputs}|     | {outputs}|     | {outputs}|            | {outputs}|
        |__________|     |__________|     |__________|            |__________|
          | | | | |        | | | | |        | | | | |               | | | | |           
          | | | | |        | | | | |        | | | | |               | | | | |           
  --------'-'-'-'-'--------'-'-'-'-'--------'-'-'-'-'-----     -----'-'-'-'-'----
                          {output bus}

      Figure 2: How the different bit-slices of the ALU are connected to each other.
                Note that the outputs are not enumerated. There is also an invert flag
                being passed into each bit-slice which is not shown, as it is the same
                for each bit-slice.
```

The connections shown in Figure 2 demonstrate how the different bit-slices are connected together in order to allow for all binary operations as well as Addition and Subtraction.

### SLT and Overflow

SLT and overflow can both only be done after the addition/subtraction of the ALU is completed. Thus, this step is not contained in each bit-slice. To detect for overflow, we simply XOR the _carryin_ to the MSB of the Adder and the _carryout_ of the MSB of the Adder.

However, since overflow is only passed out of the ALU if there is an addition or subtraction operation (as it is an error), we only set the output _overflow_ bit if the addition or subtraction operation is requested. (Technically this is done by AND-ing the _overflow_ bit and the selection code for addition/subtraction which will be discussed later in the LUT section).

The SLT operation is completed by XOR-ing the _overflow_ with the MSB of the Adder. This output is set to the LSB of the SLT and the rest are tied to 0.

### MUXing and LUT

The ALU now has seven 32-bit values from each of the different operations the ALU can perform. In order to choose the correct 32-bit value to output, we used 32, 8:1 MUXs on each bit of the outputs. In order to get the selection values for the MUXs, we used a LUT which interprets the input to the ALU and generates corresponding flags for operation.

The LUT is as shown below:

| input | select | invert |
|:------|:------:|:------:|
| ADD   |  000   |  0     |
| SUB   |  000   |  1     |
| AND   |  001   |  0     |
| NAND  |  010   |  0     |
| NOR   |  011   |  0     |
| OR    |  100   |  0     |
| XOR   |  101   |  0     |
| SLT   |  110   |  0     |

Note that the ADD and SUB operations of the ALU are tied, with only the invert flag being set if SUB is the operation chosen.

By tying the output of the LUT to the selection of the MUXs, we can select only the output we desire from the ALU.

### Final Thoughts

The ALU we designed is fully functional and is about as fast and small as we could make it. There are potentially some optimizations that can be put into place, and it seems wasteful to calculate every operation and only output the one we want instead of just calculating the operation desired.

## Test Results

> For each ALU operation, include the following in your report:

> A written description of what tests you chose, and why you chose them. This should be roughly a paragraph or two per operation.
> Specific instances where your test bench caught a flaw in your design.
> As your ALU design evolves, you may find that new test cases should be added to your test bench. This is a good thing. When this happens, record specifically why these tests were added.


-> Basic gates test bench caught misnaming of variables.

-> ALU test showed that gates were not connected

-> Testing showed the MUX was not wired up (quite) correctly. The 6 & 7th inputs of the MUX are disconnected, but we revered the inputs into the MUX so we were using them when we didn't expect to

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

> Provide the worst case propagation delay for each of the operations of the ALU. This can be calculated or simulated (preferably both). Note: the propagation delay for some operations depends heavily on your choice of operands.

## Work Plan Reflection
> Compare how long each unit work actually took to how long you predicted it would take. This will help you better schedule future labs.
