import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

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
	
	public void DumpRegFile()
	{		
		try
		{
			PrintWriter RegFileLog = new PrintWriter(new File("reg_dump.sim"));
			for(int i = 0; i < rf.length; i++)
			{
				RegFileLog.println(String.format("%08x", rf[i]));
			}
			
			RegFileLog.close();
		}
		catch (IOException e)
		{
			System.out.println("Cannot open trace file");
			System.exit(-1);
		}
	}
}
