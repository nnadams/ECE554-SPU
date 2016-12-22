import argparse
import sys
import time
import threading
import serial
import subprocess
import cpuinfo

parser = argparse.ArgumentParser(description="A CLI for implementing String Functions over SPU ")
parser.add_argument('-f1','--file1',default='string.txt',help="File of string A to send",metavar="file1")
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

def get_cpu_speed():
    return cpuinfo.get_cpu_info()['hz_advertised_raw'][0]

def strcchr(str1,str2):
    return str1.count(str2)

def strchr(str1,str2):
    return str1.find(str2)

def strrchr(str1,str2):
    return str1.rfind(str2)

def strstr(str1,str2):
    return str1.find(str2)

def execute_command(cmd, imm):

    with open(args['file1'], 'r') as myfile:
        A = myfile.read()


    if args['file2'] is not None:
        with open(args['file2'], 'r') as myfile:
            B = myfile.read()
    else:
        B=''

    start = time.clock()

    if cmd == 0:
        ret_val = len(A)
    elif cmd == 1:
        ret_val = cmp(A,B)
    elif cmd == 2:
        ret_val = strchr(A, imm)
    elif cmd == 3:
        ret_val = strrchr(A, imm)
    elif cmd == 4:
        ret_val = strcchr(A,imm)
    elif cmd == 5:
        ret_val = strstr(A,B)
    else:
        ret_val = None
        print("invalid function")

    end = time.clock()
    total_time = end - start
    clk_count = total_time * get_cpu_speed()
    return ret_val,clk_count,total_time

def menu():
    spinner = Spinner()
    print(args['file1'])
	#print("Data to be sent will be from file: " + str(args.file1))
    while True:
        print("""
Select a Function:
====================
0: STRLEN
1: STRCMP
2: STRCHR
3: STRRCHR
4: STRCCHR
5: STRSTR
""")
        get_cpu_speed()
        cmd = int(input("Enter a number to indicate a command: "))
        if cmd in [2,3,4]:
            imm = str(raw_input("Enter immediate value: "))
        else:
            imm = None

        res, clk_cnt, time = execute_command(cmd, imm)
        
        print("Return Val: %d 0x%08x" % (res , res))
        print("Clk Count: %d " % clk_cnt)
        print("Time: %s " % time)

if __name__ == '__main__':
	menu()

