#! /usr/bin/env python

import sys, os
import importlib
import thrift
from thrift.transport import TTransport
from thrift.protocol import TCompactProtocol
from thrift.Thrift import TType

sys.path.append("../Thrift/gen-py")
sys.path.append("../Thrift/gen-py/Yoga")
ThriftModule = importlib.import_module('Yoga.Config.ttypes')
ThriftConstants = importlib.import_module('Yoga.Config.constants')

with open("config.bin", 'rb') as f:
	buf = f.read()

ThriftProtocol = getattr(importlib.import_module('thrift.protocol.TCompactProtocol'), 'TCompactProtocol')
transport = TTransport.TMemoryBuffer(buf)
protocol = ThriftProtocol(transport)
Data = ThriftModule.Data()
Data.read(protocol)

print("Data2:")
print(Data)
print("eosData2:")

