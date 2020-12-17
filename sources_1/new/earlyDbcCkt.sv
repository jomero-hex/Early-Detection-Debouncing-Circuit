`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2020 02:50:29 PM
// Design Name: 
// Module Name: earlyDbcCkt
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module earlyDbcCkt
    (
        input logic clk, 
        input logic reset, 
        input logic btn,
        output logic db
    );
    
    logic m_tick;
    //10ms clock counter
    //100MHz / 100Hz = 1M
    //For simulation purposes we will use 20ns based tick, 100MHz / 50MHz = 2
    mod_m  #(.M(1_000_000)) count ( .clk(clk),
                                                             .reset(reset),
                                                             .max_tick(m_tick)
                                                             );
                                                           
   //enumerate data type for FSM
   typedef enum {zero, w1_1, w1_2, w1_3, one, w0_1, w0_2, w0_3}  state_type;
   
   state_type state_reg, state_next;
   
   //1. state register
   always_ff @ (posedge clk, posedge reset) //Async reset
   begin
        if(reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
   end
   
   //2. next state logic
   always_comb
   begin
        case (state_reg)
            zero:
                    if (btn)
                        state_next = w1_1;
                    else
                        state_next = zero;
             w1_1:     
                    if(m_tick)
                        state_next = w1_2;
                    else
                        state_next = w1_1;
                w1_2:
                    if(m_tick)
                        state_next = w1_3;
                    else
                        state_next = w1_2;
                 w1_3:
                        if (m_tick)
                            if(btn)
                                state_next = one;
                            else
                                state_next =zero;
                        else 
                            state_next = w1_3;
                  one:
                        if(btn)
                            state_next = one;
                        else
                            state_next = w0_1;
                  w0_1:
                        if(m_tick)
                            state_next = w0_2;
                        else
                            state_next = w0_1;
                   w0_2:
                        if(m_tick)
                            state_next = w0_3;
                        else
                            state_next = w0_2;
                    w0_3:
                        if (m_tick)
                            if(btn)
                                state_next = one;
                            else
                                state_next = zero;
                        else
                            state_next = w0_3;
                     default: state_next = zero;                //DO NOT FORGET THIS LINE
           endcase
     end
     
   //3. output logic
    assign db =( (state_reg == w1_1 ||      //pure moore machine, slight delay from btn to dbounce out
                  state_reg == w1_2 ||      //moore machine = output depends only on the current state
                  state_reg == w1_3 ||
                  state_reg == one) );
                                                               
endmodule
