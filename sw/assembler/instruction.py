import re

import itertools
from register import Register, UnusedRegister

NAME_NO_SPACE = "(?P<name>[a-zA-Z]+)"
NAME   = NAME_NO_SPACE + "\s+"
LABEL  = "(?P<label>[a-zA-Z_][_0-9a-zA-Z]+)\s*"
IMM    = "(?P<imm>-?[0-9][x0-9A-Fa-f]*)\s*"
FIRST  = "(?P<first>\$[0-9a-zA-Z]+)\s*"
SECOND = "(?P<second>\$[0-9a-zA-Z]+)\s*"
THIRD  = "(?P<third>\$[0-9a-zA-Z]+)\s*"
SPACE  = "\s* \s*"
SEPERATOR  = "\s*(,| )\s*"
COMMA  = "\s*,\s*"
EOL    = "\s*(#.*)?$"

LINE_BEGIN = r"(?i)^[^#]*?"

instruction_types = [
    re.compile(LINE_BEGIN +
      NAME + FIRST + SEPERATOR + SECOND + SEPERATOR + THIRD + EOL),

    re.compile(LINE_BEGIN +
      NAME + FIRST + SEPERATOR + SECOND + SEPERATOR + LABEL + EOL),

    re.compile(LINE_BEGIN +
      NAME + FIRST + SEPERATOR + SECOND + SEPERATOR + IMM + EOL),

    re.compile(LINE_BEGIN +
      NAME + FIRST + SEPERATOR + IMM + "\(\s*" + SECOND + "\s*\)\s*" + EOL),

    re.compile(LINE_BEGIN +
      NAME + FIRST + SEPERATOR + LABEL + EOL),

    re.compile(LINE_BEGIN +
      NAME + FIRST + SEPERATOR + IMM + EOL),

    re.compile(LINE_BEGIN +
      NAME + FIRST + EOL),

    re.compile(LINE_BEGIN +
      NAME + LABEL + EOL),

    re.compile(LINE_BEGIN +
      NAME + IMM + EOL),

    re.compile(LINE_BEGIN +
      NAME_NO_SPACE + EOL)
]
s_type = {
  # String instrucitons
  "slen":    (0x0,0b100011, ["rd", "rs", "rt"]),
  "scmp":    (0x0,0b100011, ["rd", "rs", "rt"]),
  "scat":    (0x0,0b100011, ["rd", "rs", "rt"]),
  "stok":    (0x0,0b100011, ["rd", "rs", "rt"]),
}

s_type_op = {
  # String instrucitons opcode 2
  "slen":    0b0000,
  "scmp":    0b0001,
  "scat":    0b0010,
  "stok":    0b0011,

}

r_type = {
  # Our instrutions
  "add":     (0b011011, 0b00, ["rd", "rs", "rt"]),
  "sub":     (0b011011, 0b01, ["rd", "rs", "rt"]),
  "xor":     (0b011011, 0b10, ["rd", "rs", "rt"]),
  "andn":    (0b011011, 0b11, ["rd", "rs", "rt"]),
  "rol":     (0b011010, 0b00, ["rd", "rs", "rt"]),
  "sll":     (0b011010, 0b01, ["rd", "rt"]),
  "ror":     (0b011010, 0b10, ["rd", "rs", "rt"]),
  "srl":     (0b011010, 0b11, ["rd", "rs"]),
  "seq":     (0b011100, 0b00, ["rd", "rs", "rt"]),
  "sle":     (0b011110, 0b00, ["rd", "rs", "rt"]),
  "sco":     (0b011111, 0b00, ["rd", "rs", "rt"]),
  "slt":     (0b011101, 0b00, ["rd", "rs", "rt"]),
  "halt":    (0b000000, 0b00, [])
}

i_type = {
  # Our instrutions
  "addi":  (0b001000,["rt", "rs"]),
  "subi":  (0b001001,["rt", "rs"]),
  "xori":  (0b001010,["rt", "rs"]),
  "andni": (0b001010,["rt", "rs"]),
  "roli":  (0b010100,["rt", "rs"]),
  "slli":  (0b010101,["rt", "rs"]),
  "rori":  (0b010110,["rt", "rs"]),
  "srli":  (0b010111,["rt", "rs"]),
  "lbi":   (0b011000,["rs"]),
  "slbi":  (0b010010,["rs"]),
  "st":    (0b010000,["rt", "rs"]),
  "ld":    (0b010001,["rt", "rs"]),
  "sb":    (0b111000,["rt", "rs"]),
  "lb":    (0b110000,["rt", "rs"]),
  "stu":   (0b010011,["rt", "rs"]),
  "bltz":  (0b001110,["rs"]),
  "beqz":  (0b001100,["rs"]),
  "bnez":  (0b001101,["rs"]),
  "bgez":  (0b001111,["rs"]),
  "jalr":  (0b000111, ["rs"]),
  "jr":    (0b000101, ["rs"])
  }

j_type = {
  "j":       (0b000100,[]),
  "jal":     (0b000110,[]),
}

supported_pseudoinstructions = ['li', 'nop']

def MakeInstruction(position, **kwargs):
  if 'name' in kwargs and \
      kwargs['name'].lower() in supported_pseudoinstructions:
    return PsedoInstruction(position, **kwargs)
  else:
    return Instruction(position, **kwargs)

