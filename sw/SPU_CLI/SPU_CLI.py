import argparse
import sys
import time
import threading
import serial

parser = argparse.ArgumentParser(description="A CLI for implementing String Functions over SPU ")
parser.add_argument('-f1','--file1',default='string1.txt',help="File of string A to send",metavar="file1")
parser.add_argument('-f2','--file2',default=None,help="File of string B to send",metavar="file2")
parser.add_argument('-b','--baud',default=38400,help="SPART Baud Rate",metavar="baud")
parser.add_argument('-p','--port',default='COM1',help="The port the spart should use",metavar="port")
args = vars(parser.parse_args())

class Spinner:
    busy = False
    delay = 0.1

    @staticmethod
    def spinning_cursor():
        while 1: 
            for cursor in '|/-\\': yield cursor

    def __init__(self, delay=None):
        self.spinner_generator = self.spinning_cursor()
        if delay and float(delay): self.delay = delay

    def spinner_task(self):
        while self.busy:
            sys.stdout.write(next(self.spinner_generator))
            sys.stdout.flush()
            time.sleep(self.delay)
            sys.stdout.write('\b')
            sys.stdout.flush()

    def start(self):
        self.busy = True
        threading.Thread(target=self.spinner_task).start()

    def stop(self):
        self.busy = False
        time.sleep(self.delay)

def execute_command(cmd, imm):

    ser = serial.Serial()
    ser.baudrate = args['baud']
    ser.port = args['port']
    ser.open()
    ser.flushInput()
    ser.flushOutput()
    data = bytearray()

    data.extend(cmd)
    
    # Immediate
    if imm is not None:
        for ch in imm:
            data.extend(ord(imm))
    else:
        # What do we do if the immediate is not needed? Just send null or 0x00???
        data.extend(0x00)

    # String A
    data.extend(0x01)
    char_byte_count = 0
    with open(args['file1'], "r") as f:
        for line in f:  
            for ch in line:
                data.extend(ord(ch))
                char_byte_count=char_byte_count+1

    if char_byte_count > 145000:
        print("String A too long")
        return

    for fill in range(0,char_byte_count % 128):
        data.extend(0)  # Fill data with zeros

    # String B
    data.extend(0x02)
    if args['file2'] is not None:
        with open(args['file2'], "r") as f:
            for line in f:  
                for ch in line:
                    data.extend(ord(ch))
    else:
        # What do we do if string B is not needed? Just send null or 0x00???
        data.extend(0x00)

    ser.write(data)
    sleep(.1)

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
    return ret_val,clk_cnt,int(clk_cnt/50000000)

def menu():
    spinner = Spinner()
    print(args['file1'])
	#print("Data to be sent will be from file: " + str(args.file1))
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
""")
        cmd = int(input("Enter a number to indicate a command: "))
        if cmd in [4,5,6,7,8,9]:
            imm = str(raw_input("Enter immediate value: "))
        else:
            imm = None

        print("Sending Data Via SPART... ")
        spinner.start()
        try:
            res, clk_cnt, time = execute_command(cmd, imm)
        except Exception as e:
            spinner.stop()
            print(e)
        spinner.stop()
        
        print("Return Val: %d 0x%08x" % (res , res))
        print("Clk Count: %d " % clk_cnt)
        print("Time: %d " % time)


if __name__ == '__main__':
	menu()

