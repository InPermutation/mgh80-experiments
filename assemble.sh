#!/bin/bash
set -ex

FILE="${1:-main.s}"

./vasmz80_oldstyle -L a.list -chklabels -wfail -x -Fbin -Fihex -dotdir $FILE
