`timescale 1ns/1ns
`include "CSEBubble_final.v"

module testbench;
    wire[31:0] pc_out;
    reg clk;
    wire [4:0] alu_op;
    wire[31:0] rs,rt,rd;
    wire[31:0] r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
    cpu cp(clk,pc_out,rs,rt,rd,alu_op,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10);
    initial begin
    clk = 0;
    end
    always begin
        #10 clk=~clk;
    end
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,testbench);
        #10;
        $monitor("%d %d %d %d %d %d %d %d %d %d",r1,r2,r3,r4,r5,r6,r7,r8,r9,r10);
        #40000 $finish;
    end
endmodule