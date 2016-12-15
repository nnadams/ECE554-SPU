import argparse
import sys
import time
import threading
import serial

parser = argparse.ArgumentParser(description="A CLI for implementing String Functions over SPU ")
parser.add_argument('-f1','--file1',default='string1.txt',help="File of string A to send",metavar="file1")
parser.add_argument('-f2','--file2',default='string2.txt',help="File of string B to send",metavar="file2")
parser.add_argument('-b','--baud',default=38400,help="SPART Baud Rate",metavar="baud")
parser.add_argument('-p','--port',default='COM1',help="The port the spart should use",metavar="port")
args = vars(parser.parse_args())

class Spinner:
    busy = False
    delay = 0.1
    expTime = 1
    
    @staticmethod
    def spinning_cursor():
        while 1: 
            for cursor in '|/-\\': yield cursor

    def __init__(self):
        self.spinner_generator = self.spinning_cursor()

        
    def spinner_task(self):
        i = 0 
        while self.busy:
            secs = i / 10
            percent = int((float(secs) /  self.expTime) * 100)
            if percent > 100:
                percent = 100
                
            sys.stdout.write('\r')
            # the exact output you're looking for:
            sys.stdout.write("[%-20s] %d%%" % ('='*(percent/5), percent))
            sys.stdout.flush()
            time.sleep(self.delay)
            sys.stdout.write('\b')
            sys.stdout.flush()
            i +=1
            #sys.stdout.write(next(self.spinner_generator))
            #sys.stdout.flush()
            #time.sleep(self.delay)
            #sys.stdout.write('\b')
            #sys.stdout.flush()

    def start(self, numChars):
        self.busy = True
        self.expTime = numChars * 8 / 32000
        threading.Thread(target=self.spinner_task).start()

    def stop(self):
        self.busy = False
        time.sleep(self.delay*2)
        print " "

        
def strcchr(str1,str2):
    return str1.count(str2)

def strchr(str1,str2):
    return str1.find(str2)

def strrchr(str1,str2):
    return str1.rfind(str2)

def strstr(str1,str2):
    return str1.find(str2)
    
    
def execute_command(cmd, imm, spinner):

    ser = serial.Serial()
    ser.baudrate = args['baud']
    ser.port = args['port']
    ser.open()
    ser.flushInput()
    ser.flushOutput()
    data = bytearray()
    
    data.append(cmd)
   
    # Immediate
    if imm is not None:
        for ch in imm:
            data.append(ord(imm))
    else:
        # What do we do if the immediate is not needed? Just send null or 0x00???
        data.append(0)

    # String A
    data.append(1)
    char_byte_count = 0
    with open(args['file1'], "r") as f:
        for line in f:  
            for ch in line:
                data.append(ord(ch))
                char_byte_count=char_byte_count+1
                
    data.append(0)
    char_byte_count+=1
    for fill in range(0,128 - char_byte_count % 128):
        data.append(0)  # Fill data with zeros
    
    char_byte_count+= 128 - char_byte_count%128
    
    # String B
    data.append(2)
    b_count = 0
    if args['file2'] is not None:
        with open(args['file2'], "r") as f:
            for line in f:  
                for ch in line:
                    data.append(ord(ch))
                    char_byte_count=char_byte_count+1
                    b_count +=1
                    
    data.append(0)
    b_count +=1
        
    if char_byte_count > 145000*4:
        print("The given data exceeds board capacity!")
        raise ValueError()
        
    if (cmd == 11 or cmd == 12) and b_count > 16:
        print("Substring max is 16 characters...!")
        raise ValueError()
        
    data.append(4)
    spinner.start(char_byte_count)
    ser.write(data)
    time.sleep(.1)
    rec = bytearray()
    i = 0
    while i < 8:
        ch = ser.read()
        rec.extend(ch)
        i += 1
            
    ser.flush()      
    ret_val = rec[0] | (rec[1] << 8) | (rec[2] << 16) | (rec[3] << 24) 
    clk_cnt = rec[4] | (rec[5] << 8) | (rec[6] << 16) | (rec[7] << 24) 
    
    # ret_str = "Return Val: %d 0x%08x" % (ret_val , ret_val)
    # print return_string
    # clk_ret_str = "Clk Count: %d " % clk_cnt
    return ret_val,clk_cnt

def menu():
    spinner = Spinner()
    while True:
        print("""
Select a Function:
====================
0: STRLEN no SPU 
1: STRLEN w/ SPU
2: STRCMP no SPU
3: STRCMP w/ SPU
4: STRCHR no SPU
5: STRCHR w/ SPU
6: STRRCHR no SPU
7: STRRCHR w/ SPU
8: STRCCHR no SPU
9: STRCCHR w/ SPU
10: STRSTR no SPU
11: STRSTR w/ SPU
12: Exit
""")
        try:
            cmd = int(input("Enter a number to indicate a command: "))
        except Exception:
            print "Error: Enter valid number."
            continue
        
        if cmd == 12:
            break
            
        if cmd not in [0,1,2,3,4,5,6,7,8,9,10,11]:
            print "Invalid Entry"
            continue
        if cmd in [4,5,6,7,8,9]:
            imm = str(raw_input("Enter immediate value: "))
            if len(imm) > 1:
                print "Error: Enter single character only."
                continue
        else:
            imm = None
    
        passed = True
        print("Sending Data Via SPART... ")
        try:
            res, clk_cnt = execute_command(cmd, imm, spinner)
        except Exception as e:
            spinner.stop()
            passed = False
            print(e)
        spinner.stop()
        if passed:
            print("Return Val: %d 0x%08x" % (res , res))
            print("Clk Count: %d " % clk_cnt)
            timerun = int(clk_cnt) / 95000000.0
            print "Time: " + str(timerun) + " seconds"
            
            with open(args['file1'], 'r') as myfile:
                A = myfile.read()


            with open(args['file2'], 'r') as myfile:
                B = myfile.read()

                
            print "Running Python code for same result..."
            start = time.clock()
            ret_val = 0
            if cmd == 0 or cmd == 1:
                ret_val = len(A)
            elif cmd == 2 or cmd == 3:
                if A == B:
                    ret_val = 0
                else:
                    ret_val = 1
            elif cmd == 4 or cmd == 5:
                ret_val = strchr(A, imm)
            elif cmd == 6 or cmd == 7:
                ret_val = strrchr(A, imm)
            elif cmd == 8 or cmd == 9:
                ret_val = strcchr(A,imm)
            elif cmd == 10 or cmd == 11:
                ret_val = strstr(A,B)

            end = time.clock()
            total_time = end - start
            print("Python Return Val: %d 0x%08x" % (ret_val , ret_val))
            print "Python Time " + str(total_time) + " seconds"
             
if __name__ == '__main__':
	menu()
