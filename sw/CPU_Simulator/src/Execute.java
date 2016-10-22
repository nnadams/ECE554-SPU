
public class Execute {
	private static int GetFirstSourceRegisterValue(RegisterFile RegFile, int Instruction)
	{
		return RegFile.ReadRegister(GetRegValPos1(Instruction));

	}
	
	private static int GetSecondSourceRegisterValue(RegisterFile RegFile, int Instruction)
	{
		return RegFile.ReadRegister(GetRegValPos2(Instruction));
	}
	
	private static int GetDestRegisterNonImmed(int Instruction)
	{
		return GetRegValPos3(Instruction);
	}
	
	private static int GetDestRegisterImmed(int Instruction)
	{
		return GetRegValPos2(Instruction);
	}
	
	private static int GetRegValPos1(int Instruction)
	{
		return (Instruction >> 21) & 0x1f;
	}
	
	private static int GetRegValPos2(int Instruction)
	{
		return (Instruction >> 16) & 0x1f;
	}
	
	private static int GetRegValPos3(int Instruction)
	{
		return (Instruction >> 11) & 0x1f;
	}
	
	private static int GetSignExtendedImmediate(int Instruction)
	{
		short Val = (short)(Instruction & 0xffff);
		return (int)Val;
	}
	
	public static InstructionResult ALU(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		int Op = Instruction & 0x3;
		
		switch(Op)
		{
		case ISA.ADD:
			return ADD(RegFile, DMem, Instruction);
			
		case ISA.SUB:
			return SUB(RegFile, DMem, Instruction);
			
		case ISA.XOR:
			return XOR(RegFile, DMem, Instruction);
			
		case ISA.ANDN:
			return ANDN(RegFile, DMem, Instruction);
			
		default:
			return null;
		}
	}
	
	public static InstructionResult ADD(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Val1 + Val2; 
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		
		return ir; 
	}
	
