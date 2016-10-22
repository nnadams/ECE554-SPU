import java.io.*;

public class Simulator {
	private static final int MEM_SIZE = 65535; 
	private static final int NUM_REGISTERS = 32; 
	
	public static void main(String[] args)
	{
		int PC;
		int Instruction;
		int OpCode; 
		InstructionResult ir = null; 
		boolean Halted; 
		int InstrCount; 
		PrintWriter TraceFile = null; 
		
		try
		{
			TraceFile = new PrintWriter(new File("javasim.trace"));
		}
		catch (IOException e)
		{
			System.out.println("Cannot open trace file");
			System.exit(-1);
		}
		
		Memory IMem = new Memory(MEM_SIZE, "loadfile.img");
		Memory DMem = new Memory(MEM_SIZE);
		RegisterFile RegFile = new RegisterFile(NUM_REGISTERS);
		
		Halted = false;
		PC = 0; 
		InstrCount = 0;
		
		while(!Halted)
		{
			StringBuilder str = new StringBuilder();
			
			Instruction = IMem.Read(PC); 
			InstrCount++;
			OpCode = (Instruction >> 26) & 0x3f;
			
			switch(OpCode)
			{
				case ISA.HALT:
					Halted = true;
					break;
				
				case ISA.NOP:
					// Nothing
					break;
				
				case ISA.ALU:
					ir = Execute.ALU(RegFile, DMem, Instruction);
					break;
					
				case ISA.SHFT:
					ir = Execute.SHFT(RegFile, DMem, Instruction);
					break;
					
				case ISA.ADDI:
					ir = Execute.ADDI(RegFile, DMem, Instruction);
					break;		
				
				case ISA.SUBI:
					ir = Execute.SUBI(RegFile, DMem, Instruction);
					break;
					
				case ISA.XORI:
					ir = Execute.XORI(RegFile, DMem, Instruction);
					break;
					
				case ISA.ANDNI:
					ir = Execute.ANDNI(RegFile, DMem, Instruction);
					break;
					
				case ISA.SRLI:
					ir = Execute.SRLI(RegFile, DMem, Instruction);
					break;
					
				case ISA.SLLI:
					ir = Execute.SLLI(RegFile, DMem, Instruction);
					break;
					
				case ISA.RORI:
					ir = Execute.RORI(RegFile, DMem, Instruction);
					break;
					
				case ISA.ROLI:
					ir = Execute.ROLI(RegFile, DMem, Instruction);
					break;
					
				case ISA.LBI:
					ir = Execute.LBI(RegFile, DMem, Instruction);
					break;
					
				case ISA.SLBI:
					ir = Execute.SLBI(RegFile, DMem, Instruction);
					break;
				
				case ISA.SEQ:
					ir = Execute.SEQ(RegFile, DMem, Instruction);
					break;
					
				case ISA.SLT:
					ir = Execute.SLT(RegFile, DMem, Instruction);
					break;
					
				case ISA.SLE:
					ir = Execute.SLE(RegFile, DMem, Instruction);
					break;
					
				case ISA.SCO:
					ir = Execute.SCO(RegFile, DMem, Instruction);
					break;
					
				case ISA.J:
					ir = Execute.J(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.JAL:
					ir = Execute.JAL(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.JR:
					ir = Execute.JR(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.JALR:
					ir = Execute.JALR(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.BEQZ:
					ir = Execute.BEQZ(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.BNEZ:
					ir = Execute.BNEZ(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.BLTZ:
					ir = Execute.BLTZ(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.BGEZ:
					ir = Execute.BGEZ(RegFile, DMem, Instruction, PC);
					break;
					
				case ISA.BTR:
					ir = Execute.BTR(RegFile, DMem, Instruction);
					break;
					
				case ISA.ST:
					ir = Execute.ST(RegFile, DMem, Instruction);
					break;
					
				case ISA.STU:
					ir = Execute.STU(RegFile, DMem, Instruction);
					break;
					
				case ISA.LD:
					ir = Execute.LD(RegFile, DMem, Instruction);
					break;
					
				default:
					System.out.println("Instruction not Supported - Exiting.");
					System.out.println("OpCode - " + Integer.toBinaryString(OpCode));
					System.exit(-1);
			}
			
			str.append("INUM: ");
			str.append(InstrCount);
			str.append(" PC: 0x");
			str.append(Integer.toHexString(PC));
			
			// Process Result 
			if(ir.WriteRegister)
			{
				RegFile.WriteRegister(ir.RegisterToWrite, ir.RegisterWriteData);
				
				str.append(" REG: ");
				str.append(ir.RegisterToWrite);
				str.append(" VALUE: 0x");
				str.append(Integer.toHexString(ir.RegisterWriteData));
		
				if(ir.WriteMemory)
				{
					// STU 
					DMem.Write(ir.MemoryAddress, ir.MemoryDataToWrite);
					str.append(" ADDR: 0x");
					str.append(Integer.toHexString(ir.MemoryAddress));
					str.append(" VALUE: 0x");
					str.append(Integer.toHexString(ir.MemoryDataToWrite));
				}
				else if(ir.ReadMemory)
				{
					// LD
					str.append(" ADDR: 0x");
					str.append(Integer.toHexString(ir.MemoryAddress));
				}
				else
				{
					
				}
			}
			else if(ir.WriteMemory) 
			{
				// St
				DMem.Write(ir.MemoryAddress, ir.MemoryDataToWrite);
				
				str.append(" ADDR: 0x");
				str.append(Integer.toHexString(ir.MemoryAddress));
				str.append(" VALUE: 0x");
				str.append(Integer.toHexString(ir.MemoryDataToWrite));
			}
			else 
			{
				// NOP or Branch
			}
			
			if(ir.TakeBranch)
			{
				PC = ir.NewPC;
			}
			else
			{
				PC += 4; 
			}
			
			TraceFile.println(str.toString());
		}
		
		StringBuilder HaltString = new StringBuilder();
		
		HaltString.append("INUM: ");
		HaltString.append(InstrCount);
		HaltString.append(" PC: 0x");
		HaltString.append(Integer.toHexString(PC));
		TraceFile.println(HaltString.toString());
		
		TraceFile.close();
	}
}
