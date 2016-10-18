import ply.lex as lex
import re
from Import import *

linenumber=1
temp = ""
printcode = ""
isChar = 0
DEBUGP = 0
error_flag=0
column = 0

currentScope=0
internalScope=0
declaration_flag=0
parameter_flag=0
function=0
counter=0
temp_inherited = Attribute()
temp_Parameters = Attribute()
temp_expression = Attribute()
funcName = ""
templabel = ""
size=0
oldsize=0
assign_flag=0
start = ""
end = ""
funcEndLabel = ""
currentDepth=0
empty_func=0
switch_flag=0
intcode = ""
finalcode = ""
icg1 = ""
coded = ""
fcgFile = file('mips_code','w')
icgFile = file('intermediate_code','w')


tokens =  ['STRING', 'INTEGER', 'DECIMALFLOAT', 'FLOATVAL', 'CHARACTER', 'ESCAPECHAR', 'IF', 'ELSE', 'IDENTIFIER', 'SIZEOF', 'PTR_OP', 'INC_OP', 'DEC_OP', 'LEFT_OP', 'RIGHT_OP', 'LE_OP', 'GE_OP', 'EQ_OP', 'NE_OP', 'AND_OP', 'OR_OP', 'MUL_ASSIGN', 'DIV_ASSIGN', 'MOD_ASSIGN', 'ADD_ASSIGN', 'SUB_ASSIGN', 'LEFT_ASSIGN', 'RIGHT_ASSIGN', 'TYPE_NAME', 'TYPEDEF', 'CHAR', 'INT', 'FLOAT', 'VOID', 'CASE', 'DEFAULT', 'SWITCH', 'WHILE', 'DO', 'FOR', 'CONTINUE', 'BREAK', 'RETURN']

reserved_words = {      
        'break': 'BREAK',
        'case':'CASE',
        'char' : 'CHAR',
        'continue':'CONTINUE',
        'default':'DEFAULT',
        'do' : 'DO',
        'else':'ELSE',
        'float':'FLOAT',
        'for':'FOR',
        'if':'IF',
        'int':'INT',
        'return' : 'RETURN',
        'sizeof':'SIZEOF',
        'switch' : 'SWITCH',
        'typedef':'TYPEDEF',
        'void':'VOID',
        'while':'WHILE'
}        

literals=['[',']','(',')','{','}','=','>','<','!','~',':','+','-','*','/','&','|','^','%','.',';',',','?','#']

t_ADD_ASSIGN='\+='
t_SUB_ASSIGN='\-='
t_MUL_ASSIGN='\*='
t_DIV_ASSIGN='/='
t_RIGHT_OP='>>'
t_LEFT_OP='<<'
t_INC_OP='\+\+'
t_DEC_OP='\-\-'
t_PTR_OP='\->'
t_AND_OP='&&'
t_OR_OP='\|\|'
t_LE_OP='<='
t_GE_OP='>='
t_EQ_OP='=='
t_NE_OP='!='

reserved_map = { }
for r in reserved_words:
      reserved_map[r.lower()] = r


def t_IDENTIFIER(t):
        r'[a-zA-Z_\$][a-zA-Z0-9_\$]*'
        t.type=reserved_map.get(t.value,"IDENTIFIER")
        if reserved_words.has_key(t.value):
	      t.type=reserved_words[t.value]
        return t	

def t_INTEGER(t):
	r'\d+'
	return t	

def t_FLOATVAL(t):
        r'[0-9]+([eE][-+]?[0-9]+)?[fF]'
        return t

def t_DEFINE(t):
	r'\#define.*'
	pass

def t_INCLUDE(t):
	r'\#include[ ]*(<)([A-Za-z_][\w_]*)(\.h)?(>)'
	pass

def t_SINGLELINECOMMENT(t):
	r'//.*'
	pass

def t_MULTILINECOMMENT(t):
	r'/\*[\w\W]*?\*/'
	pass

def t_CHARACTER(t):
	r'[\'][^\\\'\"\n][\']'
	return t	


def t_ESCAPECHAR(t):
	r'[\'][\\][nbtfrva\'\"\\?0][\']'
	return t	

def t_STRING(t):
	r'"[^\n]*?(?<!\\)"'
	return t

def t_newline(t):
      r'\n+'
      global linenumber
      linenumber = linenumber + 1
      t.lexer.lineno += t.value.count("\n")        

t_ignore = " \t\r\v\a\f"


success= True
	
def t_error(t):
      global success
      print "Line %d :" % (t.lineno,) + "LEXICAL ERROR FOUND. Illegal Character: ", t.value[0] + "\n",
      t.lexer.skip(1)
      success= False

lex.lex()

start = 'strt'

precedence =  [('nonassoc', 'STRING', 'INTEGER', 'DECIMALFLOAT'), ('nonassoc', 'FLOATVAL', 'CHARACTER', 'ESCAPECHAR'), ('nonassoc', 'IFX'), ('nonassoc', 'ELSE'), ('nonassoc', 'FLOAT', 'INT', 'VOID', 'CHAR', ';'), ('right', 'ADD_ASSIGN', 'SUB_ASSIGN', 'MUL_ASSIGN', 'DIV_ASSIGN', 'MOD_ASSIGN', 'RIGHT_ASSIGN', 'LEFT_ASSIGN'), ('right', '=', '|', '!', '^'), ('left', 'OR_OP', 'AND_OP', 'RIGHT_OP', 'LEFT_OP', 'INC_OP', 'DEC_OP', 'PTR_OP', 'LE_OP', 'GE_OP', 'EQ_OP', 'NE_OP'), ('left', ':', '<', '>'), ('left', '+', '-'), ('left', '*', '/', '%'), ('right', '(', '[', '{'), ('left', ')', ']', '}')]

# -------------- RULES ----------------

def p_new_scope(t):
	'''new_scope : '''	
	#print "\np_new_scope_1(t)\n"
	global DEBUGP
	global currentScope
	global tail
	global function
	global empty_func
	if DEBUGP:
	      print "\np_new_scope_1(t)\n"
	currentScope = currentScope + 1	
#	print currentScope    --- 0
	temp = CreateNewSymTableNode()
	temp.scope = tail[function].scope + 1
	tail[function].next = temp
	tail[function] = temp
	empty_func = 0

def p_finish_scope(t):
	'''finish_scope : '''
	#print "\nfinish_scope : \n"	    
	global DEBUGP
	global currentScope
	global function
	global tail
	global global1
	if DEBUGP:
	      print "\nfinish_scope : \n"	    
#	print currentScope    --- 0
	if currentScope > 0:
	    PopSym(function)
	    currentScope = currentScope - 1
	else:	      
	      global1[1] = CreateNewSymTableNode()
	      tail[1] = global1[1]
	      

def p_identifier(t):
	'''identifier : IDENTIFIER'''
	#print "\nidentifier : IDENTIFIER\n"	
	global parameter_flag
	global currentScope
	global function
	global linenumber
	global MaxPar
	global size
	global DEBUGP	
	if DEBUGP:
	      print "\nidentifier : IDENTIFIER\n"
	p = SymEntry()
	if parameter_flag == 0:		
		p = lookup(t[1],function)
		if p == None:
			#print "Error Check: Inside If. Symbol not found in symbol table"
			p = InsertSymTable(t[1],currentScope,0,function)
			p.linenum = linenumber
			p.type = 0
			p.offset = size
			size = size + 4
			p.keywordval = 0
			p.isPointer = 0
			p.isArray = 0
			p.ArrayLimit = 0
			p.isFunction = 0
			p.numParameters=0
			for counter in range(MaxPar):
			      p.ParameterList[counter]=Attribute()
		elif p.scope == currentScope:
			pass		  
	else:	   
		p = SymEntry()
		p.id = ""
		p.id = t[1]
		p.linenum = 0	 
		p.type=0
		p.scope=1000				     
		p.keywordval=0	
		p.isPointer=0
		p.isArray=0
		p.ArrayLimit=0
		p.isFunction=0
		p.offset=-1
		p.width=0
		p.numParameters=0
		for counter in range(MaxPar):
			p.ParameterList[counter]=Attribute()
	t[0] = p


def p_constant_1(t):
	'''constant : INTEGER'''
	global DEBUGP
	if (DEBUGP):
	  print "\nconstant : INTEGER\n"
	t[0]=Attribute()
	t[0]=initAttr(t[0])
	t[0].IntConstValue=t[1]
	t[0].specifier=4
	t[0].type=400

def p_constant_2(t):
        '''constant : DECIMALFLOAT'''
        #print "\nconstant->DECIMALFLOAT\n"
        global DEBUGP
	if (DEBUGP):
	  print "\nconstant->DECIMALFLOAT\n"
	t[0]=Attribute()
	t[0]=initAttr(t[0])
	t[0].IntConstValue=t[1]
	t[0].specifier=6
	t[0].type=600
def p_constant_3(t):
        '''constant : FLOATVAL'''
        #print "\nconstant->FLOATVAL\n"
        global DEBUGP
	if (DEBUGP):
	  print "\nconstant->FLOATVAL\n"
	t[0]=Attribute()
	t[0]=initAttr(t[0])
	t[0].IntConstValue=t[1]
	t[0].specifier=6
	t[0].type=600

def p_constant_4(t):
        '''constant : CHARACTER'''
        #print "\nconstant:CHARACTER\n"
        global DEBUGP
        if (DEBUGP):
	  print "\nconstant:CHARACTER\n"
	t[0]=Attribute()
	t[0]=initAttr(t[0])
	t[0].specifier=2
	t[0].IntConstValue=t[1]
	t[0].type=200

def p_constant_5(t):
        '''constant : ESCAPECHAR'''
        #print "\nconstant:ESCAPECHAR\n"
        global DEBUGP
        if (DEBUGP):
	  print "\nconstant:ESCAPECHAR\n"
	t[0]=Attribute()
	t[0]=initAttr(t[0])
	t[0].specifier=2
	t[0].IntConstValue=t[1]
	t[0].type=200

def p_constant_6(t):
        '''constant : STRING'''        
        #print "\nconstant : STRING\n"
        global DEBUGP
        if (DEBUGP):
	  print "\nconstant : STRING\n"
	t[0]=Attribute()
	t[0]=initAttr(t[0])
	t[0].specifier=2
	t[0].isString=1
	t[0].StringValue=t[1]
	t[0].type=200

def p_primary_expression_1(t):
        '''primary_expression : identifier'''        
        #print "\nprimary_expression : identifier\n"
        global DEBUGP
        global error_flag
        if (DEBUGP):
	  print "\nprimary_expression : identifier\n"
	if (t[1].type==0):
	  error_flag=1
	  print "Error " +t[1].id+" not Defined "
	t[0]=PassSymEntry(t[1])
	t[0].specifier=t[0].type/100 

def p_primary_expression_2(t):
      '''primary_expression : constant'''
      #print "\nprimary_expression:constant\n"
      global DEBUGP
      global size
      global intcode
      global finalcode
      
      if (DEBUGP):
	print "\nprimary_expression:constant\n"
      t[0]=PassAttribute(t[1])
      t[0].qualifier=1
      if (t[0].type==400):
	t[0].id=getNewTemp()
	t[0].offset=size
	size=size+4
	coded="\t"+t[0].id+" = "+t[1].IntConstValue+"\n"
	intcode=coded
	coded="\tli $t0 "+ t[1].IntConstValue+"\n"
	finalcode=coded
	coded="\tsw $t0 "+toAddr(t[0].offset)+"\n"
	finalcode=finalcode+coded
	t[0].code=finalcode
	t[0].icode=intcode
      
def p_primary_expression_3(t):
      '''primary_expression : '(' expression ')'
      '''
      #print "\nprimary_expression: '(' expression ')' \n"
      if (DEBUGP):
	print "\nprimary_expression: '(' expression ')' \n"
      t[0]=PassAttribute(t[2])

def p_postfix_expression_1(t):
      '''postfix_expression : primary_expression'''
      #print "\npostfix_expression: primary expression \n"
      if (DEBUGP):
	print "\npostfix_expression: primary expression \n"
      t[0]=PassAttribute(t[1])
 

def p_postfix_expression_2(t):
      '''postfix_expression : postfix_expression '[' expression ']'
      '''
      #print "\npostfix_expression : postfix_expression '[' expression ']'\n"
      global DEBUGP
      global error_flag
      global assign_flag
      global size
      global intcode
      global finalcode
      if(DEBUGP):
	    print "\npostfix_expression : postfix_expression '[' expression ']'\n"
      t[0]=PassAttribute(t[1])
      if(t[1].isArray!=1):
	print "Error :Trying to access an index of a non array.\n"
	error_flag=1
      else:
	t[0].isArray=0
	t[0].id = getNewTemp()
	if(assign_flag==1):
	  t[0].offset = size
	  size =size+4
	  intcode=t[3].icode
	  finalcode=t[3].code
	  coded="\t"+t[0].id+" = "+t[1].id+"["+t[3].id+"]\n"
	  intcode = intcode+coded
	  coded="\tli $t0 "+t[1].offset+"\n"
	  finalcode=finalcode+coded
	  coded="\tlw $t1 "+toAddr(t[3].offset)+"\n"
	  finalcode= finalcode+coded
	  coded="\tsll $t1 $t1 2\n"
	  finalcode=finalcode+coded
	  coded="\tadd $t0 $t0 $t1\n"
	  finalcode=finalcode+coded
	  coded="\tsub $t1 $sp $t0\n"
	  finalcode=finalcode+coded
	  coded="\tlw $t1 0($t1)\n"
	  finalcode=finalcode+coded
	  coded="\tsw $t1 "+toAddr(t[0].offset)+"\n"
	  finalcode=finalcode+coded
	  t[0].icode=intcode
	  t[0].code=finalcode
	else:
	  t[0].qualifier=3
	  t[0].offset=size
	  size=size+4
	  coded = "\t"+t[0].id+" = "+t[1].id+"["+t[3].id+"]\n"
	  intcode=coded
	  finalcode=t[3].code
	  coded="\tli $t0 "+str(t[1].offset)+"\n"
	  finalcode=finalcode+coded
	  coded="\tlw $t1 " +toAddr(t[3].offset)+"\n"
	  finalcode=finalcode+coded
	  coded="\tsll $t1 $t1 2\n"
	  finalcode=finalcode+coded
	  coded="\tadd $t0 $t0 $t1\n"
	  finalcode=finalcode+coded
	  coded="\tsub $t1 $sp $t0\n"
	  finalcode=finalcode+coded
	  coded="\tsw $t1 "+toAddr(t[0].offset)+"\n"
	  finalcode=finalcode+coded
	  t[0].icode=intcode
	  t[0].code=finalcode

def p_postfix_expression_3(t):
      '''postfix_expression : postfix_expression '(' ')'      '''
      #print "\n postfix_expression : postfix_expression '(' ')'\n"
      global DEBUGP
      global error_flag
      global MaxFunctionLength
      global size
      global intcode
      global finalcode
      if (DEBUGP):
	print "\n postfix_expression : postfix_expression '(' ')'\n"
      t[0]=PassAttribute(t[1])
      if(t[1].isFunction!=1):
	print "Error :Trying to access an index of a non array.\n"
	error_flag=1
      t[0].isFunction=0
      if(error_flag==0):
	t[0].id=getNewTemp()
	t[0].offset=size
	size=size+4
	finalcode=""
	intcode=""
	coded= "\taddi $sp $sp" +str(MaxFunctionLength)+"\n"
	finalcode=finalcode+coded
	coded="\tjal "+t[1].id+"\n"
	finalcode=finalcode+coded
	if (t[1].type!=100):
	  coded="\t"+t[0].id+" = call function "+t[1].id+"\n"
	  intcode=intcode+coded
	  coded="\tlw $t0 "+toAddr(0)+"\n"
	else:
	  coded="\tcall function "+t[1].id+"\n"
	  intcode=intcode+coded
	  coded="\tli $t0 $0\n"
	finalcode=finalcode+coded
	coded="\taddi $sp $sp -" + str(MaxFunctionLength)+"\n"
	finalcode=finalcode+coded
	coded="\tsw $t0 " + toAddr(t[0].offset)+"\n"
	finalcode=finalcode+coded
	t[0].code=finalcode
	t[0].icode=intcode
	

def p_postfix_expression_4(t):
      '''postfix_expression : postfix_expression '(' argument_expression_list ')'  '''
      #print "\npostfix_expression : postfix_expression'(' argument_expression_list ')' \n"
      global DEBUGP
      global error_flag
      global size
      global MaxFunctionLength
      global intcode
      global finalcode
      if DEBUGP:
	print "\npostfix_expression : postfix_expression'(' argument_expression_list ')' \n"      
      t[0]=PassAttribute(t[1])
      t[0].isFunction=0
      t[0].numParameters=0
      
      if t[1].isFunction!=1:
	print "Error : Trying to access a non function as a function\n"
	error_flag=1
      elif(t[1].id!="print_t") :
	for counter in range(t[1].numParameters):
	  temp1 = Attribute()
	  temp1 = t[1].ParameterList[counter]
	  temp2 = t[3].ParameterList[counter]
	  if (temp1.type!=temp2.type):
	  	 error_flag=1		
	   	 print " Error : parameter " + str(counter)+ " type does not match\n"
		 raise SyntaxError
      if (error_flag==0):
	if t[1].id=="print_t":
	  t[0].id=getNewTemp()
	  intcode=t[3].icode
	  finalcode=t[3].code
	  coded="\n\tprint _t "+t[3].ParameterList[0].id+"\n"
	  intcode=intcode+coded
	  coded="\n\tlw $t0 "+toAddr(t[3].ParameterList[0].offset)+"\n"
	  finalcode=finalcode+coded
	  coded="\tli $v0 1\n"
	  finalcode=finalcode+coded
	  coded="\tmove $a0 $t0\n"
	  finalcode=finalcode+coded
	  coded="\tsyscall\n"
	  finalcode=finalcode+coded
	  t[0].icode=intcode
	  t[0].code=finalcode
	else:
	  t[0].id=getNewTemp()
	  t[0].offset=size
	  size=size+4
	  finalcode=t[3].code
	  intcode=t[3].icode
	  for counter in range(t[3].numParameters):
	    coded="\tlw $t0 "+toAddr(t[3].ParameterList[counter].offset)+"\n"
	    finalcode=finalcode+coded
	    coded="\tsw $t0 "+str(MaxFunctionLength-(counter+1)*4)+"($sp)\n"
	    finalcode=finalcode+coded
	    coded="\tparam "+t[3].ParameterList[counter].id+"\n"
	    intcode=intcode+coded
	  coded="\taddi $sp $sp "+str(MaxFunctionLength)+"\n"
	  finalcode=finalcode+coded
	  coded="\tjal " +t[1].id+"\n"
	  finalcode=finalcode+coded
	  if(t[1].type!=100):
	    coded="\t"+t[0].id +"= call function "+t[1].id+"\n"
	    intcode=intcode+coded
	    coded="\tlw $t0 " +toAddr(0)+"\n"
	  else:
	    coded="\tcall function "+t[1].id+"\n"
	    intcode=intcode+coded
	    coded="\tlw $t0 $0\n"
	  finalcode=finalcode+coded
	  coded="\taddi $sp $sp -" +str(MaxFunctionLength)+"\n"
	  finalcode=finalcode+coded
	  coded="\tsw $t0 "+toAddr(t[0].offset)+"\n"
	  finalcode=finalcode+coded
	  t[0].code=finalcode
	  t[0].icode=intcode

