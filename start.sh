#!/bin/bash

# Launch the virtual display server Xvfb when starting the container.
Xvfb :0 -screen 0 1920x1080x24+32 &

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
