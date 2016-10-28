
public class ISA {
	public static final int HALT = 0b000000;
	public static final int NOP  = 0b000001;
	public static final int ADDI = 0b001000;
	public static final int SUBI = 0b001001;
	public static final int XORI = 0b001010;
	public static final int ANDNI = 0b001011;
	public static final int ROLI = 0b010100;
	public static final int SLLI = 0b010101;
	public static final int RORI = 0b010110;
	public static final int SRLI = 0b010111;
	public static final int ALU  = 0b011011;
	public static final int ADD  = 0b000000;
	public static final int SUB  = 0b000001;
	public static final int XOR  = 0b000010;
	public static final int ANDN = 0b000011;
	public static final int SHFT = 0b011010;
	public static final int ROL  = 0b000000;
	public static final int SLL  = 0b000001;
	public static final int ROR  = 0b000010;
	public static final int SRL  = 0b000011;
	public static final int SEQ  = 0b011100;
	public static final int SLT  = 0b011101;
	public static final int SLE  = 0b011110;
	public static final int SCO  = 0b011111;
	public static final int LBI  = 0b011000; 
	public static final int SLBI = 0b010010;
	public static final int ST   = 0b010000;
	public static final int LD   = 0b010001; 
	public static final int STU  = 0b010011; 
	public static final int BEQZ = 0b001100; 
	public static final int BNEZ = 0b001101; 
	public static final int BLTZ = 0b001110; 
	public static final int BGEZ = 0b001111; 
	public static final int J    = 0b000100; 
	public static final int JR   = 0b000101; 
	public static final int JAL  = 0b000110; 
	public static final int JALR = 0b000111;
	public static final int BTR  = 0b011001;
}