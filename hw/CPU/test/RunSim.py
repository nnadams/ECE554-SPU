import subprocess
import argparse
import difflib

modelsim_file_loc = "./loadfile.img"
java_file_loc = "../../../sw/CPU_Simulator/bin/loadfile.img"
java_root = "../../../sw/CPU_Simulator"

java_reg_file = java_root + "/bin/reg_dump.sim"
java_mem_file = java_root + "/bin/mem_dump.sim"
modelsim_reg_file = "./reg_dump.dmp"
modelsim_mem_file = "./mem_dmp.dmp"

def LoadProgram(f):
	print "Loading Program " + str(f)
	prog = open(f, 'r')
	java_prog = open(java_file_loc, 'w')
	modelsim_prog = open(modelsim_file_loc, 'w')
	lines = prog.readlines()
	java_prog.writelines(lines)
	modelsim_prog.writelines(lines)
	print "Program Loaded!"

def WaitForModelSim():
	raw_input("Run Modelsim Simulation now. Press enter when complete...")

def RunJavaSimulator():
	print "Compiling Java Simulator"
	cmd = "javac src/* -d bin/"
	subprocess.call(cmd, cwd=java_root)
	print "Running Java Simulator"
	cmd = "java Simulator"
	subprocess.call(cmd, cwd=(java_root + "/bin"))
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
parser.add_argument('--program', dest='program', help="ASM program to simulate", required=True)

args = parser.parse_args()

LoadProgram(args.program)
WaitForModelSim()
RunJavaSimulator()
DiffFiles()