def p_postfix_expression_5(t):
      '''postfix_expression : postfix_expression '.' identifier'''
      #print " postfix_expression : postfix_expression '.' identifier"
      global DEBUGP
      if DEBUGP:
	print " postfix_expression : postfix_expression '.' identifier"

def p_postfix_expression_6(t):
      '''postfix_expression : postfix_expression PTR_OP identifier'''
      #print " postfix_expression : postfix_expression PTR OP identifier"
      global DEBUGP
      if DEBUGP:
	print " postfix_expression : postfix_expression PTR OP identifier"

def p_postfix_expression_7(t):
      '''postfix_expression : postfix_expression INC_OP'''
      #print " postfix_expression: postfix_expression INC OP"
      global DEBUGP
      global error_flag
      global assign_flag
      global size
      global intcode
      global finalcode
      if DEBUGP:
	print " postfix_expression: postfix_expression INC OP"
      t[0]=PassAttribute(t[1])
      if (t[1].specifier == 1) or (t[1].specifier ==10 ) or (t[1].specifier==11 ) or (t[1].specifier ==12 ) or (t[1].specifier==13) or (t[1].specifier==14) or (t[1].isString==1) or (t[1].specifier==1):  
	error_flag=1
	print " Error : Cannot perform ++ on this kind of data type"
      t[0].offset=size
      size=size+4
      t[0].id = getNewTemp()
      coded= "\t"+t[1].icode+"	" + t[1].id+"++\n"
      intcode =coded
      coded= "\t"+t[1].code+"lw $t0 "+ toAddr(t[1].offset)+"\n"
      finalcode=coded
      if assign_flag==1:
	coded= "\tsw $t0"+ toAddr(t[0].offset)+"\n"
	finalcode = finalcode+coded
	coded= "\taddi $t0 $t0 1\n"
	finalcode=finalcode+1
	coded="\tsw $t0 " + toAddr(t[1].offset)+"\n"
      else:
	coded="\taddi $t0 $t0 1\n"
	finalcode=finalcode+coded
	coded= "\tsw $t0 " + toAddr(t[1].offset)+"\n"
	finalcode=finalcode+ coded
	coded= "\ts1 $t0 "+toAddr(t[1].offset)+"\n"
      finalcode = finalcode+coded
      t[0].code=finalcode
      t[1].icode=intcode 

def p_postfix_expression_8(t):
      '''postfix_expression : postfix_expression DEC_OP'''
      #print " postfix_expression: postfix_expression DEC OP"
      global DEBUGP
      global error_flag
      global assign_flag
      global size
      global intcode
      global finalcode
      if DEBUGP:
	print " postfix_expression: postfix_expression DEC OP"
      t[0]=PassAttribute(t[1])
      if (t[1].specifier == 1) or(t[1].specifier ==10 ) or (t[1].specifier==11 ) or (t[1].specifier ==12 ) or (t[1].specifier==13) or (t[1].specifier==14) or (t[1].isString==1) or (t[1].specifier==1):  
	error_flag=1
	print " Error : Cannot perform -- on this kind of data type"
      t[0].offset=size
      size=size+4
      t[0].id = getNewTemp()
      coded= "\t"+t[1].icode+"	" + t[1].id+"--\n"
      intcode =coded
      coded= "\t"+t[1].code+"lw $t0 "+ toAddr(t[1].offset)+"\n"
      finalcode=coded
      if assign_flag==1:
	coded= "\tsw $t0"+ toAddr(t[0].offset)+"\n"
	finalcode = finalcode+coded
	coded= "\taddi $t0 $t0 -1\n"
	finalcode=finalcode+1
	coded="\tsw $t0 " + toAddr(t[1].offset)+"\n"
      else:
	coded="\taddi $t0 $t0 -1\n"
	finalcode=finalcode+coded
	coded= "\tsw $t0 " + toAddr(t[1].offset)+"\n"
	finalcode=finalcode+ coded
	coded= "\ts1 $t0 "+toAddr(t[1].offset)+"\n"
      finalcode = finalcode+coded
      t[0].code=finalcode
      t[1].icode=intcode 

def p_argument_expression_list_1(t):
      '''argument_expression_list : assignment_expression'''
      #print "argument_expression_list -> assignment_expression"
      global DEBUGP
      if (DEBUGP):
	print "argument_expression_list -> assignment_expression"
      t[0] = Attribute()
      t[0]=initAttr(t[0])
      t[0].ParameterList[0]=PassAttribute(t[1])
      t[0].numParameters=1
      t[0].code=t[1].code
      t[0].icode=t[1].icode
      
def p_argument_expression_list_2(t):
      '''argument_expression_list : argument_expression_list ',' assignment_expression'''
      global DEBUGP
      #print "argument_expression_list -> argument_expression_list , assignment_expression\n"
      if(DEBUGP):
	print "\nargument_expression_list -> argument_expression_list , assignment_expression"
      t[0]=PassAttribute(t[1])
      t[0].ParameterList[t[0].numParameters]=PassAttribute(t[3])
      t[0].numParameters=t[0].numParameters+1
      if(t[3].code!=None):
	t[0].code=t[0].code+t[3].code
	t[0].icode=t[0].icode+t[3].icode
			
def p_unary_expression_1(t):
      '''unary_expression : postfix_expression'''
      #print "unary_expression:postfix_expression"
      global DEBUGP
      if DEBUGP:
	print "unary_expression:postfix_expression"
      t[0]=PassAttribute(t[1])

def p_unary_expression_2(t):
      '''unary_expression : INC_OP unary_expression'''
      #print "unary_expression: INC_OP unary_expression"
      global DEBUGP
      global size
      global error_flag
      global intcode
      global finalcode
      if (DEBUGP):
	print "unary_expression: INC_OP unary_expression"
      t[0]=PassAttribute(t[2])
      if (t[2].specifier == 1) or(t[2].specifier ==10 ) or (t[2].specifier==11 ) or (t[2].specifier ==12 ) or (t[2].specifier==13) or (t[2].specifier==14) or (t[2].isString==1) or (t[2].qualifier==1):
	error_flag=1
	print "\n Unable to perform increment \"++\" on this kind of data type.\n"
      t[0].offset=size
      size=size+4
      t[0].id=getNewTemp()
      coded="\t"+t[2].icode+"	++"+t[2].id+"\n"
      intcode=coded
      coded="\t"+t[2].code+" lw $t0 "+toAddr(t[2].offset)+"\n"
      finalcode=coded
      coded="\taddi $t0 $t0 1\n"
      finalcode=finalcode+coded
      coded="\tsw $t0 "+toAddr(t[0].offset)+"\n"
      finalcode=finalcode+coded
      coded="\tsw $t0 "+toAddr(t[2].offset)+"\n"
      finalcode=finalcode+coded
      t[0].code=finalcode
      t[0].icode=intcode
      
def p_unary_expression_3(t):
      '''unary_expression : DEC_OP unary_expression'''
      #print "unary_expression: DEC_OP unary_expression"
      global DEBUGP
      global size
      global error_flag
      global intcode
      global finalcode
      if (DEBUGP):
	print "unary_expression: DEC_OP unary_expression"
      t[0]=PassAttribute(t[2])
      if (t[2].specifier == 1) or(t[2].specifier ==10 ) or (t[2].specifier==11 ) or (t[2].specifier ==12 ) or (t[2].specifier==13) or (t[2].specifier==14) or (t[2].isString==1) or (t[2].qualifier==1):
	error_flag=1
	print "\nCannot perform pre-decrement -- on this kind of data type.\n"
      t[0].offset=size
      size=size+4
      t[0].id=getNewTemp()
      coded="\t"+t[2].icode+" --"+t[2].id+"\n"
      intcode=coded
      coded="\t"+t[2].code+" lw $t0 "+toAddr(t[2].offset)+"\n"
      finalcode=coded
      coded="\taddi $t0 $t0 -1\n"
      finalcode=finalcode+coded
      coded="\tsw $t0 "+toAddr(t[0].offset)+"\n"
      finalcode=finalcode+coded
      coded="\tsw $t0 "+toAddr(t[2].offset)+"\n"
      finalcode=finalcode+coded
      t[0].code=finalcode
      t[0].icode=intcode

def p_unary_expression_4(t):
      '''unary_expression : unary_operator cast_expression'''
      #print "unary_expression:unary_expression cast_expression"
      global DEBUGP
      global size
      global error_flag
      global assign_flag
      global intcode
      global finalcode
      if(DEBUGP):
	print "\nunary_expression -> unary_operator cast_expression\n"
      t[0]=PassAttribute(t[2])
      if(t[1] == '!'):
	#------------code generation-------------
	t[0].offset = size
	size = size + 4
	t[0].id=getNewTemp()
	coded=t[2].icode+"\t"+t[0].id+" = !"+t[2].id+"\n"
	intcode=coded
	coded=t[2].code+"\tlw $t0 " +toAddr(t[2].offset)+"\n"
	finalcode=coded
	coded="\tli $t1 0\n"
	finalcode=finalcode+coded
	coded="\tslt $t2 $t0 $t1\n"
	finalcode=finalcode+coded
	coded="\tslt $t3 $t1 $t0\n"
	finalcode=finalcode+coded
	coded="\tadd $t1 $t2 $t3\n"
	finalcode=finalcode+coded
	coded="\tli $t0 1\n"
	finalcode=finalcode+coded
	coded="\tsub $t0 $t0 $t1\n"
	finalcode=finalcode+coded
	coded="\tsw $t0 "+toAddr(t[0].offset)+"\n"
	finalcode=finalcode+coded
	t[0].code=finalcode
	t[0].icode=intcode
      if(t[1] == '~'):
	t[0].offset=size
	size=size+4
	t[0].id=getNewTemp()
	coded=t[2].icode+"\t"+t[0].id+" = !"+t[2].id+"\n"
	intcode=coded
	coded=t[2].code+"\tlw $t0 "+toAddr(t[2].offset)+"\n"
	finalcode=finalcode+coded
	coded="\tnor $t1 $t0 $0\n"
	finalcode=finalcode+coded
	coded="\tsw $t1 "+toAddr(t[0].offset)+"\n"
	finalcode=finalcode+coded
	t[0].code=finalcode
	t[0].icode=intcode
      if(t[1] == '-'):
	t[0].offset=size
	size=size+4
	t[0].id=getNewTemp()
	coded=t[2].icode+"\t"+t[0].id+" = !"+t[2].id+"\n"
	intcode=coded
	coded=t[2].code+"\tlw $t0 "+toAddr(t[2].offset)+"\n"
	finalcode=finalcode+coded
	coded="\tsub $t1 $t0 $0\n"
	finalcode=finalcode+coded
	coded="\tsw $t1 "+toAddr(t[0].offset)+"\n"
	finalcode=finalcode+coded
	t[0].code=finalcode
	t[0].icode=intcode
      if(t[1] == '&'):
	t[0].offset=size
	size=size+4
	t[0].id=getNewTemp()
	coded=t[2].icode+"\t"+t[0].id+" = !"+t[2].id+"\n"
	intcode=coded
	coded=t[2].code+"\tlw $t0 "+toAddr(t[2].offset)+"\n"
	finalcode=finalcode+coded
	coded="\tsub $t1 $t0 $0\n"
	finalcode=finalcode+coded
	coded="\tsw $t1 "+toAddr(t[0].offset)+"\n"
	finalcode=finalcode+coded
	t[0].code=finalcode
	t[0].icode=intcode
      if(t[1] == '*'):
	t[0].isPointer=0
	t[0].id=getNewTemp()
	if(t[2].isPointer!=1):
	  error_flag=1
	  print "\nError : Invalid Operation on a non-pointer\n"
	else:
	  if(assign_flag==1):
	    t[0].offset=size
	    size=size+4
	    coded="\t"+t[0].id+" = *"+t[2].id+"\n"
	    intcode=intcode+coded
	    coded="\tlw $t0 "+toAddr(t[2].offset)+"\n"
	    finalcode=finalcode+coded
	    coded="\tlw $t1 " +toAddr(t[2].offset)+"($t0)"+"\n"
	    finalcode=finalcode+coded
	    coded="\tsw $t1 "+toAddr(t[0].offset)+"\n"
	    finalcode=finalcode+coded
	    t[0].icode=intcode
	    t[0].code=finalcode
	  else:
	    t[0].qualifier=3
	    t[0].offset = size
	    size=size+4
	    coded="\t"+t[0].id+" = Address of *"+t[2].id+"\n"
	    intcode=coded
	    finalcode=t[2].code
	    coded="\tlw $t0 "+toAddr(t[2].offset)+"\n"
	    finalcode=finalcode+coded
	    coded="\tsw $t0 " + toAddr(t[0].offset)+"\n"
	    finalcode=finalcode+coded
	    t[0].icode=intcode
	    t[0].code=finalcode
	    
def p_unary_expression_5(t):
      '''unary_expression : SIZEOF unary_expression'''
      #print "unary_expression:SIZEOF unary_expression"
      global DEBUGP
      if (DEBUGP):
	print "unary_expression:SIZEOF unary_expression"
      t[0].initAttr(t[0])
      t[0].IntConstValue=t[2].width		
      t[0].qualifier=1
      t[0].specifier=5
      t[0].type=500
		   

def p_unary_expression_6(t):
      '''unary_expression : SIZEOF '(' type_name ')'      '''
      #print "unary_expression:SIZEOF '(' type_name ')'"
      global DEBUGP
      if (DEBUGP):
	print "unary_expression:SIZEOF '(' type_name ')'"
      t[0].initAttr(t[0])
      t[0].IntConstValue=t[3].width		
      t[0].qualifier=1
      t[0].specifier=5
      t[0].type=500

def p_unary_operator_1(t):
      '''unary_operator : '&'
      '''
      #print "\nunary_operator : '&'\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nunary_operator : '&'\n"
      t[0]='&'

def p_unary_operator_2(t):
      '''unary_operator : '*'
      '''
      #print "\nunary_operator : '*'\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nunary_operator : '*'\n"
      t[0]='*'

def p_unary_operator_3(t):
      '''unary_operator : '+'   '''
      #print "\nunary_operator : '+'\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nunary_operator : '+'\n"
      t[0]='+'

def p_unary_operator_4(t):
      '''unary_operator : '-'    '''
      #print "\nunary_operator : '-'\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nunary_operator : '-'\n"
      t[0]='-'

def p_unary_operator_6(t):
      '''unary_operator : '!'
      '''
      #print "\nunary_operator : '!'\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nunary_operator : '!'\n"
      t[0]='!'

def p_cast_expression_1(t):
      '''cast_expression : unary_expression'''
      #print "\ncast_expression : unary_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\ncast_expression : unary_expression\n"
      t[0]=PassAttribute(t[1])
      

def p_cast_expression_2(t):
      '''cast_expression : '(' type_name ')' cast_expression'''
      #print "\ncast_expression -> ( type_name ) cast_expression\n"
      global DEBUGP
      global error_flag
      if(DEBUGP):
	    print "\ncast_expression -> ( type_name ) cast_expression\n"
      t[0]=PassAttribute(t[2])
      if(t[4].id!=None):
	    t[0].id = t[4].id
      if(t[4].isArray==1 or t[4].isString==1):      
	    error_flag=1
	    print "\nError : Cannot Type Cast an Array or a String\n"      
      else:            
	    
	    t[0].scope=t[4].scope
	    if((t[2].specifier==4 or t[2].specifier==5) and (t[4].specifier==4 or t[4].specifier==5)): 	    
		  t[0].IntConstValue=t[4].IntConstValue
		  
	    elif((t[2].specifier==4 or t[2].specifier==5) and (t[4].specifier==6 or t[4].specifier==7)): 	    
		  t[0].IntConstValue=t[4].FloatConstValue	    
	    elif((t[2].specifier==6 or t[2].specifier==7) and (t[4].specifier==4 or t[4].specifier==5)): 	    
		  t[0].FloatConstValue=t[4].IntConstValue	    
	    elif((t[2].specifier==6 or t[2].specifier==7) and (t[4].specifier==6 or t[4].specifier==7)): 	    
		  t[0].FloatConstValue=t[4].FloatConstValue	    
	    elif((t[2].specifier==4 or t[2].specifier==5) and (t[4].specifier==2)): 	    
		  t[0].IntConstValue=t[4].StringValue[0]	    
	    else:
		  error_flag=1
		  print "\nError : Unsupported Casting for this Compiler\n"	    	    
	    t[0].IntConst=t[4].IntConst			    
	    if(t[4].StringValue!=None):
		  t[0].StringValue = t[4].StringValue	    

def p_multiplicative_expression_1(t):
      '''multiplicative_expression : cast_expression'''
      #print "\nmultiplicative_expression : cast_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nmultiplicative_expression : cast_expression\n"
      t[0]=PassAttribute(t[1])     

