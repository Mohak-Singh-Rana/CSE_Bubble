module instruction_fetch(input wire [15:0] mem_addr, output reg[31:0] ins, input clk );
reg [31:0]ins_address[31:0];


initial begin
  ins_address[0] = {6'b000000,5'b00001,5'b00010,5'b00000,5'b00000,6'b000000};  //add alu_op=0
  ins_address[1] = {6'b000000,5'b00001,5'b00010,5'b00000,5'b00000,6'b000001}; //addu alu_op=0
  ins_address[2] = {6'b000000,5'b00001,5'b00010,5'b00000,5'b00000,6'b000010};  //sub alu_op=1
  ins_address[3] = {6'b000000,5'b00001,5'b00010,5'b00000,5'b00000,6'b000011}; //subu alu_op=1
  ins_address[4] = {6'b000001,5'b00001,5'b00000,16'd1000}; //addi alu_op=2
  ins_address[5] = {6'b000010,5'b00001,5'b00000,16'd1000}; //addiu alu_op=2
  ins_address[6] = {6'b000011,5'b00001,5'b00010,5'b00000,5'b00000,6'b000011}; //and alu_op=3
  ins_address[7] = {6'b000011,5'b00001,5'b00010,5'b00000,5'b00000,6'b000100}; //or alu_op=4
  ins_address[8] = {6'b000100,5'b00001,5'b00000,16'd1000};//andi alu_op=5
  ins_address[9] = {6'b000101,5'b00001,5'b00000,16'd1000};//ori alu_op=6
  ins_address[10] = {6'b000110,5'b00001,5'b00010,5'b00000,5'd10,6'b000101};  //sll alu_op=7
  ins_address[11] = {6'b000111,5'b00001,5'b00000,5'b00000,5'd10,6'b000110};  //srl alu_op=8
  ins_address[12] = {6'b001000,5'b00001,5'b00000,16'd10};  //lw alu_op=9
  ins_address[13] = {6'b001001,5'b00001,5'b00000,16'd10}; //sw alu_op=10
  ins_address[14] = {6'b001010,5'b00001,5'b00000,16'd10};  //beq alu_op=11
  ins_address[15] = {6'b001011,5'b00001,5'b00000,16'd10}; //bne alu_op=12
  ins_address[16] = {6'b001100,5'b00001,5'b00000,16'd10}; //bgt alu_op=13
  ins_address[17] = {6'b001101,5'b00001,5'b00000,16'd10}; //bgte alu_op=14
  ins_address[18] = {6'b001110,5'b00001,5'b00000,16'd10}; //ble alu_op=15
  ins_address[19] = {6'b001111,5'b00001,5'b00000,16'd10}; //bleq alu_op=16
  ins_address[20] = {6'b010000,26'd10}; //j alu_op=17
  ins_address[21] = {6'b010001,5'b00000,5'b00000,5'b00000,5'b00000,6'b000111};//jr alu_op=18
  ins_address[22] = {6'b010010,5'b00000,5'b00000,5'b00000,5'b00000,6'b001000};//jal alu_op=19
  ins_address[23] = {6'b010011,5'b00001,5'b00010,5'b00000,5'b00000,6'b001001};//slt alu_op=20
  ins_address[24] = {6'b010100,5'b00001,5'b00000,16'd100};//slti alu_op=21
  ins_address[25] = {6'b010101,5'b00001,5'b00000,16'd10};//bneb alu_op=22 //branch not equal backwards
  
end
always@(posedge clk)begin
    ins = ins_address[mem_addr];
end

endmodule