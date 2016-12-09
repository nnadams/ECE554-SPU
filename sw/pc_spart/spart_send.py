import serial
import argparse 
from time import sleep 

def main(args):
    ser = serial.Serial()
    if args.baud:
        ser.baudrate = int(args.baud)
    else:
        ser.baudrate = 38400
    ser.port = args.port
    ser.open()
    ser.flushInput()
    ser.flushOutput()
    f = open(args.file, "r")
    
    data = bytearray()
    
    while True:
        ch=f.read(1)
        if not ch: 
            data.extend(chr(4))
            break
        data.extend(ch)
     
    data = bytearray([5, 1, ord('a'), ord('b'), ord('c'), 0, 2, ord('a'), ord('b'), ord('c'), 0, 4])
    print data 
    ser.write(data)
    sleep(.1)
    
    print "Done Transmitting"
    while True:
        ch = ser.read()
        print ch
        if ch == chr(4):
            break
  
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Send data to the spart")
    parser.add_argument('-p', '--port', required=True, help="Serial Port")
    parser.add_argument('-b', '--baud', required=False, help="Baud Rate - Default 38400")
    parser.add_argument('-f', '--file', required=True, help="File to Send")
    main(parser.parse_args())