def p_multiplicative_expression_2(t):
      '''multiplicative_expression : multiplicative_expression '*' cast_expression'''
      #print "\nmultiplicative_expression -> multiplicative_expression '*' cast_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if(DEBUGP):
	    print "\nmultiplicative_expression -> multiplicative_expression '*' cast_expression\n"
     
      if(error_flag==1):      
	    print "\nError : Cannot multiply incompatible data types.\n"
	    t[0]=PassAttribute(t[1]) 
      else:      
	    t[0]=MergeAttributes3Code(t[1],t[3])	    
	    t[0].qualifier=2
	    t[0].offset = size
	    size = size + 4
	    t[0].id = getNewTemp()	    
	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" * "+t[3].id+"\n"  	    
	    intcode=coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n" 	    
	    finalcode=coded
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"	    
	    finalcode=finalcode+coded
	    coded = "\tmult $t0 $t1\n"	    
	    finalcode=finalcode+coded
	    coded = "\tmflo $t2\n"
	    finalcode=finalcode+coded 
	    coded = "\tsw $t2 "+toAddr(t[0].offset)+"\n" 	    
	    finalcode=finalcode+coded
	    t[0].code=finalcode
	    t[0].icode=intcode

def p_multiplicative_expression_3(t):
      '''multiplicative_expression : multiplicative_expression '/' cast_expression'''
      #print "\nmultiplicative_expression -> multiplicative_expression '/' cast_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if(DEBUGP):
	    print "\nmultiplicative_expression -> multiplicative_expression '/' cast_expression\n"
     
      if(error_flag==1):      
	    print "\nError : Cannot divide incompatible data types.\n"
	    t[0]=PassAttribute(t[1])
      else:      
	    t[0]=MergeAttributes3Code(t[1],t[3])	    
	    t[0].qualifier=2
	    t[0].offset = size
	    size = size + 4
	    t[0].id = getNewTemp()	    
	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" / "+t[3].id+"\n"  	    
	    intcode=coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n" 	    
	    finalcode=coded
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"	    
	    finalcode=finalcode+coded
	    coded = "\tdiv $t0 $t1\n"	    
	    finalcode=finalcode+coded
	    coded = "\tmflo $t2\n"
	    finalcode=finalcode+coded 
	    coded = "\tsw $t2 "+toAddr(t[0].offset)+"\n" 	    
	    finalcode=finalcode+coded
	    t[0].code=finalcode
	    t[0].icode=intcode
      

def p_multiplicative_expression_4(t):
      '''multiplicative_expression : multiplicative_expression '%' cast_expression'''
      #print "\nmultiplicative_expression -> multiplicative_expression MOD cast_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if(DEBUGP):
	    print "\nmultiplicative_expression -> multiplicative_expression MOD cast_expression\n"
      
      if(error_flag==1):      
	    print "\nError : Unable to perform Mod operation. Incompatible data types.\n"
	    t[0]=PassAttribute(t[1]) 
      else:      
	    t[0]=MergeAttributes3Code(t[1],t[3])	    
	    t[0].qualifier=2
	    t[0].offset = size
	    size = size + 4
	    t[0].id = getNewTemp()	    
	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" mod "+t[3].id+"\n"  	    
	    intcode=coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n" 	    
	    finalcode=coded
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"	    
	    finalcode=finalcode+coded
	    coded = "\tdiv $t0 $t1\n"	    
	    finalcode=finalcode+coded
	    coded = "\tmfhi $t2\n"
	    finalcode=finalcode+coded 
	    coded = "\tsw $t2 "+toAddr(t[0].offset)+"\n" 	    
	    finalcode=finalcode+coded
	    t[0].code=finalcode
	    t[0].icode=intcode

def p_additive_expression_1(t):
      '''additive_expression : multiplicative_expression'''
      #print "\nadditive_expression : multiplicative_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nadditive_expression : multiplicative_expression\n"
      t[0]=PassAttribute(t[1])     
      
def p_additive_expression_2(t):
      '''additive_expression : additive_expression '+' multiplicative_expression'''
      #print "\nadditive_expression : additive_expression '+' multiplicative_expression\n"
      global DEBUGP
      global error_flag
      global size
      global intcode
      global finalcode
      if(DEBUGP):
	    print "\nadditive_expression : additive_expression '+' multiplicative_expression\n"
    
      if(error_flag==1):      
	    print "\nError : Cannot Add incompatible data types.\n"
	    t[0]=PassAttribute(t[1]) 
      else:      
	    t[0]=MergeAttributes3Code(t[1],t[3])	    
	    t[0].qualifier=2
	    t[0].offset = size
	    size = size + 4
	    t[0].id = getNewTemp()	    
	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" + "+t[3].id+"\n"  	    
	    intcode=coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n" 	    
	    finalcode=coded
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"	    
	    finalcode=finalcode+coded
	    coded = "\tadd $t2, $t0,$t1\n"	    
	    finalcode=finalcode+coded
	    coded = "\tsw $t2 "+toAddr(t[0].offset)+"\n" 	    
	    finalcode=finalcode+coded
	    t[0].code=finalcode
	    t[0].icode=intcode

def p_additive_expression_3(t):
      '''additive_expression : additive_expression '-' multiplicative_expression'''
      #print "\nadditive_expression : additive_expression '-' multiplicative_expression\n"
      global DEBUGP
      global error_flag
      global size
      global intcode
      global finalcode
      if(DEBUGP):
	    print "\nadditive_expression : additive_expression '-' multiplicative_expression\n"
      
      if(error_flag==1):      
	    print "\nError : Cannot Subtract incompatible data types.\n"
	    t[0]=PassAttribute(t[1]) 
      else:      
	    t[0]=MergeAttributes3Code(t[1],t[3])	    
	    t[0].qualifier=2
	    t[0].offset = size
	    size = size + 4
	    t[0].id = getNewTemp()	    
	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" - "+t[3].id+"\n"  	    
	    intcode=coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n" 	    
	    finalcode=coded
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"	    
	    finalcode=finalcode+coded
	    coded = "\tsub $t2 $t0 $t1\n"	    
	    finalcode=finalcode+coded
	    coded = "\tsw $t2 "+toAddr(t[0].offset)+"\n" 	    
	    finalcode=finalcode+coded
	    t[0].code=finalcode
	    t[0].icode=intcode

def p_shift_expression_1(t):
      '''shift_expression : additive_expression'''
      #print "\nshift_expression : additive_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nshift_expression : additive_expression\n"
      t[0]=PassAttribute(t[1])     

def p_shift_expression_2(t):
      '''shift_expression : shift_expression LEFT_OP additive_expression'''
      #print "\nshift_expression : shift_expression LEFT_OP additive_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global size
      global finalcode
      if (DEBUGP):
	    print "\nshift_expression : shift_expression LEFT_OP additive_expression\n"
      if(not(t[1].specifier==4 or t[1].specifier==5 or (t[1].specifier==2 and t[1].isString==0))or not(t[3].specifier==4 or t[3].specifier==5 or (t[3].specifier==2 and t[3].isString==0)) or t[1].isString==1 or t[3].isString==1 or t[1].isPointer==1 or t[3].isPointer==1 or t[1].isFunction==1 or t[3].isFunction==1):
	    error_flag=1
	    print "\nError : Incompatible Types for Left Shift.\n"     
      t[0] = Attribute()
      t[0]=initAttr(t[0])
      t[0].specifier=t[1].specifier
      t[0].qualifier=2
      t[0].storage=t[1].storage
      t[0].type=t[0].storage*10 + t[0].specifier*100
# code generation started
      t[0].offset = size
      size = size + 4 
      t[0].id = getNewTemp()      
      coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" << "+t[3].IntConstValue+"\n"      
      intcode=coded
      coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"     
      finalcode=coded
      coded = "\tsll $t1 $t0 "+t[3].IntConstValue +"\n"
      finalcode=finalcode+coded
      coded = "\tsw $t1 "+toAddr(t[0].offset)+"\n"      
      finalcode=finalcode+coded
      t[0].code=finalcode
      t[0].icode=intcode

def p_shift_expression_3(t):
      '''shift_expression : shift_expression RIGHT_OP additive_expression'''
      #print "\nshift_expression : shift_expression RIGHT_OP additive_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global size
      global finalcode
      if (DEBUGP):
	    print "\nshift_expression : shift_expression RIGHT_OP additive_expression\n"
      if(not(t[1].specifier==4 or t[1].specifier==5 or (t[1].specifier==2 and t[1].isString==0))or not(t[3].specifier==4 or t[3].specifier==5 or (t[3].specifier==2 and t[3].isString==0)) or t[1].isString==1 or t[3].isString==1 or t[1].isPointer==1 or t[3].isPointer==1 or t[1].isFunction==1 or t[3].isFunction==1):
	    error_flag=1
	    print "\nError : Incompatible Types for Left Shift.\n"
      t[0] = Attribute()
      t[0]=initAttr(t[0])
      t[0].specifier=t[1].specifier
      t[0].qualifier=2
      t[0].storage=t[1].storage
      t[0].type=t[0].storage*10 + t[0].specifier*100
# code generation started
      t[0].offset = size
      size = size + 4 
      t[0].id = getNewTemp()      
      coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" >> "+t[3].IntConstValue+"\n"      
      intcode=coded
      coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"     
      finalcode=coded
      coded = "\tsrl $t1 $t0 "+t[3].IntConstValue +"\n"
      finalcode=finalcode+coded
      coded = "\tsw $t1 "+toAddr(t[0].offset)+"\n"      
      finalcode=finalcode+coded
      t[0].code=finalcode
      t[0].icode=intcode

def p_relational_expression_1(t):
      '''relational_expression : shift_expression'''
      #print "\nrelational_expression : shift_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nrelational_expression : shift_expression\n"
      t[0]=PassAttribute(t[1])     
      

def p_relational_expression_2(t):
      '''relational_expression : relational_expression '<' shift_expression'''
      #print "\nrelational_expression : relational_expression '<' shift_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global size
      global finalcode
      if (DEBUGP):
	    print "\nrelational_expression : relational_expression '<' shift_expression\n"
     
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError : Incompatible data types for Comparision(<).\n"
	    t[0]=PassAttribute(t[1]) 
	    #As a part of error recovery.      
      else:	          
	    t[0]=MergeAttributes3Code(t[1],t[3])
	    t[0].qualifier=2
	   
	    #--------------------------code generation ---------------------
	    t[0].offset = size
	    size = size + 4 
	    t[0].id = getNewTemp()
	    intcode=""
	    finalcode=""
	    if(t[1].qualifier==3):
		  coded = "array value at "+t[1].id		  
		  intcode=intcode+coded
		  coded = "\tlw $t9 "+toAddr(t[1].offset)+"\n"		  
		  finalcode=finalcode+coded
	    else:
		  coded = t[1].id
		  intcode=intcode+coded
		  coded = "\tli $t0 "+str(t[1].offset)+"\n"		 
		  finalcode=finalcode+coded
		  coded = "\tsub $t9 $sp $t0\n"		  
		  finalcode=finalcode+coded	   
	    if(t[3].qualifier==3):
		  coded= "array value at "+t[3].id
		  icg1=coded
		  coded= "\tlw $t8 " +toAddr(t[3].offset) +"\n"
		  finalcode=finalcode + coded
		  	    
	    else:
		  s2 = t[3].id		 
		  icg1=coded
		  coded = "\tli $t0 "+str(t[3].offset)+"\n"		  
		  finalcode=finalcode+coded		  
		  coded = "\tsub $t8 $sp $t0\n"		  
		  finalcode=finalcode+coded			 
	    coded = t[1].icode+""+t[3].icode +"\t"+t[0].id+" = "+intcode+" < "+ icg1+"\n"
	    intcode = intcode+coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 0($t9)\n"	    
	    finalcode = finalcode+coded
	    coded = "\tlw $t1 0($t8)\n"	    
	    finalcode = finalcode+ coded
	    coded = "\tslt $t2 $t0 $t1\n"	    
	    finalcode = finalcode +coded
	    coded = "\tsw $t2 "+toAddr(t[0].offset)+"\n" 	    
	    finalcode = finalcode +coded
	    t[0].code=finalcode
	    t[0].icode=intcode

def p_relational_expression_3(t):
      '''relational_expression : relational_expression '>' shift_expression'''
      #print "\nrelational_expression : relational_expression '>' shift_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      global icg1
      if (DEBUGP):
	    print "\nrelational_expression : relational_expression '>' shift_expression\n"
    
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError : Incompatible data types for Comparision(>).\n"
	    t[0]=PassAttribute(t[1]) 
	    #As a part of error recovery.      
      else:	          
	    t[0]=MergeAttributes3Code(t[1],t[3])
	    t[0].qualifier=2
	  
	    #--------------------------code generation ---------------------
	    t[0].offset = size
	    size = size + 4 
	    t[0].id = getNewTemp()
	    intcode=""
	    finalcode=""
	    coded = t[1].icode + t[3].icode	    
	    intcode = intcode+coded
	    coded = t[1].code	    
	    finalcode = finalcode+coded
	    coded = t[3].code
	    finalcode = finalcode + coded
	    if(t[1].qualifier==3):
		  coded = "array value at "+t[1].id		  
		  intcode=intcode+coded
		  coded = "\tlw $t9 "+toAddr(t[1].offset)+"\n"		  
		  finalcode=finalcode+coded
	    else:
		  coded = t[1].id
		  intcode=intcode+coded
		  coded = "\tli $t0 "+str(t[1].offset)+"\n"		 
		  finalcode=finalcode+coded
		  coded = "\tsub $t9 $sp $t0\n"		  
		  finalcode=finalcode+coded	   
	    if(t[3].qualifier==3):
		  coded= "array value at "+t[3].id
		  icg1=coded
		  coded= "\tlw $t8 " +toAddr(t[3].offset) +"\n"
		  finalcode=finalcode + coded
		  	    
	    else:
		  s2 = t[3].id		 
		  icg1=coded
		  coded = "\tli $t0 "+str(t[3].offset)+"\n"		  
		  finalcode=finalcode+coded		  
		  coded = "\tsub $t8 $sp $t0\n"		  
		  finalcode=finalcode+coded			 
	    coded = t[1].icode+""+t[3].icode +"\t"+t[0].id+" = "+intcode+" > "+ icg1+"\n"
	    intcode = intcode+coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 0($t9)\n"	    
	    finalcode = finalcode+coded
	    coded = "\tlw $t1 0($t8)\n"	    
	    finalcode = finalcode+ coded
	   
	    coded = "\tslt $t2 $t1 $t0\n"	    	    
	    finalcode = finalcode +coded
	    coded = "\tsw $t2 "+toAddr(t[0].offset)+"\n" 	    
	    finalcode = finalcode +coded
	    t[0].code=finalcode
	    t[0].icode=intcode

def p_relational_expression_4(t):
      '''relational_expression : relational_expression LE_OP shift_expression'''
      #print "\nrelational_expression : relational_expression LE_OP shift_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global size
      global finalcode
      global icg1
      if (DEBUGP):
	    print "\nrelational_expression : relational_expression LE_OP shift_expression\n"
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError : Incompatible data types for Comparision(<=).\n"
	    t[0]=PassAttribute(t[1]) 
	    #As a part of error recovery.      
      else:	          
	    t[0]=MergeAttributes3Code(t[1],t[3])
	    t[0].qualifier=2
	 
	    #--------------------------code generation ---------------------
	    t[0].offset = size
	    size = size + 4 
	    t[0].id = getNewTemp()

	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" <= "+t[3].id+"\n"
	    intcode = coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
	    finalcode = coded	    
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
	    finalcode = finalcode + coded
	    coded = "\tsub $t2 $t1 $t0\n"
	    finalcode = finalcode + coded
	    coded = "\tslt $t3 $t2 0\n"
	    finalcode = finalcode + coded
	    coded = "\tli $t4 1\n"
	    finalcode = finalcode  + coded
	    coded = "\tsub $t4 $t4 $t3\n"
	    finalcode = finalcode + coded	    	    
	    coded = "\tsw $t4 "+toAddr(t[0].offset)+"\n"
	    finalcode = finalcode+coded
	    t[0].code = finalcode
	    t[0].icode = intcode
	    

def p_relational_expression_5(t):
      '''relational_expression : relational_expression GE_OP shift_expression'''
      #print "\nrelational_expression : relational_expression GE_OP shift_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global size
      global finalcode
      if (DEBUGP):
	    print "\nrelational_expression : relational_expression GE_OP shift_expression\n"
   
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError : Incompatible data types for Comparison(>=).\n"
	    t[0]=PassAttribute(t[1]) 
	    #As a part of error recovery.      
      else:	          
	    t[0]=MergeAttributes3Code(t[1],t[3])
	    t[0].qualifier=2
	   
	    #--------------------------code generation ---------------------
	    t[0].offset = size
	    size = size + 4 
	    t[0].id = getNewTemp()

	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" >= "+t[3].id+"\n"
	    intcode = coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
	    finalcode = coded	    
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
	    finalcode = finalcode + coded
	    coded = "\tsub $t2 $t0 $t1\n"
	    finalcode = finalcode + coded
	    coded = "\tslt $t3 $t2 0\n"
	    finalcode = finalcode + coded
	    coded = "\tli $t4 1\n"
	    finalcode = finalcode  + coded
	    coded = "\tsub $t4 $t4 $t3\n"
	    finalcode = finalcode + coded	    	    
	    coded = "\tsw $t4 "+toAddr(t[0].offset)+"\n"
	    finalcode = finalcode+coded
	    t[0].code = finalcode
	    t[0].icode = intcode

def p_equality_expression_1(t):
      '''equality_expression : relational_expression'''
      #print "\nequality_expression : relational_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nequality_expression : relational_expression\n"
      t[0]=PassAttribute(t[1])     

