
public class InstructionResult {
	public int RegisterToWrite; 
	public int RegisterWriteData;
	public boolean WriteRegister;
	
	public int MemoryAddress; 
	public int MemoryDataToWrite;
	public int WriteMemory; 
	public boolean ReadMemory; 
	
	public int NewPC; 
	public boolean TakeBranch;
	
	public InstructionResult()
	{
		WriteRegister = false; 
		ReadMemory = false;
		WriteMemory = 0; 
		TakeBranch = false; 
	}
}
