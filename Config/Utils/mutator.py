def applyMutator(path, data):
	Module = importlib.import_module(path, package='mutator')
	spec = importlib.util.spec_from_file_location("mutator", path)
	foo = importlib.util.module_from_spec(spec)
	spec.loader.exec_module(foo)
	
	print("applyMutator " + path)
	members = [attr for attr in dir(Data) if not callable(getattr(Data, attr)) and not attr.startswith("__")]
	print "Data members: "
	print members


def mutate(data):
	print("Hi from SessionPoses mutator")
	print("Square brackets are a list!")

	for root, dirs, files in os.walk("../Mutators"):
		for file_ in files:
			if file_[:2] != "~$" and file_.lower().endswith(".py"):
				applyMutator(os.path.join(root, file_), data)

import sys, os
import importlib
import thrift
from thrift.transport import TTransport
from thrift.protocol import TJSONProtocol
from thrift.Thrift import TType
from openpyxl import Workbook
from openpyxl import load_workbook

sys.path.append("../Excel")
import Mutators
Mutators = importlib.import_module('Mutators')
from Mutators import *
print dir(Mutators)

import types
print([getattr(Mutators, a) for a in dir(Mutators)
	   if isinstance(getattr(Mutators, a), types.FunctionType)])

sys.path.append("../Thrift/gen-py")
sys.path.append("../Thrift/gen-py/Yoga")
ThriftModule = importlib.import_module('Yoga.Config.ttypes')
ThriftConstants = importlib.import_module('Yoga.Config.constants')
Data = ThriftModule.Data()

print (Data)

with open("../../config.bin", 'rb') as f:
	buf = f.read()
	f.close()

transport = TTransport.TMemoryBuffer(buf)
ThriftProtocol = getattr(importlib.import_module('thrift.protocol.TJSONProtocol'), 'TJSONProtocol')
protocol = ThriftProtocol(transport)

Data = ThriftModule.Data()
#transport.setvalue(buf)
Data.read(protocol)

mutate(Data)

# Temp mutator logic - move PoseEntries into Sessions
sessions = {}
for session in Data.sessions:
	sessions[session.sessionId] = session

for poseEntry in Data.poses:
	print poseEntry.sessionId
	session = sessions[poseEntry.sessionId]
	print "-->" + session.sessionId
	if session.poses == None:
		print "create session.poses"
		session.poses = []
	session.poses.append(poseEntry)
Data.poses = None

transport = TTransport.TMemoryBuffer()
protocol = ThriftProtocol(transport)
Data.write(protocol)

buf = transport.getvalue()
with open("../../config2.bin", 'wb') as f:
	f.write(buf)