def p_equality_expression_2(t):
      '''equality_expression : equality_expression EQ_OP relational_expression'''
      #print "\nequality_expression : equality_expression EQ_OP relational_expression\n"
      global DEBUGP
      global size
      global error_flag
      global intcode
      global finalcode
      if (DEBUGP):
	    print "\nequality_expression : equality_expression EQ_OP relational_expression\n"
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError : Incompatible data types for Equal Check(==).\n"
	    t[0]=PassAttribute(t[1]) 
	    #As a part of error recovery.      
      else:	          
	    t[0]=MergeAttributes3Code(t[1],t[3])
	    t[0].qualifier=2
	  
	    #--------------------------code generation ---------------------
	    t[0].offset = size
	    size = size + 4 
	    t[0].id = getNewTemp()

	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" == "+t[3].id+"\n"
	    intcode = coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
	    finalcode = coded	    
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
	    finalcode = finalcode + coded
	    coded = "\tslt $t2 $t0 $t1\n"
	    finalcode = finalcode + coded
	    coded = "\tslt $t3 $t1 $t0\n"
	    finalcode = finalcode + coded
	    coded= "\tadd $t1 $t2 $t3\n"
	    finalcode=finalcode+coded
	    coded = "\tli $t0 1\n"
	    finalcode = finalcode  + coded
	    coded = "\tsub $t0 $t0 $t1\n"
	    finalcode = finalcode + coded	    	    
	    coded = "\tsw $t0 "+toAddr(t[0].offset)+"\n"
	    finalcode = finalcode+coded
	    t[0].code = finalcode
	    t[0].icode = intcode

def p_equality_expression_3(t):
      '''equality_expression : equality_expression NE_OP relational_expression'''
      #print "\nequality_expression : equality_expression NE_OP relational_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global size
      global finalcode
      if (DEBUGP):
	    print "\nequality_expression : equality_expression NE_OP relational_expression\n"
      #t[0]=PassAttribute(t[1])     
     
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError : Incompatible data types for Equal Check(!=).\n"
	    t[0]=PassAttribute(t[1]) 
	    #As a part of error recovery.      
      else:	          
	    t[0]=MergeAttributes3Code(t[1],t[3])
	    t[0].qualifier=2
	    
	    #--------------------------code generation ---------------------
	    t[0].offset = size
	    size = size + 4 
	    t[0].id = getNewTemp()

	    coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" != "+t[3].id+"\n"
	    intcode = coded
	    coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
	    finalcode = coded	    
	    coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
	    finalcode = finalcode + coded
	    coded = "\tslt $t2 $t0 $t1\n"
	    finalcode = finalcode + coded
	    coded = "\tslt $t3 $t1 $t0\n"
	    finalcode = finalcode + coded
	    coded = "\tadd $t1 $t2 $t3\n"
	    finalcode = finalcode + coded	    	    
	    coded = "\tsw $t1 "+toAddr(t[0].offset)+"\n"
	    finalcode = finalcode+coded
	    t[0].code = finalcode
	    t[0].icode = intcode

def p_and_expression_1(t):
      '''and_expression : equality_expression'''
      #print "\nand_expression : equality_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nand_expression : equality_expression\n"
      t[0]=PassAttribute(t[1])     

def p_and_expression_2(t):
      '''and_expression : and_expression '&' equality_expression'''
      #print "\nand_expression : and_expression '&' equality_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if (DEBUGP):
	    print "\nand_expression : and_expression '&' equality_expression\n"
 	
      if(error_flag==1):
	    
	    print "\nError: Incomaptible for & operator\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].specifier = t[1].specifier
      t[0].qualifier = 2
      t[0].storage = t[1].storage
      t[0].type = t[0].storage*10 + t[0].specifier*100
     
     
      #--------------------------code generation ---------------------
      t[0].offset = size
      size = size + 4 
      t[0].id = getNewTemp()

      coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" & "+t[3].id+"\n"
      intcode = coded
      coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
      finalcode = coded	    
      coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
      finalcode = finalcode + coded
      coded = "\tand $t3 $t0 $t1\n"
      finalcode =finalcode + coded
      coded = "\tsw $t3 "+toAddr(t[0].offset)+"\n"
      finalcode = finalcode+coded
      t[0].code = finalcode
      t[0].icode = intcode

def p_exclusive_or_expression_1(t):
      '''exclusive_or_expression : and_expression'''
      #print "\nexclusive_or_expression : and_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nexclusive_or_expression : and_expression\n"
      t[0]=PassAttribute(t[1])     

def p_exclusive_or_expression_2(t):
      '''exclusive_or_expression : exclusive_or_expression '^' and_expression'''
      #print "\nexclusive_or_expression : exclusive_or_expression '^' and_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if (DEBUGP):
	    print "\nexclusive_or_expression : exclusive_or_expression '^' and_expression\n"
      #t[0]=PassAttribute(t[1])     
      
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError: Incomaptible for Xor ^ operator\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].specifier = t[1].specifier
      t[0].qualifier = 2
      t[0].storage = t[1].storage
      t[0].type = t[0].storage*10 + t[0].specifier*100
      #--------------------------code generation ---------------------
      t[0].offset = size
      size = size + 4 
      t[0].id = getNewTemp()

      coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" ^ "+t[3].id+"\n"
      intcode = coded
      coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
      finalcode = coded	    
      coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
      finalcode = finalcode + coded
      coded = "\txor $t3 $t0 $t1\n"
      finalcode =finalcode + coded
      coded = "\tsw $t3 "+toAddr(t[0].offset)+"\n"
      finalcode = finalcode+coded
      t[0].code = finalcode
      t[0].icode = intcode

def p_inclusive_or_expression_1(t):
      '''inclusive_or_expression : exclusive_or_expression'''
      #print "\ninclusive_or_expression : exclusive_or_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\ninclusive_or_expression : exclusive_or_expression\n"
      t[0]=PassAttribute(t[1])     

def p_inclusive_or_expression_2(t):
      '''inclusive_or_expression : inclusive_or_expression '|' exclusive_or_expression'''
      #print "\ninclusive_or_expression : inclusive_or_expression '|' exclusive_or_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if (DEBUGP):
	    print "\ninclusive_or_expression : inclusive_or_expression '|' exclusive_or_expression\n"


      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError: Incomaptible for | operator\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].specifier = t[1].specifier
      t[0].qualifier = 2
      t[0].storage = t[1].storage
      t[0].type = t[0].storage*10 + t[0].specifier*100
      #--------------------------code generation ---------------------
      t[0].offset = size
      size = size + 4 
      t[0].id = getNewTemp()

      coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" ^ "+t[3].id+"\n"
      intcode = coded
      coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
      finalcode = coded	    
      coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
      finalcode = finalcode + coded
      coded = "\tor $t3 $t0 $t1\n"
      finalcode =finalcode + coded
      coded = "\tsw $t3 "+toAddr(t[0].offset)+"\n"
      finalcode = finalcode+coded
      t[0].code = finalcode
      t[0].icode = intcode

def p_logical_and_expression_1(t):
      '''logical_and_expression : inclusive_or_expression'''
      #print "\nlogical_and_expression : inclusive_or_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nlogical_and_expression : inclusive_or_expression\n"
      t[0]=PassAttribute(t[1])     

def p_logical_and_expression_2(t):
      '''logical_and_expression : logical_and_expression AND_OP inclusive_or_expression'''
      #print "\nlogical_and_expression : logical_and_expression AND_OP inclusive_or_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if (DEBUGP):
	    print "\nlogical_and_expression : logical_and_expression AND_OP inclusive_or_expression\n"
      if(error_flag==1):
	    # Incompatible in operations.
	    print "\nError: Incomaptible for Logical And && operator\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].specifier = t[1].specifier
      t[0].qualifier = 2
      t[0].storage = t[1].storage
      t[0].type = t[0].storage*10 + t[0].specifier*100
      #--------------------------code generation ---------------------
      t[0].offset = size
      size = size + 4 
      t[0].id = getNewTemp()

      coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" ^ "+t[3].id+"\n"
      intcode = coded
      coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
      finalcode = coded	    
      coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
      finalcode = finalcode + coded
      coded = "\tslt $t2 $t0 $0\n"
      finalcode = finalcode + coded
      coded = "\tslt $t3 $0 $t0\n"
      finalcode = finalcode + coded
      coded=  "\tadd $t4 $t2 $t3\n"
      finalcode = finalcode + coded
      coded = "\tslt $t2 $t1 $0\n"
      finalcode = finalcode + coded
      coded= "\tslt $t3 $0 $t1\n"
      finalcode = finalcode + coded
      coded = "\tadd $t5 $t2 $t3\n"
      finalcode = finalcode + coded
      coded ="\tand $t0 $t5 $t4\n"
      finalcode =finalcode + coded
      coded = "\tsw $t0 "+toAddr(t[0].offset)+"\n"
      finalcode = finalcode+coded
      t[0].code = finalcode
      t[0].icode = intcode

def p_logical_or_expression_1(t):
      '''logical_or_expression : logical_and_expression'''
      #print "\nlogical_or_expression : logical_and_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nlogical_or_expression : logical_and_expression\n"
      t[0]=PassAttribute(t[1])  
      
def p_logical_or_expression_2(t):
      '''logical_or_expression : logical_or_expression OR_OP logical_and_expression'''
      #print "\nlogical_or_expression : logical_or_expression OR_OP logical_and_expression\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global size
      if (DEBUGP):
	    print "\nlogical_or_expression : logical_or_expression OR_OP logical_and_expression\n"
      if(error_flag==1):
	    
	    print "\nError: Incompatible for Logical And && operator\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].specifier = t[1].specifier
      t[0].qualifier = 2
      t[0].storage = t[1].storage
      t[0].type = t[0].storage*10 + t[0].specifier*100
      #--------------------------code generation ---------------------
      t[0].offset = size
      size = size + 4 
      t[0].id = getNewTemp()

      coded = t[1].icode+""+t[3].icode+"\t"+t[0].id+" = "+t[1].id+" || "+t[3].id+"\n"
      intcode = coded
      coded = t[1].code+""+t[3].code+"\tlw $t0 "+toAddr(t[1].offset)+"\n"	    
      finalcode = coded	    
      coded = "\tlw $t1 "+toAddr(t[3].offset)+"\n"		  
      finalcode = finalcode + coded
      coded = "\tslt $t2 $t0 $0\n"
      finalcode = finalcode + coded
      coded = "\tslt $t3 $0 $t0\n"
      finalcode = finalcode + coded
      coded=  "\tadd $t4 $t2 $t3\n"
      finalcode = finalcode + coded
      coded = "\tslt $t2 $t1 $0\n"
      finalcode = finalcode + coded
      coded= "\tslt $t3 $0 $t1\n"
      finalcode = finalcode + coded
      coded = "\tadd $t5 $t2 $t3\n"
      finalcode = finalcode + coded
      coded ="\tor $t0 $t5 $t4\n"
      finalcode =finalcode + coded
      coded = "\tsw $t0 "+toAddr(t[0].offset)+"\n"
      finalcode = finalcode+coded
      t[0].code = finalcode
      t[0].icode = intcode
      

def p_conditional_expression_1(t):
      '''conditional_expression : logical_or_expression'''
      #print "\nconditional_expression : logical_or_expression\n"
      global DEBUGP
      if (DEBUGP):
	    print "\nconditional_expression : logical_or_expression\n"
      t[0]=PassAttribute(t[1]) 

def p_assignment_expression_1(t):
      '''assignment_expression : conditional_expression'''
      #print "assignment_expression : conditional_expression"
      if DEBUGP:
	    print "\nassignment_expression -> conditional_expression\n"
      t[0] = PassAttribute(t[1]) 

def p_assignment_expression_2(t):
      '''assignment_expression : unary_expression assignment_operator assignment_expression'''
      #print "assignment_expression : unary_expression assignment_operator assignment_expression"
      global DEBUGP
      global finalcode
      global intcode
      global error_flag
      if DEBUGP:
	    print "\nassignment_expression -> unary_expression assignment_operator assignment_expression \n"
      t[0] = PassAttribute(t[1])
      if (t[1].qualifier > 0) and (t[1].qualifier != 3):      
	    error_flag=1
	    print "\nError : Invalid Assignment. Left side should have Lvalue\n"
	    
      elif t[1].isFunction==1:    
	    error_flag=1
	    print "\nError : Function is defined like a variable.\n"
	    
      elif t[1].isArray==0:    	    
	    if t[3].numParameters>0:	    
		  error_flag=1
		  print "\nError : Assigning a List to Variable.\n"

	    elif(t[1].isPointer==1):	    
		  if ( not ((( (t[3].type==200) and (t[3].isString!=1) )or t[3].type==400 or (t[3].type==500 and t[3].isPointer==0))or(t[3].type==t[1].type and t[3].isPointer==1)or(t[1].specifier==2 and t[3].isString==1))):
			error_flag = 1
			print "\nError : Invalid Assignment to Pointer.\n"
		  else:					  
			t[0].icode=t[3].icode
			t[0].code=t[3].code
			coded = "\tpointer value at "+t[1].id+" = "+t[3].id+"\n"			
			t[0].icode=t[0].icode + coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			t[0].code=t[0].code+coded
			coded = "\tsw $t0 "+toAddr(t[1].offset)+"\n"
			
			t[0].code=t[0].code+coded		  
	    else:	   
		  
		  if(t[3].isFunction==1 or t[3].isArray==1 or t[3].isPointer==1 or t[3].isString==1):		  
			error_flag=1
			print "\nError : Invalid Assignment Method to the variable.\n"		  
		  	
		  finalcode=t[1].code
		  intcode=t[1].icode
		  if(t[1].qualifier==3):		  
			coded = "array value at "+t[1].id+""			
			intcode=intcode+coded
			coded = "\tlw $t9 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded		  
		  else:
			coded = t[1].id			
			intcode=intcode+coded
			coded = "\tli $t0 "+str(t[1].offset)+"\n"
			finalcode = finalcode + coded
			coded = "\tsub $t9 $sp $t0\n"			
			finalcode=finalcode+coded
			
		  if(t[2] == '=' ):			
			coded = t[3].icode+"\t"+intcode+" = "+str(t[3].id)+"\n"			
			intcode=intcode+coded
			coded = t[3].code	    
			finalcode=finalcode+coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tsw $t0 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
		 
		  if(t[2] == '+' ):
			coded = t[3].icode+"\t"+intcode+" += "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tadd $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
		  
		  if(t[2] == '-' ):
			coded = t[3].icode+"\t"+intcode+" -= "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tsub $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
			
		  if(t[2] == '<' ):
			coded = t[3].icode+"\t"+intcode+" <<= "+t[3].IntConstValue+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tsll $t1 $t1"+t[3].IntConstValue+" \n"			
			finalcode=finalcode+coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode			
			
		  if(t[2] == '>' ):
			coded = t[3].icode+"\t"+intcode+" >>= "+t[3].IntConstValue+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tsll $t1 $t1"+t[3].IntConstValue+" \n"
			finalcode=finalcode+coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode			

		  if(t[2] == '&' ):
			coded = t[3].icode+"\t"+intcode+" &= "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tand $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
			#PrintAttribute(t[0]);
			
		  if(t[2] == '|' ):
			coded = t[3].icode+"\t"+intcode+" |= "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tor $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
			#PrintAttribute(t[0]);

		  if(t[2] == '^' ):
			coded = t[3].icode+"\t"+intcode+" ^= "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\txor $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
			#PrintAttribute(t[0]);

		  if(t[2] == '*' ):
			coded = t[3].icode+"\t"+intcode+" *= "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tmult $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tmflo $t1\n"
			finalcode + finalcode + coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
			#PrintAttribute(t[0]);

		  if(t[2] == '/' ):
			coded = t[3].icode+"\t"+intcode+" /= "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tdiv $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tmflo $t1\n"
			finalcode + finalcode + coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode
			#PrintAttribute(t[0]);
			
		  if(t[2] == '%' ):
			coded = t[3].icode+"\t"+intcode+" mod= "+t[3].id+"\n"					
			intcode=coded
			coded = t[3].code		
			finalcode=coded
			coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tlw $t1 "+toAddr(t[1].offset)+"\n"			
			finalcode=finalcode+coded
			coded = "\tdiv $t1 $t1 $t0\n"			
			finalcode=finalcode+coded
			coded = "\tmfhi $t1\n"
			finalcode + finalcode + coded
			coded = "\tsw $t1 0($t9)\n"			
			finalcode=finalcode+coded
			t[0].code=finalcode
			t[0].icode=intcode			
      else:	
	    error_flag=1
	    print "\nError : Cannot perform assignment to array like a variable.\n"					    
      assign_flag=0
	    
def p_equal_to_1(t):
      '''equal_to : '='
      '''
      #print "equal_to : '=' "
      global DEBUGP
      if DEBUGP:
	    print "equal_to : '=' "
      assign_flag = 1

def p_assignment_operator_1(t):
      '''assignment_operator : equal_to'''
      #print "assignment_operator : equal_to"
      global DEBUGP      
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='='            

def p_assignment_operator_2(t):
      '''assignment_operator : MUL_ASSIGN'''      
      #print "assignment_operator : MUL_ASSIGN"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='*'    
      assign_flag = 1

def p_assignment_operator_3(t):
      '''assignment_operator : DIV_ASSIGN'''
      #print "assignment_operator : DIV_ASSIGN"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='/'    
      assign_flag = 1

def p_assignment_operator_4(t):
      '''assignment_operator : MOD_ASSIGN'''
      #print "assignment_operator : MOD_ASSIGN"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='%'    
      assign_flag = 1

def p_assignment_operator_5(t):
      '''assignment_operator : ADD_ASSIGN'''
      #print "assignment_operator : ADD_ASSIGN"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='+'    
      assign_flag = 1

def p_assignment_operator_6(t):
      '''assignment_operator : SUB_ASSIGN'''
      #print "assignment_operator : SUB_ASSIGN"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='-'    
      assign_flag = 1

def p_assignment_operator_7(t):
      '''assignment_operator : LEFT_ASSIGN'''
      #print "assignment_operator : LEFT_ASSIGN"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='<'    
      assign_flag = 1

def p_assignment_operator_8(t):
      '''assignment_operator : RIGHT_ASSIGN'''
      #print "assignment_operator : RIGHT_ASSIGN"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\nassignment_operator found\n"
      t[0]='>'    
      assign_flag = 1

