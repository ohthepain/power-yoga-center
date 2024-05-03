#set -e

EXCELDIR=`pwd`
CONFIGDIR="$EXCELDIR/../.."
UTILSDIR="$EXCELDIR/../Utils"

if [ -e Premutators ] ; then
  echo Pre-mutators ...
  mutate --mutators_folder Premutators --namespace Yoga.Config --gen_py ../Thrift/gen-py --thrift_protocol TJSONProtocol --class_name ConfigData --input_path ../../config.bin --output_path ../../config.bin
fi

echo Mutators ...
mutate --mutators_folder Mutators --namespace Yoga.Config --gen_py ../Thrift/gen-py --thrift_protocol TJSONProtocol --class_name ConfigData --input_path ../../config.bin --output_path ../../config.bin
