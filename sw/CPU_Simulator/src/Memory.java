import java.io.*;
import java.util.Scanner;

public class Memory {
	private int mem[];
	
	public Memory(int MemSize)
	{
		mem = new int[MemSize];
		
		for(int i = 0; i < MemSize; i++)
		{
			mem[i] = 0; 
		}
	}
	
	public Memory(int MemSize, String LoadFile)
	{
		mem = new int[MemSize];
		
		for(int i = 0; i < MemSize; i++)
		{
			mem[i] = 0; 
		}
		
		try
		{
			Scanner s = new Scanner(new File(LoadFile));
			int currIndex = 0; 
			
			while(s.hasNextLine())
			{
				String line = s.nextLine();
				if(line.startsWith("//"))
				{
					// Comment. do nothing
				}
				else if(line.startsWith("@"))
				{
					// This should always be zero, we can ignore
				}
				else
				{
					mem[currIndex] = Integer.parseInt(line,16);
					currIndex++;
				}
			}
			
			s.close();
		}
		catch (IOException ie)
		{
			System.out.println("Error Opening File " + LoadFile + ". " + ie.getMessage());
			System.exit(-1);
		}
		catch (NumberFormatException nfe)
		{
			System.out.println("error in instr. file. Bad number. " + nfe.getMessage() );
			System.exit(-1);
		}
	}
	
	public int Read(int Address)
	{
		return mem[Address];
	}
	
	public void Write(int Addres, int Data)
	{
		mem[Addres] = Data; 
	}
}
