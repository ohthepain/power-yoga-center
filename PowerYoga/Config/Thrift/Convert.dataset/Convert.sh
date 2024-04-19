echo "Hello from $0"
echo "Hello from `basename $0`"

BASE=`pwd`
CONFIGDIR="$BASE/.."
UTILS=../Utils
DATADIR=$BASE/../Data
CONVERT="$UTILS/process_thrift.py"
cd "$UTILS"
echo "pwd is `pwd`"

rm -rf $DATADIR
mkdir $DATADIR

ls "$CONFIGDIR"

$CONVERT -namespace "Yoga.Config" -output "$DATAOUT/PartialData.bin" -protocol TBinaryProtocol

cd "$BASE"
echo "pwd is `pwd`"
#./convert_excel.py -output "$DATA/Data.bin" -tprotocol TBinaryProtocol


#cd "$UTILS"; ./convert_excel.py -namespace "DF.Config" -output "$DATAOUT/PartialData.bin" -tprotocol TBinaryProtocol

