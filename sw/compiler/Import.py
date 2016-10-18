MaxTypeLen = 100
HashSize = 4
MaxPar = 10
MaxFunctionLength  = 500
#typeSpecifier 

Int = 0
Char = 1
Float = 2
Double = 3
Long = 4
Void = 5

num_temporaries = 0
num_labels = 0

class SymEntry:
      global MaxPar
      def __init__(self):
            self.id = ""
            self.scope = 0
            self.type = 0
            self.keywordval = 0 
            self.linenum = 0
            self.isPointer = 0
            self.isArray = 0
            self.ArrayLimit = 0
            self.isFunction = 0
            self.offset = 0
            self.width = 0
            self.numParameters = 0
            self.ParameterList = [None]*MaxPar
	    
            for i in range(MaxPar):
                  self.ParameterList[i] = Attribute()
		#append(temp)   
            self.next = None



class Attribute:
      global MaxPar
      def __init__(self):
            #self.type = ""
            self.id = ""
            self.type = 0
            self.isArray = 0    
            self.ArrayLimit = 0 # upper limit of array (valid if DIMENSION is true)
            self.width = 0
            self.isPointer = 0
            self.qualifier = 0
            self.specifier = 0
            self.storage = 0
            self.scope = 0      
            self.IntConstValue = 0     
            self.IntConst = 0
            self.FloatConstValue = 0.0  # to store the value of double or float      
            self.StringValue = ""
            self.isFunction = 0
            self.numParameters = 0
            self.isString = 0
            self.offset = 0
            self.code = ""
            self.icode = ""
            self.ParameterList = [None]*MaxPar

class VALUE:
      def __init__(self):
            self.intValue = 0
            self.longIntValue = 0
            self.floatValue = 0.0
            self.doubleValue = 0.0
            self.charValue = ""
            self.string = ""


class SymTableNode:
      global HashSize
      def __init__(self):
            self.scope = 0
            self.name = ""
            self.table = []
            for i in range(HashSize):
                  temp = SymEntry()
                  self.table.append(temp) 
            self.next = None

# global name used in other places
global1 = []
for i in range(2):
      temp = SymTableNode()
      global1.append(temp) 

tail = []
for i in range(2):
      temp = SymTableNode()
      tail.append(temp) 

def CreateNewScopeTableNode():
      global HashSize
      t = ScopeTableNode()
      t.scope = 0
      t.next = None
      for i in range(HashSize):
            t.table[i] = None
      return t


def CreateNewSymTableNode():
      global HashSize
      t = SymTableNode()
      t.scope = 0
      t.next = None
      for i in range(HashSize):
            t.table[i] = None
      return t

def lookup(name, FuncName):
      #print "Inside lookup function"
      global HashSize
      global global1      
      r = SymEntry()
      s = SymEntry()
       
      r = None        
      temp = SymTableNode()
      if name != None:
            
            k = ord(name[0])%HashSize
            for a in range(FuncName+1):
                  temp = global1[a]
                  while temp.next != None:
                        s = temp.table[k]
                        if s!= None:
                              if s.id == name:
                                    r = s
                              else:
                                    while s.next != None:
                                          s = s.next
                                          if s.id == name:
                                                r = s
                                                break
                        temp = temp.next
                  s = temp.table[k]                     
                  if s!=None:
                        if s.id == name:
                              r = s
                        else:
                              while s.next != None:
                                    s = s.next
                                    if s.id == name:
                                          r = s
                                          break      

      
      return r


def InsertSymTable(name,currentScope,typ,FuncName):
      global HashSize
      global tail      
      if tail[FuncName].scope!=currentScope:
           
            temp = SymTableNode()
            temp = CreateNewSymTableNode()
            temp.scope = currentScope
            tail[FuncName].next=temp
            tail[FuncName]=temp
      
      p = SymEntry()
      p.id = name
      p.scope=tail[FuncName].scope
      p.type = typ
      p.next=tail[FuncName].table[ord(name[0])%HashSize]
      tail[FuncName].table[ord(name[0])%HashSize]=p
      return p

