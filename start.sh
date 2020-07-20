#!/bin/bash
set -e

project_path="$HOME/ons";
session_name="ons";
window_number=1;

startProcess() {
  window_identity="$session_name:$window_number";
  application_path="$project_path/$1";
  tmux new-window -t $window_identity -n $1 "cd $application_path; $2; read";
  tmux split-window -h -t $window_identity;
  tmux send-keys -t "$window_identity.1" "cd $application_path" Enter
  window_number=$(($window_number + 1))
}

tmux new-session -d -s $session_name -t $session_name;

startProcess 'dp-compose' 'docker-compose up';
startProcess 'babbage' './run.sh';
startProcess 'zebedee' './run-reader-local.sh';
startProcess 'sixteens' './run.sh';
startProcess 'dp-frontend-router' 'make debug';
startProcess 'dp-frontend-renderer' 'make debug';
startProcess 'dp-frontend-dataset-controller' 'make debug';
startProcess 'dp-filter-api' 'make debug';
startProcess 'dp-dataset-api' 'make debug';
startProcess 'dp-frontend-filter-dataset-controller' 'make debug';
startProcess 'dp-frontend-geography-controller' 'make debug';
startProcess 'dp-code-list-api' 'make debug';
startProcess 'dp-hierarchy-api' 'make debug';
startProcess 'dp-search-api' 'make debug';
startProcess 'dp-frontend-cookie-controller' 'make debug';
startProcess 'dp-api-router' 'make debug';

tmux select-window -t $session_name:2;
tmux -2 attach-session -t $session_name;
