#! /bin/sh

EXCELDIR=`pwd`
CONFIGDIR="$EXCELDIR/.."
UTILSDIR="$CONFIGDIR/Utils"
CONVERT="xl2thrift"

$CONVERT --namespace Yoga.Config --thrift_protocol TJSONProtocol --gen_py ../Thrift/gen-py --output ../../config.bin --class_name "ConfigData"