def p_expression_1(t):
      '''expression : assignment_expression'''
      #print "expression : assignment_expression"      
      global DEBUGP
      global switch_flag
      global temp_expression
      if(DEBUGP):
	    print "\nexpression -> assignment_expression\n"
     
      t[0]=PassAttribute(t[1]);

def p_expression_2(t):
      '''expression : expression ',' assignment_expression'''
      #print "\nexpression -> expression ',' assignment_expression\n"      
      global DEBUGP           
      if(DEBUGP):
	    print "\nexpression -> expression ',' assignment_expression\n"      
      t[0]=PassAttribute(t[1])
      t[0].code = t[0].code + t[3].code
      t[0].icode = t[0].icode + t[3].icode
      t[0].id=None       

def p_constant_expression_1(t):
      '''constant_expression : conditional_expression'''
      #print "\nconstant_expression -> conditional_expression\n"
      global DEBUGP
      if(DEBUGP):
	    print "\nconstant_expression -> conditional_expression\n"
      t[0]=PassAttribute(t[1])      

def p_declaration_1(t):
      '''declaration : declaration_specifiers ';'  '''
      #print "\ndeclaration -> declaration_specifiers ';' \n"
      global declaration_flag
      global DEBUGP
      global assign_flag
      global temp_inherited
      global temp_Parameters
      if(DEBUGP):
	    print "\ndeclaration -> declaration_specifiers ';' \n"      
      declaration_flag=0
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].specifier = 1
      t[0].type = 100      
          
      t[0].code=""
      t[0].icode=""
      assign_flag=0
      
      
      #PrintAttribute(temp_inherited);
      temp_inherited=initAttr( temp_inherited) 		
      temp_Parameters=initAttr( temp_Parameters) 
      
      
      #PrintAttribute(temp_inherited);				

def p_declaration_2(t):
      '''declaration : declaration_specifiers error'''
      #print "\ndeclaration -> declaration_specifiers error';' \n"
      global declaration_flag
      global DEBUGP
      global error_flag
      global temp_inherited
      global temp_Parameters
      if(DEBUGP):
	    print "\ndeclaration -> declaration_specifiers ';' \n"      
      declaration_flag=0
      t[0] = Attribute()
      t[0] = initAttr(t[0])          
      t[0].code=""
      t[0].icode=""
      
      #PrintAttribute(temp_inherited);
      temp_inherited=initAttr( temp_inherited) 		
      temp_Parameters=initAttr( temp_Parameters) 
      t[0].specifier = 1
      t[0].type = 100      
      error_flag=1
      print "\nError : semicolon missing\n "
      			

def p_declaration_3(t):
      '''declaration : declaration_specifiers init_declarator_list ';'      '''
      #print "\ndeclaration -> declaration_specifiers init_declarator_list ';'\n"
      global declaration_flag
      global DEBUGP
      global assign_flag
      global temp_inherited
      global temp_Parameters
      global error_flag
      if(DEBUGP):
	    print "\ndeclaration -> declaration_specifiers init_declarator_list ';'\n"    
      declaration_flag=0
      t[0] = Attribute()
      t[0] = initAttr(t[0])   
      t[0].specifier = 1
      t[0].type = 100    
      temp_inherited=initAttr( temp_inherited) 		
      temp_Parameters=initAttr( temp_Parameters) 
      t[0].code=t[2].code
      t[0].icode=t[2].icode
      assign_flag = 0
      
      #PrintAttribute(temp_inherited);				

def p_declaration_4(t):
      '''declaration : declaration_specifiers init_declarator_list error'''
      #print "\ndeclaration -> declaration_specifiers init_declarator_list error\n"
      global declaration_flag
      global DEBUGP
      global error_flag
      global assign_flag
      global temp_inherited
      global temp_Parameters
      if(DEBUGP):
	    print "\ndeclaration -> declaration_specifiers init_declarator_list error\n" 
      declaration_flag=0
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].specifier=1
      t[0].type=100
      assign_flag = 0
      temp_inherited=initAttr(temp_inherited) 		
      temp_Parameters=initAttr(temp_Parameters) 
      t[0].code=t[2].code
      t[0].icode=t[2].icode
      
      #PrintAttribute(temp_inherited);
      error_flag=1
      print "\nError : semicolon missing\n "
      
      #PrintAttribute(temp_inherited);				

def p_declaration_specifiers_1(t):
      '''declaration_specifiers : type_specifier'''
      #print "\ndeclaration_specifiers -> type_specifier\n"
      global DEBUGP
      global parameter_flag
      global declaration_flag      
      if(DEBUGP):
	    print "\ndeclaration_specifiers -> type_specifier\n"
      if(parameter_flag==0):
	    declaration_flag=1
      #PrintAttribute($1);
      t[0]=PassAttribute(t[1])

# def p_declaration_specifiers_2(t):
      # '''declaration_specifiers : storage_class_specifier'''
      # #print "\ndeclaration_specifiers -> storage_class_specifier\n"
      # global DEBUGP
      # global error_flag
      # global declaration_flag      
      # if(DEBUGP):
	    # print "\ndeclaration_specifiers -> storage_class_specifier\n"
      # declaration_flag=1
      # t[0]=PassAttribute(t[1])
      # error_flag=1
      # print "\nError : Our C doesn't support it.\n"

# def p_declaration_specifiers_3(t):
      # '''declaration_specifiers : type_specifier storage_class_specifier'''
      # #print "\ndeclaration_specifiers : type_specifier storage_class_specifier\n"
      # global DEBUGP
      # global error_flag
      # global declaration_flag
      # global temp_inherited
      # if(DEBUGP):
	    # print "\ndeclaration_specifiers : type_specifier storage_class_specifier\n"
      # declaration_flag=1
      # t[0]=PassAttribute(temp_inherited)
      # error_flag=1
      # print "\nError : Our C doesn't support it.\n"


	  
def p_init_declarator_list_1(t):
      '''init_declarator_list : init_declarator'''
      #print "init_declarator_list : init_declarator"
      global DEBUGP
      if DEBUGP:
	print "init_declarator_list : init_declarator"
      t[0]=PassAttribute(t[1])
      

def p_init_declarator_list_2(t):
      '''init_declarator_list : init_declarator_list ',' init_declarator'''
      #print "init_declarator_list : init_declarator_list ',' init_declarator"
      global DEBUGP
      if DEBUGP:
	print "init_declarator_list : init_declarator_list ',' init_declarator"
      t[0]=PassAttribute(t[1])
      t[0].code=t[0].code+t[3].code
      t[0].icode = t[0].icode + t[3].icode
      
def p_init_declarator_1(t):
      '''init_declarator : declarator equal_to initializer'''
      #print "init_declarator:declarator equal_to initializer"
      global DEBUGP
      global size
      global error_flag
      global assign_flag
      global function
      global intcode
      global finalcode
      if(DEBUGP):
	print "init_declarator:declarator equal_to initializer"
      t[0]=PassAttribute(t[1])
      if(t[1].isFunction==1):
	error_flag=1
	print "\nError : Function is defined like a variable.\n"
      elif(t[1].isArray==0):
	if(t[3].numParameters>0):
	  error_flag=1
	  print "\nError : Assigning a List to Variable.\n"
	elif(t[1].isPointer==1):
	  if(not(((t[3].type==200 and t[3].isString!=1) or t[3].type==400 or (t[3].type==500 and t[3].isPointer==0))or(t[3].type==t[1].type and t[3].isPointer==1)or(t[1].specifier==2 and t[3].isString==1))):
	    error_flag=1
	    print "\nError : Invalid Assignment to Pointer.\n"
	  p=SymEntry()
	  p=lookup(t[1].id,function)
	  p.offset=size
	  size=size+4
	  t[0].icode=t[3].icode
	  t[0].code=t[3].code
	  coded="\t"+t[1].id+" "+t[3].id+"\n"
	  t[0].icode=t[0].icode+coded
	  coded="\tlw $t0 "+toAddr(t[3].offset)+"\n"
	  t[0].code=t[0].code+coded
	  coded="\tsw $t0 "+toAddr(p.offset)+"\n"
	  t[0].code=t[0].code+coded
	else:
	  if(t[3].isFunction==1 or t[3].isArray==1 or t[3].isPointer==1 or t[3].isString==1):
	    error_flag=1
	    print "\nError : Invalid Assignment to the variable.\n"
	    #------------------------code generation ------------------------
	  if((t[1].type == 400) and (t[3].type== 400)):
	    coded=t[3].icode+"	"+t[1].id+"="+t[3].id
	    intcode=coded
	    coded=t[3].code
	    finalcode=coded
	    coded="\tlw $t0 "+toAddr(t[3].offset)+"\n"
	    finalcode=finalcode+coded
	    coded="\tsw $t0 "+toAddr(t[1].offset)+"\n"
	    finalcode=finalcode+coded
	    t[0].code=finalcode
	    t[0].icode=intcode
      else:
	t[0].isArray=1
	t[1].isArray=1
	if(t[3].numParameters==0):
	  error_flag=1
	  print "\nError : Invalid assignment to an array.\n"
	elif(t[3].numParameters>t[1].ArrayLimit and t[1].ArrayLimit>0):
	  error_flag=1
	  print "\nError : List Size greater than Array Size, do not match.\n"
	elif(t[1].ArrayLimit==0):
	  p=SymEntry()
	  p=lookup(t[1].id,function)
	  p.isArray=1
	  p.ArrayLimit=t[3].numParameters
	  t[1].ArrayLimit=t[3].numParameters
	  t[0].ArrayLimit=t[1].ArrayLimit
	  p.offset=t[3].ParameterList[0].offset
	  size=size+(t[0].ArrayLimit*4)
	  if(t[1].isPointer==1):
	    for counter in range(t[1].ArrayLimit):
	      if(not(((t[3].ParameterList[counter].type==200 and t[3].ParameterList[counter].isString!=1) or t[3].type==400 or (t[3].ParameterList[counter].type==500 and t[3].ParameterList[counter].isPointer==0)) or (t[3].ParameterList[counter].type==t[1].type and t[3].ParameterList[counter].isPointer==1) or (t[1].specifier==2 and t[3].ParameterList[counter].isString==1))):
		error_flag=1
		print "\nError : Invalid Assignment to Array Pointers.\n"
	  else:
	    finalcode=""
	    intcode=""
	    for counter in range(t[1].ArrayLimit):
	      if(t[3].ParameterList[counter].isFunction==1 or t[3].ParameterList[counter].isArray==1 or t[3].ParameterList[counter].isPointer==1 or t[3].ParameterList[counter].isString==1):
		error_flag=1
		print "Error : Invalid Assignment to the Array Varaible.\n"
	      intcode=intcode+t[3].ParameterList[counter].icode
	      finalcode=finalcode+t[3].ParameterList[counter].code
	      coded=p.id+"	["+counter+"] = "+t[3].ParameterList[counter].id
	      intcode=intcode +coded
	      coded="\tlw $t0 "+toAddr(t[3].ParameterList[counter].offset)+"\n"
	      finalcode=finalcode+coded
	      coded="\tsw $t0 "+toAddr(p.offset+counter*4)+"\n"
	    t[0].code=finalcode
	    t[0].icode=intcode
	assign_flag=0
			 
	

def p_init_declarator_2(t):
      '''init_declarator : declarator'''
      #print "init_declarator : declarator"
      global DEBUGP
      global error_flag
      global size
      global function
      if DEBUGP:
	    print "init_declarator : declarator"
      if ((t[1].isArray==1) and (t[1].ArrayLimit==0)):
	    error_flag=1
	    print "Error:Array size not defined"
      t[0]=PassAttribute(t[1])
      if (t[1].isPointer==1): 
	    t[0].offset=size
	    p=SymEntry()
	    p=lookup(t[1].id,function)
	    p.offset=size
	    size=size+4
			

def p_type_specifier_1(t):
      '''type_specifier : VOID'''
      #print "type_specifier : VOID"
      global DEBUGP
      global temp_inherited
      global parameter_flag
      if DEBUGP:
	print "type_specifier : VOID"
      if parameter_flag==0:
	temp_inherited.specifier=1
	temp_inherited.type=temp_inherited.type+100
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].specifier=1
      t[0].type=t[0].type+100 
				
def p_type_specifier_2(t):
      '''type_specifier : CHAR'''
      #print "type_specifier : CHAR "
      global DEBUGP
      global temp_inherited
      global parameter_flag
      if DEBUGP:
	print "type_specifier : CHAR "
      if parameter_flag==0:
	temp_inherited.specifier=2
	temp_inherited.type=temp_inherited.type+200
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].specifier=2
      t[0].type=t[0].type+200 


def p_type_specifier_3(t):
      '''type_specifier : INT'''
      #print "type_specifier : INT "
      global DEBUGP
      global parameter_flag
      global temp_inherited
      if DEBUGP:
	print "type_specifier : INT "
      if parameter_flag==0:
	temp_inherited.specifier=4
	temp_inherited.type=temp_inherited.type+400
      t[0] = Attribute()
      t[0]=initAttr(t[0])
      t[0].specifier=4
      t[0].type=t[0].type+400 


def p_type_specifier_4(t):
      '''type_specifier : FLOAT'''
      #print "type_specifier : FLOAT"
      global DEBUGP
      global parameter_flag
      global temp_inherited
      if DEBUGP:
	print "type_specifier : FLOAT"
      if parameter_flag==0:
	temp_inherited.specifier=6
	temp_inherited.type=temp_inherited.type+600
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].specifier=6
      t[0].type=t[0].type+600 


def p_type_specifier_5(t):
      '''type_specifier : TYPE_NAME'''
      #print "type_specifier : TYPE_NAME"
      global DEBUGP
      global parameter_flag
      global temp_inherited
      if DEBUGP:
	print "type_specifier : TYPE_NAME"
      if parameter_flag==0:
	temp_inherited.specifier=11
	temp_inherited.type=temp_inherited.type+1100
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].specifier=11
      t[0].type=t[0].type+1100 


def p_specifier_qualifier_list_2(t):
      '''specifier_qualifier_list : type_specifier'''
      #print "specifier_qualifier_list : type_specifier"
      global DEBUGP
      if DEBUGP:
	print "specifier_qualifier_list : type_specifier"
      t[0]=PassAttribute(t[1])
	
def p_declarator_1(t):
      '''declarator : pointer declarator'''
      #print "declarator : pointer declarator"
      global DEBUGP
      if (DEBUGP):
	print "\ndeclarator ->pointer direct_declarator\n"
      t[0]=PassAttribute(t[2])
      t[0].isPointer=1
			

def p_declarator_2(t):
      '''declarator : direct_declarator'''
      #print "declarator : direct_declarator"
      global DEBUGP
      if (DEBUGP):
	print "\ndeclarator : direct_declarator\n"
      t[0]=PassAttribute(t[1])

def p_set_parameter_flag_1(t):
      '''set_parameter_flag : '''
      global parameter_flag
      parameter_flag=1

def p_unset_parameter_flag_1(t):
      '''unset_parameter_flag : '''
      global parameter_flag
      parameter_flag=0

def p_direct_declarator_1(t):
      '''direct_declarator : identifier'''
      #print "direct_declarator : identifier"
      global DEBUGP
      global declaration_flag
      global parameter_flag
      global temp_inherited
      global currentScope
      global function
      global error_flag
      if (DEBUGP):
	print "\ndirect_declarator ->identifier\n"
      if(declaration_flag==1 and parameter_flag==0):
	if(t[1].type == 0):
	  t[1].type = temp_inherited.storage*10 + temp_inherited.specifier*100
	  t[1].isPointer=temp_inherited.isPointer
	elif(t[1].scope<currentScope):
	  p=SymEntry()
	  t[1]=InsertSymTable(t[1].id,currentScope,t[1].type,function)
	  t[1].type = temp_inherited.storage*10 + temp_inherited.specifier*100
	  t[1].isPointer=temp_inherited.isPointer
	elif(t[1].isFunction==1):
	  if(t[1].type!=temp_inherited.specifier*100):
	    error_flag=1
	    print "\nError : Incompatible with previous definition of function "+t[1].id
	else:
	  print "\nError : variable " +t[1].id+" already defined \n"
      elif(parameter_flag==0):
	if(t[1].type ==  0):
	  print " Error : variable type "+t[1].id+" not defined \n"	
      t[0]=PassSymEntry(t[1])     
      temp = t[0].id      
      if(parameter_flag==0):
	t[0].specifier=temp_inherited.specifier
	t[0].storage=temp_inherited.storage


def p_direct_declarator_3(t):
      '''direct_declarator : direct_declarator '[' constant_expression ']'
      '''
      #print "direct_declarator : direct_declarator '[' constant_expression ']'"
      global DEBUGP
      p=SymEntry()
      global declaration_flag
      global parameter_flag
      global temp_inherited
      global error_flag
      global function
      global size
      if DEBUGP:
	print "direct_declarator : direct_declarator '[' constant_expression ']'"
      if(declaration_flag==1 and parameter_flag==0):
	if(t[1].isArray == 0):
	  t[1].type = temp_inherited.storage*10 + temp_inherited.specifier*100
	  t[1].isPointer=temp_inherited.isPointer
	  t[1].isArray=1
	  p=lookup(t[1].id,function)
	  p.isArray=1
	  if(not((t[3].specifier==2 and t[3].isString==0)or t[3].specifier==4 or t[3].specifier==5)):
	    error_flag=1
	    print "\nError : Array Size has to an integer\n"
	  else:
	    t[1].ArrayLimit=t[3].IntConstValue
	    p.ArrayLimit=t[3].IntConstValue
	    size=size+(int(t[1].ArrayLimit)-1)*4
	else:
	  error_flag=1
	  print "\nError : variable"+t[1].id+" already defined \n"
      elif(parameter_flag==0):
	if(t[1].type ==  0):
	  error_flag=1
	  print " Error : array variable type "+t[1].id+" not defined \n"
      t[0]=PassAttribute(t[1])
      if(parameter_flag==1):
	t[0].isArray=1
	if(not((t[3].specifier==2 and t[3].isString==0)or t[3].specifier==4 or t[3].specifier==5)):
	  error_flag=1
	  print "\nError : Array Size has to an integer\n"
	else:
	  t[0].ArrayLimit=t[3].IntConstValue
	  
	  
