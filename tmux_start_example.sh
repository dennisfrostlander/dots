#!/bin/bash

SESSION="default"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]
then
  tmux new-session -d -s $SESSION

  tmux rename-window -t 0 "work"

  tmux new-window -t $SESSION:1 -n "cb"
  tmux send-keys -t "cb" "cd ~/projects/travelhub-client" C-m "e -u ~/travelhub.lua" C-m

  tmux new-window -t $SESSION:2 -n "client"
  tmux split-window -t client.0
  tmux split-window -h -t client.0

  tmux send-keys -t client.0 "cd ~/projects/travelhub-client/client" C-m "npm start" C-m
  tmux send-keys -t client.1 "cd ~/projects/travelhub-client/console" C-m "npm start" C-m

  tmux new-window -t $SESSION:3 -n "server"
  tmux split-window -t server.0
  tmux split-window -h -t server.0

  tmux send-keys -t server.0 "cd ~/projects/travelhub-client/backend" C-m "npm run watch" C-m
  tmux send-keys -t server.1 "cd ~/projects/travelhub-client/backend" C-m "npm start" C-m
fi

tmux attach-session -t $SESSION:0