	public static InstructionResult SUB(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Val1 - Val2; 
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult XOR(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Val1 ^ Val2; 
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult ANDN(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Val1 & (~Val2); 
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SHFT(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		int Op = Instruction & 0x3;
		
		switch(Op)
		{
		case ISA.SRL:
			return SRL(RegFile, DMem, Instruction);
			
		case ISA.SLL:
			return SLL(RegFile, DMem, Instruction);
			
		case ISA.ROR:
			return ROR(RegFile, DMem, Instruction);
			
		case ISA.ROL:
			return ROL(RegFile, DMem, Instruction);
			
		default:
			return null;
		}
	}
	
	public static InstructionResult SLL(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Val1 << Val2; 
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SRL(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Val1 >> Val2; 
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	public static InstructionResult ROL(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Integer.rotateLeft(Val1, Val2);
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	public static InstructionResult ROR(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetDestRegisterNonImmed(Instruction);
		Result = Integer.rotateRight(Val1, Val2);
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult ADDI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Val1 + Val2;
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SUBI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Val1 - Val2;
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult XORI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Val1 ^ Val2;
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult ANDNI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Val1 & (~Val2);
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult RORI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Integer.rotateRight(Val1, Val2);
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult ROLI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Integer.rotateLeft(Val1, Val2);
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}	
	
	public static InstructionResult SRLI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Val1 >> Val2; 
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SLLI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, WriteReg, Result; 
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		WriteReg = GetDestRegisterImmed(Instruction);
		Result = Val1 << Val2;
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult LBI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int WriteReg;
		int Result;
		
		WriteReg = GetRegValPos1(Instruction);
		Result = GetSignExtendedImmediate(Instruction);
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SLBI(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int WriteReg;
		int Result;
		int Val1, Val2; 
		
		WriteReg = GetRegValPos1(Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = Instruction & 0xffff;
		
		Result = (Val1 << 16) | Val2;
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SEQ(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int WriteReg;
		int Result;
		int Val1, Val2; 
		
		WriteReg = GetRegValPos3(Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		
		if(Val1 == Val2)
		{
			Result = 1; 
		}
		else
		{
			Result = 0; 
		}
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SLT(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int WriteReg;
		int Result;
		int Val1, Val2; 
		
		WriteReg = GetRegValPos3(Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		
		if(Val1 < Val2)
		{
			Result = 1; 
		}
		else
		{
			Result = 0; 
		}
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SLE(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int WriteReg;
		int Result;
		int Val1, Val2; 
		
		WriteReg = GetRegValPos3(Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		
		if(Val1 <= Val2)
		{
			Result = 1; 
		}
		else
		{
			Result = 0; 
		}
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult SCO(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int WriteReg;
		int Result;
		int Val1, Val2; 
		
		WriteReg = GetRegValPos3(Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSecondSourceRegisterValue(RegFile, Instruction);
		
		try
		{
			Result = 0;
			Math.addExact(Val1, Val2);
		}
		catch (ArithmeticException e)
		{
			Result = 1;
		}
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		
		return ir; 
	}
	
	public static InstructionResult LD(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int WriteReg;
		int Result;
		int Val1, Val2; 
		
		WriteReg = GetRegValPos2(Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		
		Result = DMem.Read(Val1 + Val2);
		
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result; 
		ir.WriteRegister = true;
		ir.ReadMemory = true;
		ir.MemoryAddress = Val1 + Val2;
		
		return ir; 
	}
	
	public static InstructionResult ST(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, Val; 
		
		Val = GetSecondSourceRegisterValue(RegFile, Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		 
		ir.WriteMemory = true;
		ir.MemoryAddress = Val1 + Val2;
		ir.MemoryDataToWrite = Val;
		
		return ir;
	}
	
	public static InstructionResult STU(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2, Val; 
		
		Val = GetSecondSourceRegisterValue(RegFile, Instruction);
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		 
		ir.WriteMemory = true;
		ir.MemoryAddress = Val1 + Val2;
		ir.MemoryDataToWrite = Val;
		ir.WriteRegister = true;
		ir.RegisterToWrite = GetRegValPos1(Instruction);
		ir.RegisterWriteData = Val1 + Val2;
		
		return ir;
	}
	
	public static InstructionResult J(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		ir.TakeBranch = true; 
		ir.NewPC = PC + 4 + (Instruction & 0x03ffffff);
		return ir;
	}
	
	public static InstructionResult JAL(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		ir.TakeBranch = true; 
		ir.NewPC = PC + 4 + (Instruction & 0x03ffffff);
		ir.WriteRegister = true; 
		ir.RegisterToWrite = 31;
		ir.RegisterWriteData = PC + 4;
		return ir;
	}
	
	public static InstructionResult JR(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2;
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		
		ir.TakeBranch = true; 
		ir.NewPC = Val1 + Val2;
		
		return ir;
	}
	
	public static InstructionResult JALR(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2;
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		
		ir.TakeBranch = true; 
		ir.NewPC = Val1 + Val2;
		ir.WriteRegister = true;
		ir.RegisterToWrite = 31;
		ir.RegisterWriteData = PC + 4;
		
		return ir;
	}
	
	public static InstructionResult BTR(RegisterFile RegFile, Memory DMem, int Instruction)
	{
		InstructionResult ir = new InstructionResult();
		int Val;
		int Result;
		int WriteReg; 
		
		Result = 0; 
		Val = GetFirstSourceRegisterValue(RegFile, Instruction);
		WriteReg = GetRegValPos3(Instruction);
		
		while( Val !=0 )
		{
			Result <<= 1;
			Result |= (Val & 1);
			Val >>= 1;
		}
		
		ir.WriteRegister = true;
		ir.RegisterToWrite = WriteReg; 
		ir.RegisterWriteData = Result;
		
		return ir;
	}
	
	public static InstructionResult BEQZ(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2;
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		
		if(Val1 == 0)
		{
			ir.TakeBranch = true; 
			ir.NewPC = PC + 4 + Val2;
		}
		
		return ir;
	}
	
	public static InstructionResult BNEZ(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2;
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		
		if(Val1 != 0)
		{
			ir.TakeBranch = true; 
			ir.NewPC = PC + 4 + Val2;
		}
		
		return ir;
	}
	
	public static InstructionResult BLTZ(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2;
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		
		if(Val1 < 0)
		{
			ir.TakeBranch = true; 
			ir.NewPC = PC + 4 + Val2;
		}
		
		return ir;
	}
	
	public static InstructionResult BGEZ(RegisterFile RegFile, Memory DMem, int Instruction, int PC)
	{
		InstructionResult ir = new InstructionResult(); 
		int Val1, Val2;
		
		Val1 = GetFirstSourceRegisterValue(RegFile, Instruction);
		Val2 = GetSignExtendedImmediate(Instruction);
		
		if(Val1 >= 0)
		{
			ir.TakeBranch = true; 
			ir.NewPC = PC + 4 + Val2;
		}
		
		return ir;
	}
}