def initAttr(dest):
      #print "\nInside initAttr(dest) Method\n"
      dest.id=None
      dest.type=0	
      dest.isArray=0		# True if variable is array
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
      dest.offset=0			#0 means not
      dest.numParameters=0
      dest.isFunction=0
      for i in range(MaxPar):      
	    dest.ParameterList[i]=None
      return dest


def InitializeSymTable(KEYWORD):
      global MaxPar
      global tail
      global global1
      counter=0
      global1[0]=CreateNewSymTableNode()
      tail[0]=global1[0]
      global1[1]=CreateNewSymTableNode()
      tail[1]=global1[1]
      
      global1[0].name = "Global"
      p = SymEntry()    
	  
      p = InsertSymTable("break",0,KEYWORD,0)
      #p.keywordval=BREAK
      p=InsertSymTable("case",0,KEYWORD,0)
      #p.keywordval=CASE
      p=InsertSymTable("char",0,KEYWORD,0)
      #p.keywordval=CHAR
      p=InsertSymTable("continue",0,KEYWORD,0)
      #p.keywordval=CONTINUE
      p=InsertSymTable("default",0,KEYWORD,0)
      #p.keywordval=DEFAULT
      p=InsertSymTable("do",0,KEYWORD,0)
      #p.keywordval=DO
      p=InsertSymTable("else",0,KEYWORD,0)
      #p.keywordval=ELSE
      p=InsertSymTable("float",0,KEYWORD,0)
      #p.keywordval=FLOAT
      p=InsertSymTable("for",0,KEYWORD,0)
      #p.keywordval=FOR
      p=InsertSymTable("if",0,KEYWORD,0)
      #p.keywordval=IF
      p=InsertSymTable("int",0,KEYWORD,0)
      #p.keywordval=INT
      p=InsertSymTable("register",0,KEYWORD,0)
      #p.keywordval=REGISTER
      p=InsertSymTable("return",0,KEYWORD,0)
      #p.keywordval=RETURN
      p=InsertSymTable("switch",0,KEYWORD,0)
      #p.keywordval=SWITCH
      p=InsertSymTable("void",0,KEYWORD,0)
      #p.keywordval=VOID
      p=InsertSymTable("while",0,KEYWORD,0)
      #p.keywordval=WHILE
      p=InsertSymTable("print_t",0,KEYWORD,0)
      p.keywordval=0
      p.isFunction=1
      p.linenum=0
      p.type=400
      p.scope=0                                      
      p.keywordval=0    #INT , etc.
      p.isPointer=0
      p.isArray=0
      p.ArrayLimit=0      
      p.offset=-1
      p.width=0
      p.numParameters=1
      p.ParameterList[0] = initAttr(p.ParameterList[0])
      p.ParameterList[0].type=400

      for counter in  range(MaxPar):
            p.ParameterList[counter]=None

