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
    ser.timeout = .5
    f = open(args.file, "r")
    
    data = bytearray()
    
    while True:
        ch=f.read(1)
        if not ch: 
            data.extend(chr(4))
            break
        data.extend(ch)
     
    
    op = 0
    delim = ord('b')
    data = bytearray()
    data.append(op)
    data.append(delim)
    data.append(1)
    for i in range(0,128*1 - 1):
        data.append(ord('b'))
    data.append(0)
    data.append(2)
    for i in range(0,128*1 - 2):
        data.append(ord('b'))
    data.append(ord('f'))
    data.append(4)
    
    ser.write(data)
    sleep(.1)
    
    print "Done Transmitting"
    rec = bytearray()
    i = 0
    timeout = False
    try:
        while i< 8:
            ch = ser.read()
            rec.extend(ch)
            i += 1
    except serial.SerialTimeoutException:
        timeout = True
        print "timeout"
        #pass
            
    ser.flush()      
    
    # print len(rec)
    # for i in range(0, len(rec)):
       # strg = "0x%02x" % (rec[i] )
       # print strg 
       
    ret_val = rec[0] | (rec[1] << 8) | (rec[2] << 16) | (rec[3] << 24) 
    clk_cnt = rec[4] | (rec[5] << 8) | (rec[6] << 16) | (rec[7] << 24) 
    strg = "Return Val: %d 0x%08x" % (ret_val , ret_val)
    print strg 
    strg = "Clk Count: %d " % clk_cnt
    print strg
    time = int(clk_cnt) / 50000000.0
    print "Time: " + str(time) + " seconds"
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Send data to the spart")
    parser.add_argument('-p', '--port', required=True, help="Serial Port")
    parser.add_argument('-b', '--baud', required=False, help="Baud Rate - Default 38400")
    parser.add_argument('-f', '--file', required=True, help="File to Send")
    main(parser.parse_args())
