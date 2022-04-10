#!/bin/bash

SCRIPT_DIR=$HOME/.local/bin/custom_emoji/

[ -z "$1" ] && "$SCRIPT_DIR/subscripts/run" || "$SCRIPT_DIR/subscripts/$@"