def PrintAttribute(a):	
      #print "\nInside PrintAttribute method\n"
      if(a==None):      
	    print "Attribute is not defined Yet\n"      
      else:      	    
	    print "\nAttribute ID : "
	    if(a.id!=None):	    
		  print a.id	    
	    print ",Type :"+str(a.type)+" ,isArray :"+str(a.isArray)+" ,ArrayLimit :"+str(a.ArrayLimit)+" ,width :"+str(a.width)+" ,"
	    print "isPointer :"+str(a.isPointer)+" ,qualifier :"+str(a.qualifier)+" ,specifier :"+str(a.specifier)+" ,storage :"+str(a.storage)+" ,"
	    print "scope :"+str(a.scope)+" ,IntConstValue :"+str(a.IntConstValue)+" ,IntConst :"+str(a.IntConst)+" ,FloatConstValue :"+str(a.FloatConstValue)+" ,"
	    
	    if(a.StringValue!=None):	    
		  print "StringValue : "+str(a.StringValue)+" ,"	    
	    print "isFunction : "+str(a.isFunction)+" ,numParameters "+str(a.numParameters)+" ,isString : "+str(a.isString)+" ,offset : "+str(a.offset)+" ,"
	    if(a.code!=None):	    
		  print "Code :\n "+str(a.code)+" \n"	    
	    if(a.code!=None):	    
		  print "Intermediate Code :\n "+str(a.icode)+" \n"	    
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
	      print ",Type :"+str(a.type)+" ,isArray :"+str(a.isArray)+" ,ArrayLimit :"+str(a.ArrayLimit)+" ,width :"+str(a.width)+" ,"
	      print "isPointer :"+str(a.isPointer)+" ,"
	      print "scope :"+str(a.scope)+" ,"	      
	      print "isFunction : "+str(a.isFunction)+" ,numParameters "+str(a.numParameters)+" ,offset : "+str(a.offset)+" ,"
	      print " Parameters :"
	      for i in range(a.numParameters):
		  if(a.ParameterList[i]==None):		  
			break		  
		  print "Parameter "+str(i+1)+"\n"
		  PrintAttribute(a.ParameterList[i])	      
	      print " SymEntry Printed \n"	


def PrintSymTable():
      global HashSize
      global global1
      print "\nPrinting Symbol Table :\n"
      s = SymEntry();
      temp = SymTableNode()
      i = 0
      k = 0     
      for k in range(2):        
            print "\nLooking in Function Node ",k,"\n"
            temp = global1[k]
            while temp.next != None:
                  print "\nLooking in Node %d\n",temp.scope              
                  for i in range(HashSize):
                        s = temp.table[i]
                        if s!= None:
                              PrintSymEntry(s)
                              while s.next != None:
                                    s = s.next
                                    PrintSymEntry(s)
                       
                  temp=temp.next
            print "\nLooking in Node ",temp.scope,"\n"
            for i in  range(HashSize):
                  s = temp.table[i]
                  if s!= None:
                        PrintSymEntry(s)
                        while s.next != None:
                              s = s.next
                              PrintSymEntry(s)
     

def PopSym(FuncName):		# takes function name and reduces scope. Becomes tailing function, and it's next is none.
      global global1
      global tail
      
      temp=global1[FuncName]
      while temp.next.next != None:
            temp = temp.next
      temp.next = None
      
      tail[FuncName]=temp
   
def getNewTemp():
      global num_temporaries
      
      temp = "_T00"
      temp1 = "_T"
      

      temp2 = str(num_temporaries / 10)
      temp3 = str(num_temporaries % 10)
      temp = temp1 + temp2 + temp3
      num_temporaries = num_temporaries + 1
      return temp
'''      
      num_temporaries=num_temporaries+1
      return "$labeltemp%d" % num_temporaries   
'''
      
def getNewLabel():
      global num_labels
     
      temp = "_L00"
      temp1 = "_L"
      

      temp2 = str(num_labels / 10)
      temp3 = str(num_labels % 10)
      temp = temp1 + temp2 + temp3
      num_labels = num_labels + 1
      return temp
'''
      num_labels=num_labels+1
      return "$label%d" % num_labels
'''

def replicate(str1):
      if str1!= None:
            temp = str1
      else:
            temp = ""
      
      return temp
      
      
def append(str1, str2):
        return str1 + str2


def gen(instr, reg, addr):
      buf = addr
      t = instr + " " + reg + "," + buf
      return t

def toAddr(offset):
      # global num_labels      
      if offset < 100 :
            temp = "---($sp)"
            
            temp1 = str(offset / 10)      
            temp2 = str(offset % 10)
            temp = "-"+temp1+temp2+"($sp)"
            return temp
      else:
            temp = "----($sp)"
            
            temp1 = str(offset / 100)
            temp2 = str((offset % 100) / 10)
            temp3 = str(offset % 10)
            return "-"+ temp1 + temp2 + temp3 + "($sp)"

