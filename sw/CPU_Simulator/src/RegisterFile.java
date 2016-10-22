
public class RegisterFile {
	private int rf[];
	
	public RegisterFile(int NumRegisters)
	{
		rf = new int[NumRegisters];
		
		for(int i = 0; i < NumRegisters; i++)
		{
			rf[i] = 0; 
		}
	}
	
	public int ReadRegister(int RegNum)
	{
		return rf[RegNum];
	}
	
	public void WriteRegister(int RegNum, int Val)
	{
		rf[RegNum] = Val;
	}
}
