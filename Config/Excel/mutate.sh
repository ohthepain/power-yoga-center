#set -e

EXCELDIR=`pwd`
CONFIGDIR="$EXCELDIR/../.."
UTILSDIR="$EXCELDIR/../Utils"
MUTATE_PY="$UTILSDIR/mutate.py"

if [ -e Premutators ] ; then
  echo Pre-mutators ...
  python3 $MUTATE_PY Premutators --namespace Yoga.Config --thrift_protocol TJSONProtocol
fi


echo Mutators ...
#--gen_py ../Thrift/gen_py 
python3 $MUTATE_PY Mutators --namespace Yoga.Config --thrift_protocol TJSONProtocol


