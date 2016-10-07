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

As shown in Figure 1, every bit-slice of the ALU takes in a single bit of `a` and a single bit of `b`, as well as `carryin` and `invert` flags. The output of the bit-slice is the output of all the operations that the ALU is able to do.

For most of the operations, such as the base binary logic gates, the output is the result of applying the appropriate logic gate to the bits of `a` and `b`. The unique case is for the Adder and Subtractor. To avoid unnecessary duplication, the Subtractor is an extension of the Adder and both return values on the same line.

In order to have the Subtractor and Adder work together, we use the `invert` flag of the bit-slice. The `b[i]` bit is XOR-ed with the `invert` bit. Thus, if `invert` is set, `b[i]` is inverted otherwise it remains the same. By also setting the `carryin` of the first bit-slice to the value of `invert`, we effectively invert the value of `b` and then add 1, which negates `b`. This negated `b` is then added to `a`, which is the same thing as subtracting. Thus the Adder and Subtractor take up the same amount of space.


### All Together now

In order to actually construct the ALU, 32 bit-slices are enumerated. For most of the basic logic gates, there are no cross-connections between bit-slices. However, for the Adder/Subtractor, the `carryout` of the previous bit-slice is tied to the `carryin` of the current bit-slice. This is true for all of the bit-slices except for the first one, which does not have a previous bit-slice, and is tied to the `invert` flag which allows for subtraction as talked about in the previous section. The last `carryout` is also an exception, as it is used for overflow detection and SLT operation, both of which will be talked about later.

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

SLT and overflow can both only be done after the addition/subtraction of the ALU is completed. Thus, this step is not contained in each bit-slice. To detect for overflow, we simply XOR the `carryin` to the MSB of the Adder and the `carryout` of the MSB of the Adder.

However, since overflow is only passed out of the ALU if there is an addition or subtraction operation (as it is an error), we only set the output `overflow` bit if the addition or subtraction operation is requested. (Technically this is done by AND-ing the `overflow` bit and the selection code for addition/subtraction which will be discussed later in the LUT section).

The SLT operation is completed by XOR-ing the `overflow` with the MSB of the Adder. This output is set to the LSB of the SLT and the rest are tied to 0.

### MUXing and LUT

The ALU now has seven 32-bit values from each of the different operations the ALU can perform. In order to choose the correct 32-bit value to output, we used 32, 8:1 MUXs on each bit of the bit-slice outputs. In order to get the selection values for the MUXs, we used a LUT which interprets the input to the ALU and generates corresponding flags for operation.

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

The ALU we designed is fully functional and is about as fast and small as we could make it. There are potentially some optimizations that can be put into place, as it seems wasteful to calculate every operation and only output the one we want instead of just calculating the operation desired.

## Test Results

For all of our operations, we were able to exhaustively test all the possible cases with a single bitslice. We did most of our debugging with these exhaustive bitslice tests. For larger strings of "a" and "b," we had to select specific cases to test the functionality of our operations. 

### Basic Gates
For the basic gates, we chose to do only one test for each gate. We chose values for "a" and "b" that contain substrings of each relevant relation. Thus, by testing these 2 values, we are testing all the cases for each gate repeatedly. Our testing of these gates didn't require us to make any changes to our implementation because Verilog has these basic gates built in. They worked well on our first try.

operandA                         | operandB                         | Command  | Result                           |
:-------------------------------: | :------------------------------: | :------: | :------------------------------: |
<sub>10101010101010101111000011110000</sub> | <sub>01010101010101010000111111110000</sub> | AND      | <sub>00000000000000000000000011110000</sub> |
<sub>10101010101010101111000011110000</sub> | <sub>01010101010101010000111111110000</sub> | NAND     | <sub>11111111111111111111111100001111</sub> |
<sub>10101010101010101111000011110000</sub> | <sub>01010101010101010000111111110000</sub> | OR       | <sub>11111111111111111111111111110000</sub> |
<sub>10101010101010101111000011110000</sub> | <sub>01010101010101010000111111110000</sub> | NOR      | <sub>00000000000000000000000000001111</sub> |
<sub>10101010101010101111000011110000</sub> | <sub>01010101010101010000111111110000</sub> | XOR      | <sub>11111111111111111111111100000000</sub> |


### Add/Subtract

To test our adder and our subtractor we unsured that we were testing some specific cases. We wanted to use negative and positive values for both "a" and "b" as well as testing the overflow flag for each operation. 

When testing our subtractor, we discovered that we were setting the carry-in to 1 in the wrong place. When we first tested the subtractor, we were getting weird results because we were always setting the carry-in to 1. Realizing this, we instead set only the inital value of carry-in to 1 and let the rest of the values naturally cascade.

operandA              | operandB       | Command | Result         | Overflow |
:-------------: | :-----: | :-----: | :------------: | :------- |
-2,147,483,000 | 483,001 | ADD     | -2,146,999,999 | 0        |
2,147,483,000  | 483,001 | ADD     | -2,147,001,295 | 1        |
214,748,300    | 48,301  | ADD     | -214,796,601   | 0        |
2,147,483,000  | 483,001 | SUB     |  2,146,999,999 | 0        |
-2,147,483,000 | 483,001 | SUB     | 2,147,001,295  | 1        |
-214,748,300   | 48,301  | SUB     | -214,796,601   | 0        |

### SLT

In the tests we made for our SLT, we wanted to capture cases similar to those tested with our adder and subtractor. We wanted to try different combinations of positive and negative values for our inputs. Rather than testing for an overflow flag, though, we instead ensured that the SLT works even with overflow (and it does). 

We found a problem with our SLT during testing. Initially, most of the bits were unset (Zs), and only the smallest bit was set to 1 or 0 based upon whether "a" was less than "b." This was due to our setting the length of our SLT True/False value to 32. It didn't affect our results, but it seemed like a poor design choice to have floating bits. We seemed to need a 32 bit value, so we just forced the floating bits to 0. Our SLT is still functional, and it looks much more professional. 

operandA           | operandB         | Command | Result |
:----------: | :-------: | :-----: | :----: |
-2147483000 | 483001    | SLT     | 1      |
2147483000  | -483001   | SLT     | 0      |
2147483000  | 483001    | SLT     | 0      |
-2147483000 | -483001   | SLT     | 1      |
-2147483000 | 422283001 | SLT     | 1      |


## Timing Analysis

We implemented our ALU using structural Verilog, meaning that our components (excluding the LUT) comprise only simple gates. This allows us to predict the propagation delay of of each calculation. The table below shows our predicted and measured worst case delay for single bit operations of each component. The predictions are based on the assumptions that every gate is built from NOR, NAND, and Not gates and that each of these fundamental gates has a delay equal to (10ns)*(# of inputs).

Component   |  Predicted Worst Delay 
:------------: | :---------------------:
Adder        | 220ns
Subtractor   | 330ns                   
Set Less Than|440ns
XOR |110ns 
OR |30ns 
NOR |20ns 
AND |30ns 
NAND |20ns 


## Work Plan Reflection
Everything took much long than we expected it to take. We were generally unable to get fully functional components on our own, so when we came together to integrate our pieces we spent way longer than anticipated debugging and rewriting code. The writeup itself also took a long time, especially thinking about propagation delays. We could have done a better job on that section and gotten measured results, but we realized that we had not properly built for realistic delays from the beginning. This meant that we would have had to redo a lot of our code and restructure many of our gates. We will keep this in mind for our next lab and build with this consideration from the start. 
