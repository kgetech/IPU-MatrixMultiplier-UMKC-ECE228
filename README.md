# IPU-MatrixMultiplier-UMKC-ECE228 Spring 2021
#### OBLIGATORY NOTE 
*It should be noted that this design was created as a part of a class at UMKC, and that licensing restrictions may be in place that I am not aware of. Should you neglect to perform your due diligence and assume that the GNU-GPL licensing is the only relevant intellectual property policy that applies to this code, you agree to not hold any of our team listed below, nor our instructor, nor our university liable for your own neglect.*                                                                                    

# Team:

- Kyle Goodman
- Samantha Lewandoski
- Nathan Randall

# ECE 228: Introduction to Computer Design

- University of Missouri-Kansas City
- Instructor: Mostafizur Rahman

# Goal: Create a device capable of NxN matrix multiplication, demonstrate 4x4 matrix multiplication of four-bit numbers.

We started with an attempt at a TPU-like systolic array for solving 4x4 matrices. After listening to a lecture on matrices in Engineering Analysis, I realized a much simpler method that would save space and time, and we redesigned to a simpler form of direct multiplication. taking us from 12 clock cylces to complete a 4x4 matrix down to 8 cycles per matrix, if you include the time required to propagate the signal through the device. Due to the nature of the pipeline however, we are able to perform a 4x4 matrix multiplication or addition every four clock cycles. Therefore, to complete a 16x16 matrix via block matrix multiplication, you would need approximately 40 clock cycles, as opposed to 64 clock cycles per our initial design. In addition, due to the smaller amount of space required, this design could be modified and duplicated to allow for greater parallel processing. With very few changes, we could create an optimized accelerator to quickly multiply NxN matrices of great size.

# Final thoughts:

To make this IEEE 754 compliant, the arithmetic components would need to be refactored for 16-bit half-precision floating, point numbers, and this may happen soon. In addition, the register file would need to be expanded as well as the data control muxes and demuxes. It would be nice to implement this in such a way as to enable an SRAM Cache for retrieving and depositing data and instructions, as well. 

*-Kyle Goodman*




