usage() { echo "Usage: $0 -n <number_of_clamd_instances>" 1>&2; exit 1; }

while getopts ":n:" options; do
    case "${options}" in
        n)
            n="${OPTARG}"
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z ${n} ]; then
    usage
else
    CLAMD_INSTANCES="$n"
fi

echo "Creating ${CLAMD_INSTANCES} clamd instances"

read -t 10 -p "Hit ENTER or wait ten seconds"; echo

docker-compose -f docker-compose.yaml up --scale clamd=$CLAMD_INSTANCES
