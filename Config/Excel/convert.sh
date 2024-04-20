#! /bin/sh

EXCELDIR=`pwd`
CONFIGDIR="$EXCELDIR/.."
UTILSDIR="$CONFIGDIR/Utils"
CONVERT="$UTILSDIR/thriftify.py"

python3 $CONVERT --namespace Yoga.Config --thrift_protocol TJSONProtocol --gen_py ../Thrift/gen-py --output ../../config.bin --class_name "ConfigData"