def p_direct_declarator_4(t):
      '''direct_declarator : direct_declarator '[' ']'   '''
      #print "direct_declarator : direct_declarator '[' ']'"
      global DEBUGP
      global declaration_flag
      global parameter_flag
      global temp_inherited
      global function
      global error_flag
      p=SymEntry()
      if(DEBUGP):
	print "\ndirect_declarator ->direct_declarator '[' ']'\n"
      if(declaration_flag==0 and parameter_flag==0):
	if(t[1].isArray == 0):
	  t[1].type = temp_inherited.storage*10 + temp_inherited.specifier*100
	  t[1].isPointer=temp_inherited.isPointer
	  t[1].isArray=1
	  p=lookup(t[1].id,function)
	  p.isArray=1
	  t[1].ArrayLimit=0
	  p.ArrayLimit=0
	else:
	  error_flag=1
	  print "\nError : variable"+t[1].id+" already defined \n"
      elif(parameter_flag==0):
	if(t[1].type ==  0):
	  error_flag=1
	  print " Error : array variable type "+t[1].id+" not defined \n" 
	t[0]=PassAttribute(t[1])
	t[0].isArray=1

def p_direct_declarator_5(t):
      '''direct_declarator : direct_declarator '(' set_parameter_flag parameter_type_list unset_parameter_flag ')'
      '''
      #print "direct_declarator : direct_declarator '(' set_parameter_flag parameter_type_list unset_parameter_flag ')'"
      global DEBUGP
      global error_flag
      global parameter_flag
      global declaration_flag
      global function
      global temp_inherited
      global temp_Parameters
      global funcName
      if(DEBUGP):
	print "\ndirect_declarator ->direct_declarator '(' set_parameter_flag parameter_type_list  unset_parameter_flag ')'\n"
      if(parameter_flag==1 and declaration_flag!=1):
	error_flag=1
	print "\nError :hooooo Function Overloading/Passing Function as Argument is out of Implemented Scope\n"
      else:
	p=SymEntry()
	t[1].type = temp_inherited.storage*10 + temp_inherited.specifier*100
	t[1].isPointer=temp_inherited.isPointer
	t[1].isFunction=1
	p=lookup(t[1].id,function)
	if p==None:
	      
	      p = SymEntry()
	if(p.isFunction==1):
	  if(p.numParameters!=t[4].numParameters):
	    error_flag=1
	    print "\nError3 : Function Overloading not possible\n"
	  else:
	    for counter in range(t[4].numParameters):
	      if(p.ParameterList[counter].type!=t[4].ParameterList[counter].type):
		error_flag=1
		print "\nError4 : Function Overloading not possible\n"
	else:
	  p.isFunction=1
	  for counter in range(t[4].numParameters):
	    t[1].ParameterList[counter]=PassAttribute(t[4].ParameterList[counter])
	    p.ParameterList[counter]=PassAttribute(t[4].ParameterList[counter])
	  t[1].numParameters=t[4].numParameters
	  p.numParameters=t[4].numParameters
      t[0]=PassAttribute(t[1])
      t[0].isFunction=1
      funcName=t[1].id
      temp_Parameters=PassAttribute(t[4])
	
def p_direct_declarator_6(t):
      '''direct_declarator : direct_declarator '(' set_parameter_flag identifier_list unset_parameter_flag ')'  '''
      #print "direct_declarator : direct_declarator '(' set_parameter_flag identifier_list unset_parameter_flag ')'"
      global DEBUGP
      global error_flag
      global funcName
      if (DEBUGP):
	print "direct_declarator : direct_declarator '(' set_parameter_flag identifier_list unset_parameter_flag ')'"
      error_flag=1
      print "\nError : Implementation out of Scope of compiler.\n"
      t[0]=PassAttribute(t[1])
      funcName=t[1].id
      
def p_direct_declarator_7(t):
      '''direct_declarator : direct_declarator '(' ')'
      '''
      #print "direct_declarator : direct_declarator '(' ')'"
      global DEBUGP
      global parameter_flag
      global temp_inherited
      global error_flag
      global function
      global funcName
      if (DEBUGP):
	print "\ndirect_declarator -> direct_declarator '(' ')'\n"
      if(t[1].isFunction==1 or parameter_flag==1):
	error_flag=1
	print "\nError : Function Overloading/Passing Function as Argument is out of Implemented Scope\n"
      else:
	p=SymEntry()
	t[1].type = temp_inherited.storage*10 + temp_inherited.specifier*100
	t[1].isPointer=temp_inherited.isPointer
	t[1].isFunction=1
	p=lookup(t[1].id,function)
	
	if p==None:
	      p = SymEntry()
	if(p.isFunction==1 and p.numParameters!=0):
	  error_flag=1
	  print "\nError : Function has no arguments according to previous definition\n"
	else:
	  p.isFunction=1
	  p.numParameters=0
      t[0]=PassAttribute(t[1])
      t[0].isFunction=1
      funcName=t[1].id

def p_pointer_1(t):
      '''pointer : '*'
      '''
      #print " pointer : '*'"
      global DEBUGP
      global temp_inherited
      global parameter_flag
      if(DEBUGP):
	print "\npointer ->'*'\n"
      t[0]=Attribute()
      t[0] = initAttr(t[0])
      t[0].isPointer=1
      if(parameter_flag==0):
	temp_inherited.isPointer=1
      

def p_parameter_type_list_1(t):
      '''parameter_type_list : parameter_list'''
      #print "parameter_type_list : parameter_list"
      global DEBUGP
      if(DEBUGP):
	print "parameter_type_list : parameter_list"
      t[0]=PassAttribute(t[1])
	  
def p_parameter_list_1(t):
      '''parameter_list : parameter_declaration'''
      #print "parameter_list : parameter_declaration"
      global DEBUGP
      if(DEBUGP):
	print "parameter_list : parameter_declaration"
      t[0] = Attribute()
      t[0]=initAttr(t[0])
      t[0].ParameterList[0]=PassAttribute(t[1])
      t[0].numParameters=1
     
def p_parameter_list_2(t):
      '''parameter_list : parameter_list ',' parameter_declaration'''
      #print "parameter_list : parameter_list ',' parameter_declaration"
      global DEBUGP
      if(DEBUGP):
	print "parameter_list : parameter_list ',' parameter_declaration"
      t[0] = PassAttribute(t[1])
      t[0].ParameterList[t[1].numParameters]=PassAttribute(t[3])
      t[0].numParameters = t[0].numParameters +1

def p_parameter_declaration_1(t):
      '''parameter_declaration : declaration_specifiers declarator'''
      #print "parameter_declaration : declaration_specifiers declarator"
      global DEBUGP
      global error_flag
      if(DEBUGP):
	print "parameter_declaration : declaration_specifiers declarator"     
      t[0]=PassAttribute(t[2])
      
      t[0].type=t[1].type
      t[0].specifier=t[1].specifier
      t[0].qualifier=t[1].qualifier
      if(t[2].isFunction==1):     
	    error_flag=1
	    print "\nError : Function Passing is out of Implemented Scope\n"     
      
def p_parameter_declaration_2(t):
      '''parameter_declaration : declaration_specifiers abstract_declarator'''
      #print "parameter_declaration : declaration_specifiers abstract_declarator"
      global DEBUGP
      if(DEBUGP):
	print "parameter_declaration : declaration_specifiers abstract_declarator"
      t[0]=PassAttribute(t[2])
     
      t[0].type=t[1].type
      t[0].specifier=t[1].specifier
     

def p_parameter_declaration_3(t):
      '''parameter_declaration : declaration_specifiers'''
      #print "parameter_declaration : declaration_specifiers"
      global DEBUGP
      if(DEBUGP):
	      print "parameter_declaration : declaration_specifiers"
      t[0]=PassAttribute(t[1])

def p_identifier_list_1(t):
      '''identifier_list : identifier'''
      #print "parameter_declaration : declaration_specifiers"
      global DEBUGP
      if(DEBUGP):
	print "parameter_declaration : declaration_specifiers" 
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].ParameterList[0]=PassSymEntry(t[1])
      t[0].numParameters=1
	      
def p_identifier_list_2(t):
      '''identifier_list : identifier_list ',' identifier'''
      #print "identifier_list : identifier_list ',' identifier"
      global DEBUGP
      if(DEBUGP):
	print "identifier_list : identifier_list ',' identifier"
      t[0]=PassAttribute(t[1])
      t[0].ParameterList[t[1].numParameters]=PassSymEntry(t[3])
      t[0].numParameters= t[0].numParameters +1

def p_type_name_1(t):
      '''type_name : specifier_qualifier_list'''
      #print "type_name : specifier_qualifier_list"
      global DEBUGP
      if(DEBUGP):
	  print "type_name : specifier_qualifier_list"
      t[0]= PassAttribute(t[1])

def p_type_name_2(t):
      '''type_name : specifier_qualifier_list abstract_declarator'''
      #print "type_name : specifier_qualifier_list abstract_declarator"
      global DEBUGP
      if(DEBUGP):
	print "type_name : specifier_qualifier_list abstract_declarator"
      t[0] = PassAttribute(t[2])
      t[0].specifier=t[1].specifier
      t[0].type=t[1].type
      

def p_abstract_declarator_1(t):
      '''abstract_declarator : pointer'''
      #print "abstract_declarator : pointer"
      global DEBUGP
      if(DEBUGP):
	print "abstract_declarator : pointer"
      t[0] = PassAttribute(t[1])      

def p_abstract_declarator_2(t):
      '''abstract_declarator : direct_abstract_declarator'''
      #print "abstract_declarator : direct_abstract_declarator"
      global DEBUGP
      if(DEBUGP):
	print "abstract_declarator : direct_abstract_declarator"
      t[0] = PassAttribute(t[1])

def p_abstract_declarator_3(t):
      '''abstract_declarator : pointer direct_abstract_declarator'''
      #print "abstract_declarator : pointer direct_abstract_declarator"
      global DEBUGP
      if(DEBUGP):
	print "abstract_declarator : pointer direct_abstract_declarator"
      t[0] = PassAttribute(t[1])      
      t[0].isPointer= 1


def p_direct_abstract_declarator_2(t):
      '''direct_abstract_declarator : '[' ']'
      '''
      #print "abstract_declarator : pointer direct_abstract_declarator"
      global DEBUGP
      if(DEBUGP):
	print "abstract_declarator : pointer direct_abstract_declarator"
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].isArray=1

def p_direct_abstract_declarator_3(t):
      '''direct_abstract_declarator : '[' constant_expression ']'
      '''
      #print "direct_abstract_declarator : '[' constant_expression ']'"
      global DEBUGP
      global error_flag
      if(DEBUGP):
	print "direct_abstract_declarator : '[' constant_expression ']'"
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].isArray=1
      if(not((t[2].specifier==2 and t[2].isString==0) or t[2].specifier==4 or t[2].specifier==5)):
	      error_flag=1
	      print "\nError : Array Size of Parameter has to an integer\n"
      else:
	  t[0].ArrayLimit=t[2].IntConstValue
				      	      

def p_initializer_1(t):
      '''initializer : assignment_expression'''
      #print "initializer : assignment_expression"
      global DEBUGP
      if(DEBUGP):
	print "initializer : assignment_expression"
      t[0]=PassAttribute(t[1])

def p_initializer_2(t):
      '''initializer : '{' initializer_list '}'
      '''
      #print "initializer : '{' initializer_list '}'"
      global DEBUGP
      if(DEBUGP):
	print "initializer : '{' initializer_list '}'"
      t[0]=Attribute()   
      t[0]=initAttr(t[0])
      if(t[2].numParameters>0):      
	  t[0].numParameters=t[2].numParameters
	  for counter in range(t[2].numParameters):	  
		t[0].ParameterList[counter]=t[2].ParameterList[counter]	  
      else:      
	  t[0].ParameterList[0]=PassAttribute(t[2])
	  t[0].numParameters=1      

def p_initializer_3(t):
      '''initializer : '{' initializer_list ',' '}'   '''
      #print "initializer : '{' initializer_list ',' '}'"
      global DEBUGP
      if(DEBUGP):
	print "initializer : '{' initializer_list ',' '}'"
      t[0]=Attribute()   
      t[0]=initAttr(t[0])
      if(t[2].numParameters>0):      
	  t[0].numParameters=t[2].numParameters
	  for counter in range(t[2].numParameters):	  
		t[0].ParameterList[counter]=t[2].ParameterList[counter]	  
      else:      
	  t[0].ParameterList[0]=PassAttribute(t[2])
	  t[0].numParameters=1            

def p_initializer_list_1(t):
      '''initializer_list : initializer'''
      #print "initializer_list : initializer"
      global DEBUGP
      if(DEBUGP):
	print "initializer_list : initializer"
      t[0]=Attribute()   
      t[0]=initAttr(t[0])      
      t[0].ParameterList[0]=PassAttribute(t[1])
      t[0].numParameters=1  

def p_initializer_list_2(t):
      '''initializer_list : initializer_list ',' initializer'''
      #print "initializer_list : initializer_list ',' initializer"
      global DEBUGP
      if(DEBUGP):
	print "initializer_list : initializer_list ',' initializer"
      t[0]=PassAttribute(t[1])   
      t[0].ParameterList[t[0].numParameters]=PassAttribute(t[3])
      t[0].numParameters=t[0].numParameters +1

def p_statement_1(t):
      '''statement : labeled_statement'''
      #print "\nstatement : labeled_statement\n"
      global DEBUGP
      if DEBUGP:
	print "\nstatement : labeled_statement\n"
      t[0]=PassAttribute(t[1])      

def p_statement_2(t):
      '''statement : compound_statement'''
      #print "\nstatement : compound_statement\n"
      global DEBUGP
      if DEBUGP:
	print "\nstatement : compound_statement\n"
      t[0]=PassAttribute(t[1])      

def p_statement_3(t):
      '''statement : expression_statement'''
      #print "\nstatement : expression_statement\n"
      global DEBUGP
      if DEBUGP:
	print "\nstatement : expression_statement\n"
      t[0]=PassAttribute(t[1])      

def p_statement_4(t):
      '''statement : selection_statement'''
      #print "\nstatement : selection_statement\n"
      global DEBUGP
      if DEBUGP:
	print "\nstatement : selection_statement\n"
      t[0]=PassAttribute(t[1])      

def p_statement_5(t):
      '''statement : iteration_statement'''
      #print "\nstatement : iteration_statement\n"
      global DEBUGP
      if DEBUGP:
	print "\nstatement : iteration_statement\n"
      t[0]=PassAttribute(t[1])      

def p_statement_6(t):
      '''statement : jump_statement'''
      #print "\nstatement : jump_statement\n"
      global DEBUGP
      if DEBUGP:
	print "\nstatement : jump_statement\n"
      t[0]=PassAttribute(t[1])      


def p_labeled_statement_2(t):
      '''labeled_statement : CASE constant_expression ':' statement'''
      #print "\nlabeled_statement -> CASE constant_expression ':' statement\n"
      global DEBUGP
      global error_flag
      global intcode
      global finalcode
      global temp_expression
      if(DEBUGP):
	    print "\nlabeled_statement -> CASE constant_expression ':' statement\n"
     
      t[0]=PassAttribute(t[2])
      if(t[2].qualifier!=1 or t[2].isString==1):      
	    error_flag=1
	    print "\nError : Invalid Label Type\n"
	          	    
      else:
	    finalcode = "\n\n"
	    intcode = t[2].icode
	    l1=getNewLabel() 
	    #print "mera nam hai ",l1			     
	    finalcode = finalcode + t[2].code
	   
	    finalcode = finalcode + temp_expression.code
	    intcode = intcode + temp_expression.icode
	    coded = "\tif "+temp_expression.id+"="+t[2].id+" then goto "+l1+" \n "+t[4].icode+"\n\t"+l1+":\n"	   
	    intcode = intcode +coded
	    coded = "\tlw $t0 "+toAddr(t[2].offset)+"\n"	    
	    finalcode = finalcode+coded
	    coded = "\tlw $t1 "+toAddr(temp_expression.offset)+"\n" 	   
	    finalcode = finalcode + coded
	    coded = "\tbne $t0 $t1 "+l1+"\n" 	   
	    finalcode = finalcode + coded
	    finalcode =  finalcode + t[4].code
	    coded = "\t"+l1+" :\n" 	    
	    finalcode = finalcode+coded	    
	    t[0].code=finalcode
	    t[0].icode=intcode

def p_labeled_statement_3(t):
      '''labeled_statement : DEFAULT ':' statement'''
      #print "\nlabeled_statement : DEFAULT ':' statement\n"
      global end
      global currentDepth
      if(DEBUGP):
	    print "\nlabeled_statement : DEFAULT ':' statement\n"
      t[0]=PassAttribute(t[3])      	      
      t[0].icode=t[3].icode
      coded = "\tgoto "+end[currentDepth-1:currentDepth+3]+"\n"     
      t[0].icode=t[0].icode+coded
      t[0].code="\n\n"
      t[0].code=t[0].code+t[3].code
      coded = "\tj "+end[currentDepth-1:currentDepth+3]+"\n"      
      t[0].code=t[0].code+coded

def p_compound_statement_1(t):
      '''compound_statement : '{' '}'      '''
      #print "\ncompound_statement : '{' '}'\n"
      global DEBUGP     
      if DEBUGP:
	print "\ncompound_statement : '{' '}'\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1
      t[0].code = ""
      t[0].icode = ""

def p_compound_statement_2(t):
      '''compound_statement : '{' new_scope compound_statement_list finish_scope '}'      '''
      #print "\ncompound_statement : '{' new_scope compound_statement_list finish_scope '}'\n"
      global DEBUGP     
      if DEBUGP:
	print "\ncompound_statement : '{' new_scope compound_statement_list finish_scope '}'\n"
      t[0] = PassAttribute(t[3])

