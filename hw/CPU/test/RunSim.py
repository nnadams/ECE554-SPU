import subprocess
import argparse
import difflib
import os 

modelsim_imem = "imem.sim"
modelsim_dmem = "dmem.sim"
java_imem = os.path.abspath("../../../sw/CPU_Simulator/bin/imem.sim")
java_dmem = os.path.abspath("../../../sw/CPU_Simulator/bin/dmem.sim")
java_root = os.path.abspath("../../../sw/CPU_Simulator")

java_reg_file = java_root + "/bin/reg_dump.sim"
java_mem_file = java_root + "/bin/mem_dump.sim"
modelsim_reg_file = "./reg_dump.dmp"
modelsim_mem_file = "./mem_dmp.dmp"

def LoadProgram(i, d):
	print "Loading Program " + str(i)
	prog = open(i, 'r')
	data = open(d, 'r')
	java_prog = open(java_imem, 'w')
	modelsim_prog = open(modelsim_imem, 'w')
	lines = prog.readlines()
	java_prog.writelines(lines)
	modelsim_prog.writelines(lines)
	java_mem = open(java_dmem, 'w')
	modelsim_mem = open(modelsim_dmem, 'w')
	lines = data.readlines()
	java_mem.writelines(lines)
	modelsim_mem.writelines(lines)
	print "Program Loaded!"

def WaitForModelSim():
	raw_input("Run Modelsim Simulation now. Press enter when complete...")

def RunJavaSimulator():
	print "Compiling Java Simulator"
	cmd = "javac -d bin/ src/*"
	print cmd 
	print java_root
	subprocess.call(cmd, cwd=java_root, shell=True)
	print "Running Java Simulator"
	cmd = "java Simulator"
	subprocess.call(cmd, cwd=(java_root + "/bin"), shell=True)
	print "Java Simulation Done!"

def DiffFiles():
	print "Comparing Register Results"
	diff = difflib.unified_diff(open(java_reg_file).readlines(), open(modelsim_reg_file).readlines())
	try:
		while 1:
			print diff.next(),
	except:
		pass

	print "Comparing Memory Results"

	diff = difflib.unified_diff(open(java_mem_file).readlines(), open(modelsim_mem_file).readlines())
	
	try:
		while 1:
			print diff.next(),
	except:
		pass

	print "Done!"

parser = argparse.ArgumentParser(description="Compares Java Simulator output with modelsim output.")
parser.add_argument('--imem', dest='imem', help="Instruction Memory", required=True)
parser.add_argument('--dmem', dest='dmem', help="Data memory", required=True)

args = parser.parse_args()

LoadProgram(args.imem, args.dmem)
WaitForModelSim()
RunJavaSimulator()
DiffFiles()
