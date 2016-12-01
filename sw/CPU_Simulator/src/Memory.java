import java.io.*;
import java.util.Scanner;

public class Memory {
	private byte mem[];
	private int spartCount;
	
	public Memory(int MemSize)
	{
		mem = new byte[MemSize];
		spartCount = 0; 
		for(int i = 0; i < MemSize; i++)
		{
			mem[i] = 0; 
		}
	}
	
	public Memory(int MemSize, String LoadFile)
	{
		mem = new byte[MemSize];
		
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
				line = line.trim();
				
				if(line.startsWith("//") || line.isEmpty())
				{
					// Comment. do nothing
				}
				else if(line.startsWith("@"))
				{
					// This should always be zero, we can ignore
				}
				else
				{
					mem[currIndex] = (byte)Integer.parseInt(line, 16);
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
	
	public int Read(int Address, int size)
	{
		int ret = 0; 
		
		if(Address == 0x00A00004){
			return 0; 
		}
		if((Address & 0x00800000) != 0){
			// Data Mem Read
			Address &= ~(0x00800000);
		}
		if(size == 4){
			// Big Endian
			ret = (((int)(mem[Address]) & 0xff) << 24);
			ret |= (((int)(mem[Address + 1]) & 0xff) << 16);
			ret |= (((int)(mem[Address + 2]) & 0xff) << 8);
			ret |= (((int)(mem[Address + 3]) & 0xff) << 0);
		}
		else if(size == 1){
			ret = (int)mem[Address];			
		}
		
		return ret;
	}
	
	public void Write(int Addres, int Data, int WriteSize)
	{
		if(Addres == 0x00A00000) {
			System.out.println((char)Data);
			return;
		}
		
		if(WriteSize == 4){
			// Big Endian
			mem[Addres] = (byte)((Data >> 24) & 0xff); 
			mem[Addres + 1] = (byte)((Data >> 16) & 0xff); 
			mem[Addres + 2] = (byte)((Data >> 8) & 0xff); 
			mem[Addres + 3] = (byte)((Data >> 0) & 0xff);
		}	
		else if (WriteSize == 1){
			// Big Endian
			mem[Addres] = (byte)(Data & 0xff);
		}
	}
	
	public void DumpMem()
	{
		try
		{
			PrintWriter RegFileLog = new PrintWriter(new File("mem_dump.sim"));
			for(int i = 0; i < mem.length; i++)
			{
				RegFileLog.println(String.format("%08x %02x", i, mem[i]));
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
