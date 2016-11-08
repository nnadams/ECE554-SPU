#!/usr/bin/env python

import argparse
import sys
import re
import binascii

import mips
from register import Register
from instruction import Instruction
import instruction

parser = argparse.ArgumentParser(description="A very small MIPS assembler.")
parser.add_argument('filename')
parser.add_argument('-t', '--text_base', default=0,
    help="Base location of code", metavar="addr")
parser.add_argument('-d', '--data_base', default=0x4000,
    help="Base location of data", metavar="addr")
parser.add_argument('-o', '--output', default=argparse.SUPPRESS,
  help="Output file", metavar="filename")
parser.add_argument('-p', '--data_out', default=argparse.SUPPRESS,
    help="Output file for data section", metavar="filename")
parser.add_argument('-l', '--littleendian', default=False, action='store_true',
  help="Output as little endian")
parser.add_argument('-v', '--verbose', default=False, action='store_true',
  help="Be verbose")

def zero_fill(num_bytes, out):
  for i in range(0,num_bytes):
    out.write("00,\n")

args = vars(parser.parse_args())

f = open(args['filename'])
lines = f.readlines()
lines = [x.replace("\n", "") for x in lines]
f.close()

mp = mips.MIPSProgram(text_base=args['text_base'], data_base=args['data_base'])
mp.AddLines(lines)

output = open(args['output'], 'w') if 'output' in args else None
endianness = "little" if args['littleendian'] else "top"

if 'output' in args:
  start_addr = int(args['text_base'],16)

  with open(args['output'], 'w') as out:
    print "Writing text to '%s'..."%(args['output']),
    out.write("%02x,\n%02x,\n%02x,\n%02x,\n"%(start_addr>>24,(start_addr>>16)&0xff,(start_addr >> 8)&0xff,start_addr&0xff))
    zero_fill(start_addr/4, out)
    bytes = mp.Bytes(endian=endianness)
    for b in bytes:
      out.write("%02x,\n"%(b,))
  print "done!"

if 'data_out' in args:
  with open(args['data_out'], 'w') as out:
    print "Writing data to '%s'..."%(args['data_out']),
    for s in mp.data:
      for b in list(bytearray(s)):
        out.write("%02x,\n"%b)
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

