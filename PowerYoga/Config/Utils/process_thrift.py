#! /usr/bin/env python

# power yoga version

#cd "$UTILS"; ./convert_excel.py -namespace "DF.Config" -output "$DATAOUT/PartialData.bin" -tprotocol TBinaryProtocol

import sys, os
import argparse
#from openpyxl import Workbook
import importlib
import excel_utils
import thrift
from thrift.transport import TTransport
#import collection

print "howdy"

parser = argparse.ArgumentParser(description="process some spreadsheets")
parser.add_argument('-protocol', default='TCompactProtocol', nargs='?', help='thrift protocol')
parser.add_argument('-namespace', default='DF.Config', nargs='?', help='thrift namespace')
parser.add_argument('-output', nargs='?', help='path to dest folder')
args = parser.parse_args()

print "args.namespace", args.namespace
print "args.output", args.output
print "args.protocol", args.protocol

reload(sys)
sys.setdefaultencoding('utf8')

thrift = importlib.import_module('thrift')
print thrift

sys.path.append("../Thrift/gen-py/Yoga")
ThriftModule = importlib.import_module('Config')
print ThriftModule
#ThriftModule = importlib.import_module('Document/constants.py')
#ThriftModule = importlib.import_module('Document/ttypes.py')
#ThriftProtocol = getattr(ThriftModule)

#ThriftProtocol = getattr(importlib.import_module('thrift.protocol.%s' % args.protocol), args.protocol)
#ThriftModule = importlib.import_module('%s.ttypes' % args.namespace)
#ThriftConstants = importlib.import_module('Config.constants')
#ThriftConstants = importlib.import_module('%s.constants' % args.namespace)
#ThriftType = getattr(ThriftModule, args.type)
