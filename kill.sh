tmux kill-session -t ons
docker-compose -f ~/ons/dp-compose/docker-compose.yml stop
pkill -9 vault
