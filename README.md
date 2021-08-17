# Comb_lock
Designed a combinational lock in Verilog HDL that opens only when sequential input entered is correct


An FSM has been created which changes states from start, to one, to two, to three, and four if the inputs being provided are correct. 
The input clock is assumed to be 50 MHz and the frequency is down-converted to 1Hz for better visualization. So, whenever the first 
correct input is entered the lock waits for the second input and so on. Whenever wrong input is entered the lock resets and the input
needs to be entered from start again. Now whenever the lock is in the start state, we can change the password through which the lock is 
being unlocked by changing the mode of operation.
Total 4 FSM states are used to do the same.
