#! /bin/sh

EXCELDIR=`pwd`
CONFIGDIR="$EXCELDIR/.."
UTILSDIR="$CONFIGDIR/Utils"
CONVERT="$UTILSDIR/convert.py"

python3 $CONVERT Yoga.Config --thrift_protocol TJSONProtocol --gen_py ../Thrift/gen-py --output ../../config.bin --class_name "ConfigData"