def p_compound_statement_3(t):
      '''compound_statement : '{' new_scope compound_declaration_list finish_scope '}'
      '''
      #print "\ncompound_statement : '{' new_scope compound_declaration_list finish_scope '}'\n"
      global DEBUGP     
      if DEBUGP:
	print "\ncompound_statement : '{' new_scope compound_declaration_list finish_scope '}'\n"
#      print t[3].icode
      t[0] = PassAttribute(t[3])

def p_compound_statement_list_1(t):
      '''compound_statement_list : declaration_list'''
      #print "\ncompound_statement_list : declaration_list\n"
      global DEBUGP     
      if DEBUGP:
	print "\ncompound_statement_list : declaration_list\n"
      t[0] = PassAttribute(t[1])

def p_compound_statement_list_2(t):
      '''compound_statement_list : declaration_list compound_declaration_list'''
      #print "\ncompound_statement_list : declaration_list compound_declaration_list\n"
      global DEBUGP     
      if DEBUGP:
	print "\ncompound_statement_list : declaration_list compound_declaration_list\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      t[0].code = t[1].code + t[2].code
      t[0].icode = t[1].icode + t[2].icode

def p_compound_declaration_list_1(t):
      '''compound_declaration_list : statement_list'''
      #print "\ncompound_declaration_list : statement_list\n"
      global DEBUGP     
      if DEBUGP:
	print "\ncompound_declaration_list : statement_list\n"
      t[0] = PassAttribute(t[1])

def p_compound_declaration_list_2(t):
      '''compound_declaration_list : statement_list compound_statement_list'''
      #print "\ncompound_declaration_list : statement_list compound_statement_list\n"
      global DEBUGP     
      if DEBUGP:
	print "\ncompound_declaration_list : statement_list compound_statement_list\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      t[0].code = t[1].code + t[2].code
      t[0].icode = t[1].icode + t[2].icode

def p_declaration_list_1(t):
      '''declaration_list : declaration'''
      #print "\ndeclaration_list : declaration\n"
      global DEBUGP     
      if DEBUGP:
	print "\ndeclaration_list : declaration\n"
      t[0] = PassAttribute(t[1])

def p_declaration_list_2(t):
      '''declaration_list : declaration_list declaration'''
      #print "\ndeclaration_list : declaration_list declaration\n"
      global DEBUGP     
      if DEBUGP:
	print "\ndeclaration_list : declaration_list declaration\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      t[0].code = t[1].code + t[2].code
      t[0].icode = t[1].icode + t[2].icode

def p_statement_list_1(t):
      '''statement_list : statement'''
      #print "\nstatement_list : statement\n"
      global DEBUGP     
      if DEBUGP:
	print "\nstatement_list : statement\n"
      t[0] = PassAttribute(t[1])

def p_statement_list_2(t):
      '''statement_list : statement_list statement'''
      #print "\nstatement_list : statement_list statement\n"
      global DEBUGP     
      if DEBUGP:
	print "\nstatement_list : statement_list statement\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      t[0].code = t[1].code + t[2].code
      t[0].icode = t[1].icode + t[2].icode

def p_expression_statement_1(t):
      '''expression_statement : ';'      '''
      #print "\nexpression_statement : ';'\n"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	print "\nexpression_statement : ';'\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      t[0].code = ""
      t[0].icode = ""
      assign_flag=0

def p_expression_statement_2(t):
      '''expression_statement : expression ';'      '''
      #print "\nexpression_statement : expression ';'\n"
      global DEBUGP     
      if DEBUGP:
	print "\nexpression_statement : expression ';'\n"
      t[0] = PassAttribute(t[1])

def p_expression_statement_3(t):
      '''expression_statement : expression error'''
      #print "\nexpression_statement : expression error\n"
      global DEBUGP     
      global error_flag
      global assign_flag
      if DEBUGP:
	print "\nexpression_statement : expression error\n"
      t[0] = PassAttribute(t[1])
      error_flag = 1
      assign_flag = 1

sizetemp=0
def p_get_labels_1(t):
      '''get_labels : '''
      #print "\nget_labels : \n"
      global DEBUGP
      global start
      global end
      global currentDepth
      if DEBUGP:
	    print "\nget_labels : \n"	    
      temp1 = start[:currentDepth]
      temp2 = start[currentDepth+1:]
      temp3 = getNewLabel()
      global sizetemp
      sizetemp=len(temp3)
      tempor=start[:currentDepth]+temp3+start[currentDepth+1:]
      start = tempor
      temp1 = end[:currentDepth]
      temp2 = end[currentDepth+1:]
      temp3 = getNewLabel()
      end = end[:currentDepth]+temp3+end[currentDepth+1:]
      t2=end

      currentDepth = currentDepth + 1

def p_release_labels_1(t):
      '''release_labels : '''
      #print "\nrelease_labels : \n"
      global DEBUGP
      global start
      global currentDepth
      if DEBUGP:
	    print "\nrelease_labels : \n"

      if(start[currentDepth+1]!=None):
	    pass
      currentDepth = currentDepth - 1
      

def p_switch_label_1(t):
      '''switch_label : '''
      #print "\nswitch_label : \n"
      global DEBUGP
      global switch_flag
      if DEBUGP:
	    print "\nswitch_label : \n"
      switch_flag=1
      
def p_release_switch_label_1(t):
      '''release_switch_label : '''
      #print "\nrelease_switch_label : \n"
      global DEBUGP
      global switch_flag
      if DEBUGP:
	    print "\nrelease_switch_label : \n"
      switch_flag=0
      
def p_selection_statement_1(t):
      '''selection_statement : IF '(' expression ')' statement %prec IFX'''
      #print "\nselection_statement : IF '(' expression ')' statement %prec IFX\n"
      global DEBUGP
      global intcode
      global finalcode
      if DEBUGP:
	    print "\nselection_statement : IF '(' expression ')' statement %prec IFX\n"
      t[0]=PassAttribute(t[5])      
      l1=getNewLabel()		    
      
      finalcode=t[3].code
      intcode=t[3].icode
      coded = "\tif "+t[3].id+"=0 then goto "+l1+" \n "+t[5].icode+"\n\t"+l1+":\n"        
      intcode = intcode + coded
      coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"      
      finalcode = finalcode + coded
      coded = "\tbeq $t0 $0 "+l1+"\n"      
      finalcode = finalcode + coded      
      finalcode =  finalcode + t[5].code
      coded = "\t"+l1+":\n"      
      finalcode = finalcode + coded
      t[0].code=finalcode
      t[0].icode=intcode
      

def p_selection_statement_2(t):
      '''selection_statement : IF '(' expression ')' statement ELSE statement'''
      #print "\nselection_statement : IF '(' expression ')' statement ELSE statement\n"
      global DEBUGP
      global intcode
      global finalcode
      if DEBUGP:
	    print "\nselection_statement : IF '(' expression ')' statement ELSE statement\n"
      t[0]=PassAttribute(t[5])      
      l1=getNewLabel()
      l2=getNewLabel()
      
      finalcode=t[3].code
      intcode=t[3].icode
      coded = "\tif "+t[3].id+"=0 then goto "+l1+"\n"
      intcode=intcode+coded
      coded = t[5].icode+"\tgoto "+l2+"\n"
      intcode=intcode+coded
      coded = "\t"+l1+" :\n"+t[7].icode+" \t"+l2+" :\n"      
      intcode = intcode + coded
      coded = "\tlw $t0 "+toAddr(t[3].offset)+"\n"      
      finalcode =  finalcode + coded
      coded = "\tbeq $t0 $0 "+l1+"\n"      
      finalcode =  finalcode + coded
      coded = t[5].code      
      finalcode =  finalcode + coded
      coded = "\tj "+l2+"\n"      
      finalcode = finalcode + coded
      coded = "\t"+l1+" :\n"+t[7].code
      finalcode = finalcode+coded
      coded = "\t"+l2+" :\n"      
      finalcode  = finalcode + coded
      t[0].code=finalcode
      t[0].icode=intcode

def p_selection_statement_3(t):
      '''selection_statement : SWITCH get_labels '(' expression ')' switch_label statement release_switch_label release_labels'''
      #print "\nselection_statement : SWITCH get_labels '(' expression ')' switch_label statement release_switch_label release_labels\n"
      global currentDepth
      global DEBUGP
      global end      
      global finalcode
      global intcode
      if DEBUGP:
	    print "\nselection_statement : SWITCH get_labels '(' expression ')' switch_label statement release_switch_label release_labels\n"
      t[0]=PassAttribute(t[7])
      finalcode= t[4].code
      intcode=t[4].icode
      coded = t[7].icode      
      intcode=intcode+coded
      coded = "\t"+end[currentDepth:currentDepth+4]+" :\n"      
      intcode=intcode+coded
      coded = t[7].code
      finalcode=finalcode+coded
      coded = "\t"+end[currentDepth:currentDepth+4]+" :\n"     
      finalcode=finalcode+coded		  
      t[0].code=finalcode
      t[0].icode=intcode

def p_iteration_statement_1(t):
      '''iteration_statement : WHILE get_labels '(' expression ')' statement release_labels'''
      #print "\niteration_statement : WHILE get_labels '(' expression ')' statement release_labels\n"
      global DEBUGP
      global finalcode
      global intcode
      global start
      global end
      global currentDepth
      if DEBUGP:
	    print "\niteration_statement : WHILE get_labels '(' expression ')' statement release_labels\n"
      t[0]=PassAttribute(t[6])	    
      coded = "\t"+start[currentDepth:currentDepth+4]+" :\n"      
      finalcode=coded + t[4].code
      intcode=coded + t[4].icode
      coded = "\tif "+t[4].id+"=0 then goto "+end[currentDepth:currentDepth+4]+"\n"
      intcode=intcode+coded
      coded = t[6].icode+"\tgoto "+start[currentDepth:currentDepth+4]+"\n"      
      intcode=intcode+coded
      coded = "\t"+end[currentDepth:currentDepth+4]+" :\n"
      intcode = intcode + coded
      coded = "\tlw $t0 "+toAddr(t[4].offset)+"\n"      
      finalcode = finalcode + coded
      coded = "\tbeq $t0 $0 "+end[currentDepth:currentDepth+4]+"\n"       
      finalcode = finalcode + coded
      coded = t[6].code      
      finalcode = finalcode+coded
      coded ="\tj "+start[currentDepth:currentDepth+4]+"\n"      
      finalcode = finalcode + coded
      coded = "\t"+end[currentDepth:currentDepth+4]+" :\n"      
      finalcode = finalcode + coded
      t[0].code=finalcode
      t[0].icode=intcode

def p_iteration_statement_2(t):
      '''iteration_statement : DO get_labels statement WHILE '(' expression ')' ';' release_labels'''
      #print "\niteration_statement : DO get_labels statement WHILE '(' expression ')' ';' release_labels\n"
      global DEBUGP
      global finalcode
      global intcode
      global start
      global end
      global currentDepth
      if DEBUGP:
	    print "\niteration_statement : DO get_labels statement WHILE '(' expression ')' ';' release_labels\n"
      t[0]=PassAttribute(t[3])
      coded= "\t"+start[currentDepth:currentDepth+4] +" :\n"
      finalcode=coded + t[3].code
      intcode=coded + t[3].icode
      coded= t[6].icode+"\tif "+t[6].id+"!=0 then goto "+start[currentDepth:currentDepth+4]+"\n"	      
      intcode= intcode+ coded
      coded = t[6].code+"\tlw $t0 "+toAddr(t[6].offset)+"\n"
      finalcode= finalcode+ coded
      coded = "\tbne $t0 $0 "+  start[currentDepth:currentDepth+4]+"\n"
      finalcode = finalcode + coded
      t[0].code=finalcode
      t[0].icode=intcode

def p_iteration_statement_3(t):
      '''iteration_statement : FOR get_labels '(' expression_statement expression_statement _embed0_iteration_statement ')' statement release_labels'''
      #print "\niteration_statement : FOR get_labels '(' expression_statement expression_statement _embed0_iteration_statement ')' statement release_labels\n"
      global DEBUGP
      global finalcode
      global intcode
      global start
      global end
      global currentDepth
      if DEBUGP:
	    print "\niteration_statement : FOR get_labels '(' expression_statement expression_statement _embed0_iteration_statement ')' statement release_labels\n"
      t[0]=PassAttribute(t[8]) 
      finalcode=t[4].code
      intcode=t[4].icode
      coded = "\t"+start[currentDepth:currentDepth+4]+" :\n"      
      finalcode=finalcode+coded
      intcode=intcode+coded
      finalcode=finalcode+ t[5].code
      intcode=intcode+ t[5].icode
      coded= "\tif "+t[5].id+"=0 then goto "+end[currentDepth:currentDepth+4]+"\n"      
      intcode=intcode+coded
      coded= t[8].icode+"\tgoto "+start[currentDepth:currentDepth+4]+"\n"      
      intcode=intcode+coded
      coded = "\t"+end[currentDepth:currentDepth+4]+" :\n"      
      intcode = intcode +coded
      coded= "\tlw $t0 "+toAddr(t[5].offset)+"\n"      
      finalcode = finalcode +coded
      coded= "\tbeq $t0 $0 "+end[currentDepth:currentDepth+4]+"\n" 
      finalcode = finalcode +coded
      coded= t[8].code      
      finalcode =  finalcode + coded
      coded= "\tj "+start[currentDepth:currentDepth+4]+"\n"      
      finalcode =  finalcode + coded
      coded= "\t"+end[currentDepth:currentDepth+4]+" :\n"      
      finalcode = finalcode +coded
      t[0].code=finalcode
      t[0].icode=intcode

def p_iteration_statement_4(t):
      '''iteration_statement : FOR get_labels '(' expression_statement expression_statement expression _embed1_iteration_statement ')' statement release_labels'''
      #print "\niteration_statement : FOR get_labels '(' expression_statement expression_statement expression _embed1_iteration_statement ')' statement release_labels\n"
      global DEBUGP
      global finalcode
      global intcode
      global start
      global end
      global currentDepth
      if DEBUGP:
	    print "\niteration_statement : FOR get_labels '(' expression_statement expression_statement expression _embed1_iteration_statement ')' statement release_labels\n"
      t[0]=PassAttribute(t[9]) 
      finalcode=t[4].code
      intcode=t[4].icode
      coded = "\t"+start[currentDepth:currentDepth+4]+" :\n"      
      finalcode=finalcode+coded
      intcode=intcode+coded
      finalcode=finalcode+ t[5].code
      intcode=intcode+ t[5].icode
      coded= "\tif "+t[5].id+"=0 then goto "+end[currentDepth:currentDepth+4]+"\n"      
      intcode=intcode+coded
      coded= t[9].icode
      intcode = intcode + coded      
      coded = t[6].icode+ "\tgoto "+start[currentDepth:currentDepth+4]+"\n"      
      intcode=intcode+coded
      coded = "\t"+end[currentDepth:currentDepth+4]+" :\n"      
      intcode = intcode +coded
      coded= "\tlw $t0 "+toAddr(t[5].offset)+"\n"      
      finalcode = finalcode +coded
      coded= "\tbeq $t0 $0 "+end[currentDepth:currentDepth+4]+"\n" 
      finalcode = finalcode +coded
      coded= t[9].code      
      finalcode =  finalcode + coded + t[6].code
      coded= "\tj "+start[currentDepth:currentDepth+4]+"\n"      
      finalcode =  finalcode + coded
      coded= "\t"+end[currentDepth:currentDepth+4]+" :\n"      
      finalcode = finalcode +coded
      t[0].code=finalcode
      t[0].icode=intcode

def p__embed0_iteration_statement(t):
      '''_embed0_iteration_statement : '''
      #print "\n_embed0_iteration_statement : \n"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\n_embed0_iteration_statement : \n"
      assign_flag=0

def p__embed1_iteration_statement(t):
      '''_embed1_iteration_statement : '''
      #print "\n_embed1_iteration_statement : \n"
      global DEBUGP
      global assign_flag
      if DEBUGP:
	    print "\n_embed1_iteration_statement : \n"
      assign_flag=0

def p_jump_statement_2(t):
      '''jump_statement : CONTINUE ';'
      '''
      #print "\njump_statement : CONTINUE ';'\n"
      global currentDepth
      global DEBUGP
      global error_flag
      global start      
      if DEBUGP:
	    print "\njump_statement : CONTINUE ';'\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      if error_flag == 0:
	    coded = "\tgoto "+start[currentDepth-1:currentDepth+3]+"\n"	    
	    t[0].icode=coded
	    coded = "\tj "+start[currentDepth-1:currentDepth+3]+"\n"	    
	    t[0].code=coded
      else:
	    t[0].code = ""
	    t[0].icode = ""	    

def p_jump_statement_3(t):
      '''jump_statement : BREAK ';'
      '''
      #print "\njump_statement : BREAK ';'\n"
      global currentDepth
      global DEBUGP
      global end      
      global error_flag
      if DEBUGP:
	    print "\njump_statement : BREAK ';'\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      if error_flag == 0:
	    coded = "\tgoto "+end[currentDepth-1:currentDepth+3]+"\n"	    
	    t[0].icode=coded
	    coded = "\tj "+end[currentDepth-1:currentDepth+3]+"\n"	    
	    t[0].code=coded
      else:
	    t[0].code = ""
	    t[0].icode = ""	    

def p_jump_statement_4(t):
      '''jump_statement : RETURN ';'
      '''
      #print "\njump_statement : RETURN ';'\n"
      global currentDepth
      global DEBUGP
      global end      
      global error_flag
      global funcEndLabel
      if DEBUGP:
	    print "\njump_statement : RETURN ';'\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1      
      if error_flag == 0:
	    coded = "\tRETURN return_value 0\n"   
	    t[0].icode=coded
	    coded = "\tlw $ra "+toAddr(0)+"\n" 
	    t[0].code=coded
	    coded = "\tsw $0 "+toAddr(0)+"\n"
	    t[0].code=t[0].code+coded
	    coded = "\tj "+funcEndLabel+"\n"
	    t[0].code=t[0].code+coded
      else:
	    t[0].code = ""
	    t[0].icode = ""	    

