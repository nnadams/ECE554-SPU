#!/usr/bin/env python

import argparse
import sys
import re
import binascii

import mips
from register import Register
from instruction import Instruction
import instruction

text_base = 0x10 
data_base = 0x00800000

parser = argparse.ArgumentParser(description="A very small MIPS assembler.")
parser.add_argument('filename')
#parser.add_argument('-t', '--text_base', default=0,
 #   help="Base location of code", metavar="addr")
#parser.add_argument('-d', '--data_base', default=0x0000,
#    help="Base location of data", metavar="addr")
parser.add_argument('-o', '--output', default=argparse.SUPPRESS,
  help="Output file", metavar="filename")
parser.add_argument('-p', '--data_out', default=argparse.SUPPRESS,
    help="Output file for data section", metavar="filename")
parser.add_argument('-l', '--littleendian', default=False, action='store_true',
  help="Output as little endian")
parser.add_argument('-v', '--verbose', default=False, action='store_true',
  help="Be verbose")
parser.add_argument('-s', '--simulator', default='modelsim',
  help="")

def zero_fill(num_bytes, out, simulator):
  if simulator == 'modelsim':
    for i in range(0,num_bytes):
      out.write("00\n")
  elif simulator == 'xilinx':
    for i in range(0,num_bytes/4):
        out.write("00000000,\n")

args = vars(parser.parse_args())

f = open(args['filename'])
lines = f.readlines()
lines = [x.replace("\n", "") for x in lines]
f.close()

mp = mips.MIPSProgram(text_base=text_base, data_base=data_base)
mp.AddLines(lines)
output = open(args['output'], 'w') if 'output' in args else None
endianness = "little" if args['littleendian'] else "top"

if 'output' in args:
  #text_base = int(args['text_base'],16)
  start_addr = text_base + mp.Label("main")*4
  spu_int_addr = text_base + mp.Label("SPU_IRQ")*4
  spart_int_addr = text_base + mp.Label("SPART_IRQ")*4
  with open(args['output'], 'w') as out:
    print "Writing text to '%s'..."%(args['output']),

    bytes = mp.Bytes(endian=endianness)
    if args['simulator'] == 'modelsim':
      out.write("@0\n")
      out.write("%02x\n%02x\n%02x\n%02x\n"%(start_addr>>24,(start_addr>>16)&0xff,(start_addr >> 8)&0xff,start_addr&0xff))
      out.write("%02x\n%02x\n%02x\n%02x\n"%(spu_int_addr>>24,(spu_int_addr>>16)&0xff,(spu_int_addr >> 8)&0xff,spu_int_addr&0xff))
      out.write("%02x\n%02x\n%02x\n%02x\n"%(spart_int_addr>>24,(spart_int_addr>>16)&0xff,(spart_int_addr >> 8)&0xff,spart_int_addr&0xff))
      out.write("00\n00\n00\n00\n")
      for b in bytes:
        out.write("%02x\n"%(b,))

    elif args['simulator'] == 'xilinx':
      out.write("memory_initialization_radix=16;\n")
      out.write("memory_initialization_vector=\n")
      out.write("%02x%02x%02x%02x,\n"%(start_addr>>24,(start_addr>>16)&0xff,(start_addr >> 8)&0xff,start_addr&0xff))
      out.write("%02x%02x%02x%02x,\n"%(spu_int_addr>>24,(spu_int_addr>>16)&0xff,(spu_int_addr >> 8)&0xff,spu_int_addr&0xff))
      out.write("%02x%02x%02x%02x,\n"%(spart_int_addr>>24,(spart_int_addr>>16)&0xff,(spart_int_addr >> 8)&0xff,spart_int_addr&0xff))
      out.write("00000000,\n")
      for j in range(len(bytes)/4):
        out.write("%02x%02x%02x%02x,\n"%tuple(bytes[j*4:j*4+4]))
    else:
      print("Invalid simulator %s" % args['simulator'])
  print "done!"

if 'data_out' in args:
  with open(args['data_out'], 'w') as out:
    print "Writing data to '%s'..."%(args['data_out']),
    if args['simulator'] == 'modelsim':
      out.write("@0\n")
      for s in mp.data:
        for b in list(bytearray(s)):
          out.write("%02x\n"%b)

    elif args['simulator'] == 'xilinx':
      c = 0
      out.write("memory_initialization_radix=16;\n")
      out.write("memory_initialization_vector=\n")
      
      bytes = []
      for s in mp.data:
        bytes += bytearray(s)
      diff = 0
      for i in range(len(bytes)/4):
        c+=4
        out.write("%02x%02x%02x%02x,\n"%(bytes[i*4+3],bytes[i*4+2],bytes[i*4+1],bytes[i*4+0]))
        diff = len(bytes) - c
      a = c
      while (diff + a) % 4 != 0:
        a+=1
        out.write("00")
      for i in range(diff):  
        out.write("%02x"%bytes[len(bytes) - i - 1])
      out.write("\n")
    else:
      print("Invalid simulator %s" % args['simulator'])
  print "done!"


def byte_to_binary(n):
    return ''.join(str((n & (1 << i)) and 1) for i in reversed(range(8)))

def hex_to_binary(h):
    return ''.join(byte_to_binary(ord(b)) for b in binascii.unhexlify(h))



if 'verbose' in args or 'output' not in args:
  binary = mp.Bytes(endian=endianness)
  #for j in range(len(binary)/4):
    # hex_str = "%02x%02x%02x%02x"%tuple(binary[j*4:j*4+4])
    # print hex_to_binary(hex_str)
    # for i in binary[j*4:j*4+4]:
      # print "%02x"%i
    #print "%02x\n%02x\n%02x\n%02x\n"%tuple(binary[j*4:j*4+4])

