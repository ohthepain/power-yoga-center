import sys, os
import importlib
import thrift
from thrift.transport import TTransport
from thrift.Thrift import TType
import argparse

parser = argparse.ArgumentParser(description='Apply mutators to config file')
parser.add_argument('mutators_folder', help='folder containing mutator scripts', choices=('Premutators', 'Mutators'))
parser.add_argument('--namespace', help='namespace from thrift file')
parser.add_argument('--config_subfolder', default='')
parser.add_argument('--thrift_protocol', choices=('TCompactProtocol', 'TJSONProtocol', 'TBinaryProtocol'), default='TJSONProtocol')
parser.add_argument('--verbose')

def Log(s):
	if args.verbose:
	 	print(s)

try:
    args = parser.parse_args()
except IOError as msg:
    parser.error(str(msg))

sys.path.append('../Thrift/%s/gen-py' % args.config_subfolder)
ConfigModule = importlib.import_module('%s.ttypes' % (args.namespace))

def mutate(data):
	for modulename in dir (MutatorModule):
		if modulename[:2] != "__":
			module = getattr(MutatorModule, modulename)
			if '__mutators' in dir(module):
				for function in module.__mutators:
					result = function(data)

sys.path.append("../Excel")
from Premutators import *
from Mutators import *
MutatorModule = importlib.import_module(args.mutators_folder)

import types

configPath = '../../config.bin'
with open(configPath, 'rb') as f:
	buf = f.read()
	f.close()

transport = TTransport.TMemoryBuffer(buf)
ThriftProtocol = getattr(importlib.import_module("thrift.protocol.%s" % (args.thrift_protocol)), args.thrift_protocol)
protocol = ThriftProtocol(transport)
Data = ConfigModule.ConfigData()
Data.read(protocol)

mutate(Data)

transport = TTransport.TMemoryBuffer()
protocol = ThriftProtocol(transport)
Data.write(protocol)
buf = transport.getvalue()
with open(configPath, 'wb') as f:
	f.write(buf)
	f.close()