def p_jump_statement_5(t):
      '''jump_statement : RETURN expression ';'
      '''
      #print "\njump_statement : RETURN expression ';'\n"
      global currentDepth
      global DEBUGP
      global end      
      global error_flag
      global funcEndLabel
      global funcName
      if DEBUGP:
	    print "\njump_statement : RETURN expression ';'\n"
      t[0] = Attribute()
      t[0] = initAttr(t[0])
      t[0].type = 100
      t[0].specifier = 1   
      p=Attribute()
      temp = lookup(funcName,0)
      if temp==None:
	    temp = SymEntry()
      p = PassSymEntry(temp)
      p.specifier=p.type/100
      p.isFunction=0
      if(t[2].type==100):      
	    error_flag=1
	    print "\nError : Invalid Return Type\n"  
      if(t[2].isFunction==1):      
	    error_flag=1
	    print "\nError : Cannot have a Function Return Type\n"      
      if(not(p.isArray==t[2].isArray and p.isPointer == t[2].isPointer)):
	    
	    error_flag=1
	    print "\nError : Invalid Return Type\n"      
      if error_flag == 0:
	    coded = t[2].icode+"\tRETURN return_value "+str(t[2].id)+"\n"   
	    t[0].icode=coded
	    #print "HUHUHU \n"+ t[2].code
	    coded = t[2].code+"\tlw $ra "+toAddr(0)+"\n" 
	    t[0].code=coded
	    coded = "\tlw $t0 "+toAddr(t[2].offset)+"\n"
	    t[0].code=t[0].code+coded
	    coded = "\tsw $t0 "+toAddr(0)+"\n"
	    t[0].code=t[0].code+coded
	    coded = "\tj "+funcEndLabel+"\n"
	    t[0].code=t[0].code+coded
      else:
	    t[0].code = ""
	    t[0].icode = ""	

def p_strt_1(t):
      '''strt : strt1
      | strt strt1 '''
      global fcgFile
      global icgFile
      #print "strt : strt1"
      global DEBUGP
      if DEBUGP:
	    print "strt : strt1"
      #print "#### below is the mips code generated:\n"+t[1].code+"\n"
      #print "#### below is the intermediate code generated:\n"+t[1].icode+"\n"
      if len(t)<3:	    
	    fcgFile.write(t[1].code)
	    icgFile.write(t[1].icode)      
      elif len(t)==3:	    
	    fcgFile.write(t[1].code + t[2].code)
	    icgFile.write(t[1].icode+ t[2].icode)      
      else:
	    fcgFile.write(t[4].code)
	    icgFile.write(t[4].icode)      

def p_strt1_1(t):
      '''strt1 : external_declaration'''
      #print "\nstrt1 : external_declaration\n"
      global DEBUGP      
      if DEBUGP:
	    print "\nstrt1 : external_declaration\n"
      t[0] = PassAttribute(t[1])      

def p_strt1_2(t):
      '''strt1 : strt1 external_declaration'''
      #print "\nstrt1 : strt1 external_declaration\n"
      global DEBUGP
      if DEBUGP:
	    print "\nstrt1 : strt1 external_declaration\n"
      t[0] = PassAttribute(t[1])
      t[0].code = t[0].code + t[2].code
      t[0].icode = t[0].icode + t[2].icode      

def p_external_declaration_1(t):
      '''external_declaration : function_definition'''
      #print "\nexternal_declaration : function_definition\n"
      global DEBUGP
      if DEBUGP:	    
	    print "\nexternal_declaration -> function_definition\n"
      t[0] = PassAttribute(t[1])

def p_external_declaration_2(t):
      '''external_declaration : declaration'''
      #print "\nexternal_declaration : declaration\n"
      global DEBUGP
      if DEBUGP:	    
	    print "\nexternal_declaration -> declaration\n"
      t[0] = PassAttribute(t[1])
      

def p_function_scope_1(t):
      '''function_scope : '''      
      #print "\nfunction_scope : \n"            
      #global function124      
      global currentScope      
      global DEBUGP
      global error_flag
      global funcName
      global function
      global global1
      global linenumber
      global oldsize
      global size      
      global tail      
      global temp_Parameters      
      global temp_inherited
      global funcEndLabel
      if DEBUGP:
	    print "\nfunction_scope : \n"            
      if function==1:     
	    error_flag=1
	    print "\nError : Cannot Declare a function in a function\n"     
      funcEndLabel=getNewLabel()
      function = 1
      currentScope = -1
      global1[1]=CreateNewSymTableNode()
      tail[1]=global1[1]
      global1[1].name = funcName          
      oldsize =size
      size = 4
      
      p = SymEntry()
      q=SymEntry()
      
      if temp_Parameters.numParameters != 0:	    
	    
	    q=lookup(funcName,0)
	    if q.type != temp_inherited.type:
		  error_flag=1
		  print "\nError : Function Definition not consistent with prevoius definition\n"
		  
	    if q.numParameters != temp_Parameters.numParameters:	    
		  error_flag=1
		  print "\nError1 "+str(linenumber)+" : Function Overloading not possible\n"

	    
	    for counter in range(temp_Parameters.numParameters):
		  if q.ParameterList[counter].type != temp_Parameters.ParameterList[counter].type:
			print "\nError2 : Function Overloading not possible\n"
			error_flag = 1
		  if temp_Parameters.ParameterList[counter].id == None:
			print "\nError4 : Varibale name for the parameter is missing\n"
			error_flag = 1
		  p = InsertSymTable(temp_Parameters.ParameterList[counter].id,0,temp_Parameters.ParameterList[counter].type,function)
		  p.offset=size
		  size= size + 4
		  q.ParameterList[counter]=PassAttribute(temp_Parameters.ParameterList[counter])
	    
      temp_Parameters=initAttr(temp_Parameters)
      

def p_unset_function_scope_1(t):
      '''unset_function_scope : '''
      #print "\nunset_function_scope : \n"
      global DEBUGP
      global function
      global currentScope
      global size  
      global oldsize
      if DEBUGP:
	    print "\nunset_function_scope : \n"
      function=0
      currentScope=0
      size=oldsize


def p_function_definition_1(t):
      '''function_definition : declaration_specifiers declarator declaration_list function_scope get_labels compound_statement release_labels unset_function_scope'''
      #print "\nfunction_definition : declaration_specifiers declarator declaration_list function_scope get_labels compound_statement release_labels unset_function_scope\n"
      global DEBUGP
      global intcode
      global finalcode
      global error_flag
      global funcEndLabel
      if DEBUGP:
	    print "\nfunction_definition : declaration_specifiers declarator declaration_list function_scope get_labels compound_statement release_labels unset_function_scope\n"
	    
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].type = 100
      t[0].specifier=1
      error_flag=1
      print "\nError : Compiler does not support this feature of C\n"					      
      print t[2]
      coded = "\n\t"+t[2].id+" :\n"
      finalcode=coded
      intcode=coded
      intcode = intcode +  t[3].icode + t[6].icode      
      coded = "\tRETURN : END OF SUB ROUTINE\n"
      intcode = intcode + coded
      coded = "\tsw $ra 0($sp)\n"
      finalcode = finalcode + coded + t[3].code + t[6].code           
      coded = "\tlw $ra "+toAddr(0)+"\n"      
      finalcode = finalcode + coded      
      coded = "\t"+funcEndLabel+" :\n"
      finalcode = finalcode + coded
      coded = "\tjr $ra\n"
      finalcode= finalcode +coded
      t[0].code=finalcode
      t[0].icode=intcode
      
def p_function_definition_2(t):
      '''function_definition : declaration_specifiers declarator function_scope get_labels compound_statement release_labels unset_function_scope'''
      #print "\nfunction_definition : declaration_specifiers declarator function_scope get_labels compound_statement release_labels unset_function_scope\n"
      global DEBUGP
      global finalcode
      global intcode
      global funcEndLabel
      if(DEBUGP):
	    print "\nfunction_definition : declaration_specifiers declarator function_scope get_labels compound_statement release_labels unset_function_scope\n"
      t[0]= Attribute()
      t[0]=initAttr(t[0])
      t[0].type=100
      t[0].specifier=1       
      coded= "\n\t"+ t[2].id +" :\n"
      finalcode= coded
      intcode= coded + t[5].icode
      coded= "\tRETURN : END OF SUB ROUTINE\n"
      intcode = intcode + coded 
      coded= "\tsw $ra 0($sp)\n"
      finalcode=finalcode + coded + t[5].code
      coded= "\tlw $ra " + toAddr(0)+"\n"
      finalcode = finalcode +coded
      coded= "\t" + funcEndLabel +" :\n"
      finalcode = finalcode +coded
      coded= "\tjr $ra\n"
      finalcode= finalcode+coded
      t[0].code=finalcode
      t[0].icode=intcode
			      
def p_function_definition_3(t):
      '''function_definition : declarator declaration_list function_scope get_labels compound_statement release_labels unset_function_scope'''
      #print "\nfunction_definition : declarator declaration_list function_scope get_labels compound_statement release_labels unset_function_scope\n"
      global DEBUGP
      global finalcode
      global intcode
      global error_flag
      global funcEndLabel
      if(DEBUGP):
	    print "\nfunction_definition : declarator declaration_list function_scope get_labels compound_statement release_labels unset_function_scope\n"
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].type=100
      t[0].specifier=1
      error_flag=1
      coded= "\n\t" + t[2].id+ " :\n"
      finalcode=coded
      intcode=coded + t[2].icode + t[5].icode
      coded = "\tRETURN : END SUB ROUTINE\n"
      intcode = intcode  + coded
   
      coded = "\tsw $ra 0($sp)\n"
      finalcode = finalcode + coded + t[2].code + t[5].code
      coded = "\tlw $ra "+ toAddr(0)+"\n"
      finalcode = finalcode  + coded    
      coded = "\t"+funcEndLabel+" :\n"
      finalcode = finalcode + coded
      coded = "\tjr $ra\n"
      finalcode  = finalcode + coded
      t[0].code = finalcode
      t[0].icode = intcode
      print "\nError : Compiler does not support this feature of C\n"
      
def p_function_definition_4(t):
      '''function_definition : declarator function_scope get_labels compound_statement release_labels unset_function_scope'''
      #print "\nfunction_definition : declarator function_scope get_labels compound_statement release_labels unset_function_scope\n"
      global DEBUGP
      global finalcode
      global intcode
      global error_flag
      global funcEndLabel
      if(DEBUGP):
	    print "\nfunction_definition : declarator function_scope get_labels compound_statement release_labels unset_function_scope\n"
   	      
      t[0]=Attribute()
      t[0]=initAttr(t[0])
      t[0].type=100
      t[0].specifier=1
      
      if lookup(t[1].id,0)==None:     
	    error_flag=1
	    print "\nError : Compiler does not support this feature of C\n"

      coded = "\n\t"+t[1].id+" :\n"
      finalcode = coded
      intcode = coded
      intcode= intcode+ t[4].icode
      coded = "\tRETURN : END SUB ROUTINE\n"
      intcode = intcode + coded     
      coded = "\tsw $ra 0($sp)\n"
      finalcode=coded
      finalcode = finalcode+ t[4].code
      coded = "\tlw $ra "+toAddr(0)+"\n"
      finalcode = finalcode + coded
      coded = "\t"+funcEndLabel+" :\n"
      finalcode = finalcode + coded
      coded = "\tjr $ra\n"
      finalcode = finalcode + coded      
      t[0].code = finalcode
      t[0].icode = intcode
      
# -------------- RULES END ----------------
'''
if __name__ == '__main__':
      from ply import *
      yacc.yacc()
'''



def MergeAttributes3Code(a1,a2):
      a = Attribute()
      a.isArray=0
      a=initAttr(a)
      if((a1.specifier==4 or a1.specifier==5) and (a2.specifier==4 or a2.specifier==5)):      
	    a.specifier=a1.specifier
	    if(a2.specifier==5):      
		  a.specifier=5    
      elif((a1.specifier==4 or a1.specifier==5) and (a2.specifier==6 or a2.specifier==7)):      
	    a.specifier=a2.specifier	          
      elif((a1.specifier==6 or a1.specifier==7) and (a2.specifier==4 or a2.specifier==5)):      
	    a.specifier=a1.specifier	          
      a.type=a.specifier*100
      return a

def initAttr(dest):
      dest.id=None
      dest.type=0	
      dest.isArray=0		
      dest.ArrayLimit=0	
      dest.width=0
      
      dest.isPointer=0
      dest.qualifier=0
      dest.specifier=0
      dest.storage=0
      dest.scope=0
      dest.IntConstValue=0		
      dest.IntConst=0
      dest.FloatConstValue=0			
      dest.StringValue=None
      dest.isString=0
      dest.code=None		 
      dest.icode=None
      dest.offset=0			
      dest.numParameters=0
      
      dest.isFunction=0
      for i in range(MaxPar):      
	    dest.ParameterList[i]=None
      return dest

def PassSymEntry(a1):
      
      a = Attribute()      
      #print "Error Check: "+a1.id
      if(a1.id!=None):
	    #print "Error Check: a.id = a1.id"
	    a.id = a1.id	         
      else:      
	    a.id=None      
      a.type=a1.type
      a.isArray=a1.isArray
      a.ArrayLimit=a1.ArrayLimit
      a.isPointer=a1.isPointer
      a.scope=a1.scope
      a.isFunction=a1.isFunction
      a.isString=0
      a.offset=a1.offset
      a.numParameters=a1.numParameters
      a.code=None
      a.icode=None
      a.StringValue=None
      a.IntConstValue=0		
      a.IntConst=0
      a.specifier=0
      a.qualifier=0
      a.storage=0
      a.FloatConstValue=0
      #ParameterList
      for i in range(MaxPar):
	    if(a1.ParameterList[i]==None):      
		  break      
	    a.ParameterList[i]=a1.ParameterList[i]    	    
      #print "Error Check: "+a.id
      return a      

def PassAttribute(a1):      
      #print "\n Inside PassAttribute Method\n"
      i = 0
      a = Attribute()
      if a1.id != None:
	    a.id = a1.id
      else:
	    a.id = None
      
      a.type=a1.type
      a.isArray=a1.isArray
      a.ArrayLimit=a1.ArrayLimit
      a.width=a1.width
      a.isPointer=a1.isPointer
      a.qualifier=a1.qualifier
      a.specifier=a1.specifier
      a.storage=a1.storage
      a.scope=a1.scope
      a.IntConstValue=a1.IntConstValue
      a.IntConst=a1.IntConst
      a.FloatConstValue=a1.FloatConstValue
      a.isFunction=a1.isFunction
      a.isString=a1.isString
      a.offset=a1.offset
      a.numParameters=a1.numParameters
      if a1.StringValue != None:
	    a.StringValue = a1.StringValue
      else:
	    a.StringValue = None
      if ( a1.code != None ) and ( a1.icode != "" ):
	    a.code = a1.code
      else:
	    a.code = ""
      if (a1.icode != None) and (a1.icode != ""):
	    a.icode = a1.icode
      else:
	    a.icode = ""
      
      #ParameterList      
      for i in range(a1.numParameters):
	    if a1.ParameterList[i] == None:
		  break
	    a.ParameterList[i] = PassAttribute(a1.ParameterList[i])
      return a


def PrintAttribute(a):	
      #print "\nInside PrintAttribute method\n"
      if(a==None):      
	    print "Attribute is not defined Yet\n"      
      else:      	    
	    print "\nAttribute ID : "
	    if(a.id!=None):	    
		  print a.id	    
	    print ",Type :"+a.type+" ,isArray :"+a.isArray+" ,ArrayLimit :"+a.ArrayLimit+" ,width :"+a.width+" ,"
	    print "isPointer :"+a.isPointer+" ,qualifier :"+a.qualifier+" ,specifier :"+a.specifier+" ,storage :"+a.storage+" ,"
	    print "scope :"+a.scope+" ,IntConstValue :"+a.IntConstValue+" ,IntConst :"+a.IntConst+" ,FloatConstValue :"+a.FloatConstValue+" ,"
	    
	    if(a.StringValue!=None):	    
		  print "StringValue : "+a.StringValue+" ,"	    
	    print "isFunction : "+a.isFunction+" ,numParameters "+a.numParameters+" ,isString : "+a.isString+" ,offset : "+a.offset+" ,"
	    if(a.code!=None):	    
		  print "Code :\n "+a.code+" \n"	    
	    if(a.code!=None):	    
		  print "Intermediate Code :\n "+a.icode+" \n"	    
	    print " Parameters :"
	    for i in range(a.numParameters):	    	    
		  print "Parameter "+(i+1)+"\n"
		  if(a.ParameterList[i]==None):	    
			break	   
	    PrintAttribute(a.ParameterList[i])	    
	    print " Attribute Printed \n"
	    
def PrintSymEntry(a):
        #print "\nInside PrintSymEntry Method\n"
	if(a==None):	
	    print "SymEntry is not defined Yet\n"	
	else:		      
	      print "\nSymEntry ID : "
	      if(a.id!=None):	      
		    print a.id	      
	      print ",Type :"+a.type+" ,isArray :"+a.isArray+" ,ArrayLimit :"+a.ArrayLimit+" ,width :"+a.width+" ,"
	      print "isPointer :"+a.isPointer+" ,"
	      print "scope :"+a.scope+" ,"	      
	      print "isFunction : "+a.isFunction+" ,numParameters "+a.numParameters+" ,offset : "+a.offset+" ,"
	      print " Parameters :"
	      for i in range(a.numParameters):
		  if(a.ParameterList[i]==None):		  
			break		  
		  print "Parameter "+(i+1)+"\n"
		  PrintAttribute(a.ParameterList[i])	      
	      print " SymEntry Printed \n"	
	    	    
# main method #

import ply.yacc as yacc
yacc.yacc()
import sys

fcgFile.write("\t.data\n")
fcgFile.write("str:\n")
fcgFile.write(".asciiz \" : is answer \\n\"\n")
fcgFile.write(".text\n")
fcgFile.write(".globl main\n")

InitializeSymTable(-1)

try:
	f1 = open(sys.argv[1])
	yacc.parse(f1.read())
	#if success:
		#print 'Compilation Successful with No Error !!!'
except IOError:
	print 'Could not open file:',  sys.argv[1]

