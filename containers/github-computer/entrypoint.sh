# Start services
~/.config/scripts/startup.sh

# Start vnc access
# ~/.config/scripts/vnc.sh

http-server --port 8022 . &

# Start localtunnel agent
~/.yarn/bin/lt --host http://github-computer.app --print-requests --port 8022

sleep infinity
