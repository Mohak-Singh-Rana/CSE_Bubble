module cpu(clk,pc,arg1,arg2,rd,alu_op,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10);
input clk;  //clock
output reg[31:0] r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;    
reg[31:0] ins;  //current instruction being executed
output reg[31:0] pc;    //program counter
output reg[31:0] rd;    //value to be returned
reg[4:0] rd_addr;   //return destination address
output reg[4:0] alu_op;     //each instruction has a unique alu_op value depending on its opcode and func value 
reg zero;   //output of ALU
reg[31:0] reg_memory[31:0];     //register memory (32 registers each of size 32 bits)
reg[4:0] shamt;     //shift amount
reg [31:0] ra;      //return address
output reg [31:0] main_memory[255:0];   //main memory (256 words each of size 32 bits)
reg [31:0]ins_memory[255:0];    //instruction memory (256 instructions each of size 32 bits)
output reg [31:0] arg1,arg2;    //argument1 and argument2 of the ALU

initial begin

    main_memory[0] = 4;     //main memory initialised with the numbers to be sorted
    main_memory[4] = 56;
    main_memory[8] = 345;
    main_memory[12] = 3;
    main_memory[16] = 0;
    main_memory[20] = 45;
    main_memory[24] = 565;
    main_memory[28] = 55;
    main_memory[32] = 876;
    main_memory[36] = 454;
    
    
    reg_memory[0] = 0;      //reg is hard coded to 0 because of extensive usage of 0
    reg_memory[1] =1;       //reg is hard coded to 1 because of extensive usage of 1
    reg_memory[9] = 0;      //s7 = 0 (initialised according to the mips code of bubble sort)
    reg_memory[2] = 0;      //s0 = 0 (initialised according to the mips code of bubble sort)
    reg_memory[8] = 9;      //s6 = 4 (initialised according to the mips code of bubble sort)
    reg_memory[3] = 0;      //s1 = 0 (initialised according to the mips code of bubble sort)
    reg_memory[13] = 0;     //t3 = 0 (initialised according to the mips code of bubble sort)
    reg_memory[14] = 10;    //t4 = 5 (initialised according to the mips code of bubble sort)
    reg_memory[17] = 0;     //t7 = 0 (initialised according to the mips code of bubble sort)

    //intruction memory is initialised according to the mips code of bubble sort
    ins_memory[0] = {6'b000001,5'b00000,5'b01110,16'd5}; // addi 17 (number shows the instruction line number in the mips code)
    ins_memory[4] = {6'b000110 , 5'b00011 , 5'b10001 , 5'b00000 , 5'b00010 , 6'b000101}; //sll 20 (number shows the instruction line number in the mips code)
    ins_memory[8] = {6'b000000 , 5'b01001 , 5'b10001 , 5'b10001 , 5'b00000 , 6'b000000}; //add 21 (number shows the instruction line number in the mips code)
    ins_memory[12] = {6'b001000 , 5'b10001 , 5'b01010 , 16'b0000000000000000}; //lw 23 (number shows the instruction line number in the mips code)
    ins_memory[16] = {6'b001000 , 5'b10001 , 5'b01011 , 16'b0000000000000001}  ;   //lw 24 (number shows the instruction line number in the mips code)
    ins_memory[20] = {6'b010011 , 5'b01010 , 5'b01011 , 5'b01100 , 5'b00000 , 6'b001001} ; //slt 26 (number shows the instruction line number in the mips code)
    ins_memory[24] = {6'b001011 , 5'b01100 , 5'b00000 , 16'b0000000000000010}; //bne 27 (number shows the instruction line number in the mips code)
    ins_memory[28] = {6'b001001 , 5'b10001 , 5'b01011 , 16'b0000000000000000} ; //sw 29 (number shows the instruction line number in the mips code)
    ins_memory[32] = {6'b001001 , 5'b10001 , 5'b01010 , 16'b0000000000000001};  //sw 30 (number shows the instruction line number in the mips code)
    ins_memory[36] = {6'b000001 , 5'b00011 , 5'b00011 , 16'b0000000000000001};  //addi 34 (number shows the instruction line number in the mips code)
    ins_memory[40] = {6'b000000 , 5'b01000 , 5'b00010 , 5'b00111 , 5'b00000 , 6'b000010}; //sub 35 (number shows the instruction line number in the mips code)
    ins_memory[44] = {6'b010101, 5'b00111, 5'b00011, 16'd11}; // bneb 37 (number shows the instruction line number in the mips code)
    ins_memory[48] = {6'b000001 , 5'b00010 ,5'b00010 ,16'b0000000000000001}; //addi 38 (number shows the instruction line number in the mips code)
    ins_memory[52] = {6'b000001, 5'b00000, 5'b00011, 16'd0} ;//addi 41 (number shows the instruction line number in the mips code)
    ins_memory[56] = {6'b010101, 5'b01000, 5'b00010, 16'd14}	 ;//bneb 43 (number shows the instruction line number in the mips code)
    
    pc = 0;     //program counter initialised to 0