# Sometimes we will consider imm to be shamt.
class Instruction:
  def __init__(self, program, position, name=None,
      first=None, second=None, third=None,
      imm=None, label=None):

    name = name.lower()
    #if imm is not None: 
      #print(imm)
    #if label is not None: 
      #print(label)
    if name not in r_type.keys() and \
       name not in i_type.keys() and \
       name not in s_type.keys() and \
       name not in j_type.keys():
      raise Exception("'%s' is not a MIPS opcode"%(name.lower()))

    self.program = program
    self.position = position
    self.name = name

    self.rs = UnusedRegister()
    self.rt = UnusedRegister()
    self.rd = UnusedRegister()

    # Verify that the right registers are present
    registers = (r_type[name][-1] if name in r_type else \
                 s_type[name][-1] if name in s_type else \
                 i_type[name][-1] if name in i_type else \
                 j_type[name][-1])
    rlist = [x for x in [first, second, third] if x is not None]

    if len(registers) == 3 and (first is None or second is None \
        or third is None):
      raise Exception("'%s' requires three registers"%(name))
    if len(registers) == 2 and (first is None or second is None \
        or third is not None):
      raise Exception("'%s' requires two registers"%(name))
    if len(registers) == 1 and (first is None or second is not None \
        or third is not None):
      raise Exception("'%s' requires one register"%(name))
    if len(registers) == 0 and (first is not None or second is not None \
        or third is not None):
      raise Exception("'%s' requires no registers"%(name))

    for pos,reg in zip(registers, rlist):
      if pos == "rs": self.rs = Register(reg)
      if pos == "rd": self.rd = Register(reg)
      if pos == "rt": self.rt = Register(reg)

    if isinstance(imm, int):
      self.imm = imm
    else:
      self.imm = eval(imm) if imm is not None else 0
    self.label = label

    if imm is not None and self.label is not None:
      raise Exception("A label and an immediate. Confused.")

  @staticmethod
  def parseline(program, position, line):
    global instruction_types
    for t in instruction_types:
      m = t.match(line)
      if m is not None:
        g = m.groupdict()

        if 'name' in g and \
            g['name'].lower() in supported_pseudoinstructions:
          return PseudoInstruction(program, position, **m.groupdict())

        return Instruction(program=program, position=position, **g)
    raise Exception("'%s' not an instruction"%(line))

  def ToBinary(self):
    if self.name in r_type.keys():
      b = (r_type[self.name][0] << 26)                            # opcode
      b |= (self.rs.binary() << 21)    # rs
      b |= (self.rt.binary() << 16)    # rt
      b |= (self.rd.binary() << 11)    # rd

      #b |= (self.imm << 6)             # shamt
      b |= (r_type[self.name][1] << 0) # funct
      return b

    if self.name in i_type.keys():
      b = i_type[self.name][0] << 26 # opcode
      #if "jr" == self.name[0]:
          #print self.rs.binary()
      b |= (self.rs.binary() << 21)  # rs
      b |= (self.rt.binary() << 16)  # rt
      if self.label is not None:
        if "b" == self.name[0]:
          print "branch"
          print self.program.Label(self.label)
          print self.position
          z =  (self.program.Label(self.label) - self.position - 1)*4
        else:
          z =  self.program.Label(self.label)
        b |= (z & 0xFFFF)         # label
      else:
        b |= (self.imm & 0xFFFF)   # imm

      return b

    if self.name in j_type.keys():
      b = (j_type[self.name][0]) << 26 #opcode
      if self.label is not None:
        b |= (self.program.Label(self.label))*4 + self.program.text_base
      else:
        b |= (self.imm & 0x03FFFFFF) # address
      return b

    if self.name in s_type.keys():
      # binary = lambda n: '' if n==0 else binary(n/2) + str(n%2)
      b = 0                            # opcode
      b |= (self.rs.binary() << 21)    # rs
      b |= (self.rt.binary() << 16)    # rt
      b |= (self.rd.binary() << 11)    # rd

      # print(s_type_op[self.name]) 
      b |= (s_type_op[self.name] << 7)            # opcode cont.
      #b |= (r_type[self.name][1] << 0)  # delim # TODO figure out what to do here
      return b

  # The size, in words, of this instruction
  def Size(self):
    return 1

  def Bytes(self, endian="big"):
    b = self.ToBinary()
    bytes = [ b >> 24,
              b >> 16 & 0xFF,
              b >> 8 & 0xFF,
              b & 0xFF ]
    return bytes[::-1] if endian.lower() == "little" else bytes


  def __repr__(self):
    return "Instruction(%s, %s, %s, %s, %s, %s)"% \
       (self.name, self.rs, self.rt, self.rd, self.imm, self.label)


class PseudoInstruction:
  def __init__(self, program, position, name=None,
      first=None, second=None, third=None,
      imm=None, label=None):
    self.name = name.lower()
    self.program = program
    self.position = position
    self.instructions = []

    if name == "li":
      if label is not None:
        # get all fancy
        self.instructions.append(Instruction(self.program, position,
          name="lbi", first=first,
          label=lambda: program.Label(label) >> 16 & 0xFFFF))
        self.instructions.append(Instruction(self.program, position+1,
          name="slbi", first=first,
          label=lambda: program.Label(label) & 0xFFFF))
      else:
        self.instructions.append(Instruction(self.program, position,
          name="lbi", first=first,
          imm=((eval(imm) >> 16) & 0xFFFF)))
        self.instructions.append(Instruction(self.program, position+1,
          name="slbi", first=first, 
          imm=(eval(imm) & 0xFFFF)))
    else:
      raise "'%s' not support/not a pseudoinstruction"%(name)

  def Bytes(self, endian="big"):
    return list(itertools.chain( *[x.Bytes(endian=endian) for x
      in self.instructions] ))

  def Size(self):
    return sum([x.Size() for x in self.instructions])

  def ToBinary(self):
    x = 0;
    raise Exception("ToBinary called on a PseudoInstruction")

