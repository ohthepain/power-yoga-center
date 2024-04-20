#set -e

EXCELDIR=`pwd`
CONFIGDIR="$EXCELDIR/.."
UTILSDIR="$CONFIGDIR/Utils"
MUTATE_PY="$UTILSDIR/mutate.py"

if [ -e Premutators ] ; then
  echo Pre-mutators ...
  python3 $MUTATE_PY Premutators Yoga.Config --thrift_protocol TJSONProtocol
fi


echo Mutators ...
python3 $MUTATE_PY Mutators --gen_py ../Thrift/gen_py --namespace Yoga.Config --thrift_protocol TJSONProtocol


