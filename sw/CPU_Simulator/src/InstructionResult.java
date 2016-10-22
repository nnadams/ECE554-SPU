
public class InstructionResult {
	public int RegisterToWrite; 
	public int RegisterWriteData;
	public boolean WriteRegister;
	
	public int MemoryAddress; 
	public int MemoryDataToWrite;
	public boolean WriteMemory; 
	public boolean ReadMemory; 
	
	public int NewPC; 
	public boolean TakeBranch;
	
	public InstructionResult()
	{
		WriteRegister = false; 
		ReadMemory = false;
		WriteMemory = false; 
		TakeBranch = false; 
	}
}
