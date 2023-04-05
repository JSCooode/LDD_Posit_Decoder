# LDD_Posit_Decoder
All circuit designs are top-leveled by 'decoder.v'

'LDD_32_3' means 32-bit LDD based decoder with es = 3

The LDD_16_1 and LDD_64_4 was designed with parameters, which means it can be easily updated for any input data size by just changing parameters' values ('n', and 'es'). 

Please note that you still need to change 'and64' module based on the input size, and update the used module in 'LDD.v'