end

always@(posedge clk)begin

    ins = ins_memory[pc];       //instuction fetch phase (instruction is fetched from the instruction memory) 

    
    case(ins[31:26])        // decoding phase (instruction is decoded according to its opcode and func value)
        
        //each instruction has unique alu_op value depending on the opcode and func value which are listed in file 'ins_fetch.v' 

        0: begin
            if(ins[5:0]==0 || ins[5:0]==1)begin
                alu_op=0;   //add, addu
            end
            else if(ins[5:0]==2 || ins[5:0]==3)begin
                alu_op=1;   //sub,subu
            end
        end
        1: begin
            alu_op=2;     //addi
        end
        2: begin
            alu_op=2;     //addiu
        end
        3: begin
            if(ins[5:0]==3)begin
                alu_op=3;     //and 
            end
            else if(ins[5:0]==4)begin
                alu_op= 4;    //or
            end
        end
        4: begin
            alu_op=5;     //andi
        end
        5: begin
            alu_op=6;     //ori
        end
        6: begin
            alu_op=7;     //sll
        end
        7: begin
            alu_op=8;     //srl
        end
        8: begin
            alu_op=9;     //lw
        end
        9: begin
            alu_op=10;    //sw
        end
        10: begin
            alu_op=11;    //beq
        end
        11: begin
            alu_op=12;    //bne
        end
        12: begin
            alu_op=13;    //bgt
        end
        13: begin
            alu_op=14;    //bgte
        end
        14: begin
            alu_op=15;    //ble
        end
        15: begin
            alu_op=16;    //bleq
        end
        16: begin
            alu_op=17;    //j
        end
        17: begin
            alu_op=18;    //jr
        end
        18: begin
            alu_op=19;    //jal
        end
        19: begin
            alu_op=20;    //slt
        end
        20: begin
            alu_op=21;    //slti
        end
        21: begin
            alu_op=22;    //bneb
        end
    endcase


        
    //memory access stage (data is fetched from the main memory and stored conveniently to input into the ALU)
    //depending on R-type, J-type and I-type instruction, arg1 arg2 rd_addr and shamt is set accordingly
    if(alu_op[4:0]==0 || alu_op[4:0]==1 || alu_op[4:0]==20 || alu_op[4:0]==3 || alu_op[4:0]==4)begin    
            arg1= reg_memory[ins[25:21]];   
            arg2= reg_memory[ins[20:16]];   
            rd_addr= ins[15:11];    
    end
    else if(alu_op[4:0]==9 || alu_op[4:0]==10)begin
            arg1= reg_memory[ins[25:21]];
            arg2= {16'd0,ins[15:0]};
    end
    else if(alu_op[4:0]==11 || alu_op[4:0]==12 || alu_op[4:0]==13 || alu_op[4:0]==14 || alu_op[4:0]==15 || alu_op[4:0]==16 || alu_op[4:0]==22)begin
            arg1= reg_memory[ins[25:21]];
            arg2= reg_memory[ins[20:16]];   
    end
    else begin
            arg1= reg_memory[ins[25:21]];
            rd_addr = ins[20:16];
            arg2 = {16'd0,ins[15:0]};
            shamt=ins[10:6];
    end



    //ALU Phase (operation is performed depending on the instruction type)
    case(alu_op)
        0: begin    //add,addu
            rd = arg1 + arg2;
            zero = 0;   
        end
        1: begin    //sub,subu
            rd = arg1 - arg2;  
            zero= 0;
        end
        2: begin    //addi,addiu
            rd = arg1 + arg2;  
            zero=0;
        end
        3: begin    //and
            rd = arg1 & arg2;  
            zero=0;
        end
        4: begin    //or
            rd = arg1 || arg2; 
        end
        5: begin    //andi
            rd = arg1 & arg2 ; 
            zero=0;
        end
        6: begin    //ori
            rd = arg1 || arg2; 
        end
        7: begin    //sll
            rd = (arg1<<shamt); 
            zero= 0;
        end
        8: begin    //srl             
            rd= (arg1>>shamt); 
        end
        9: begin    //lw
            rd = arg1 + (arg2<<2); 
        end
        10: begin   //sw
            rd = arg1 + (arg2<<2); 
        end
        11: begin   //beq
            if(arg1==arg2)begin
                zero=1;
            end
            else begin 
                zero=0 ;
            end
        end
        12: begin   //bne
            if(arg1!=arg2)begin
                zero=1;
            end
            else begin 
                zero=0;
            end
        end
        13: begin   //bgt
            if(arg1>arg2)begin
                zero=1;
            end
            else begin 
                zero=0;
            end
        end
        14: begin   //bgte
            if(arg1>=arg2)begin
                zero=1;
            end
            else begin
                zero=0;
            end
        end
        15: begin   //ble
            if(arg1<arg2)begin
                zero=1;
            end
            else begin 
                zero=0;
            end
        end
        16: begin   //bleq
            if(arg1==arg2)begin
                zero=1;
            end
            else begin
                zero= 0;
            end
        end
        17: begin   //j
            zero=1;
        end
        18: begin   //jr
            zero=1;
        end
        19: begin   //jal
            zero=1;
        end
        20: begin   //slt
            if(arg1<arg2)begin
                rd = 1;
            end
            else begin
                rd = 0;
            end
        end
        21: begin   //slti
            if(arg1<arg2)begin
                rd = 1;
            end
            else begin
                rd = 0;
            end
        end
        22: begin   //bneb
            if(arg1!=arg2)begin
                zero=1;
            end
            else begin 
                zero=0;
            end
        end
    endcase

    //memory write phase (the output from the ALU is written accordingly in the main memory)
    if(alu_op==9)begin
            reg_memory[ins[20:16]] = main_memory[rd];   //data is read from the main memory and stored in the register
        end
    else if(alu_op==10)begin
        main_memory[rd] = reg_memory[ins[20:16]];   //data is written to the main memory from the register
        end
    else if(alu_op==17)begin
            pc =(ins[25:0]<<2) - 4;     //program counter is jumped to the place specified
        end
    else if(alu_op==18)begin
            pc = ra;        //program counter is jumped to the specified address
        end
    else if(alu_op==19)begin
            ra = pc+4;      //ra is set
            pc =(ins[25:0]);    //program counter is jumped to the place specified  
        end
    else if(alu_op==11 || alu_op==12||alu_op==13||alu_op==14||alu_op==15||alu_op==16||alu_op==22)begin
            if(zero==1)begin
                if(alu_op==22)begin
                    pc = pc - (ins[15:0]<<2);   //program counter decremented accordingly 
                end
                else begin
                    pc = pc + (ins[15:0]<<2);   //program counter incremented accordingly 
                end
            end
        end
    else begin
            reg_memory[rd_addr]=rd;     //output rd is written to the register specified by rd_addr
        end

    pc = pc + 4;    //at every positive edge of the clock, program counter is incresed by 4

    // r2 = main_memory[16];
    // r1 = pc;
    // r1 = reg_memory[2];
    // r2 = reg_memory[3];
    // r3 = reg_memory[7];
    // r5 = reg_memory[14];
    // r2 = main_memory[(reg_memory[17]<<2)];

    r1 = main_memory[0];    //cuurent state of the main memory is passed to the testbench at every positive edge of the clock
    r2 = main_memory[4];
    r3 = main_memory[8];
    r4 = main_memory[12];
    r5 = main_memory[16];
    r6 = main_memory[20];
    r7 = main_memory[24];
    r8 = main_memory[28];
    r9 = main_memory[32];
    r10 = main_memory[36];

end

endmodule

