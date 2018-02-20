apt update && apt upgrade -y &&
apt install -y python-pip python-dev libffi-dev git &&
pip install ansible &&
sleepy=($[( $RANDOM % 10 )+1])
sleep $sleepy
ansible-pull -U https://github.com/skandertajine/rabbitmq-cluster localhost.yaml