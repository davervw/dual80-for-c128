#!/bin/sh -x
export ACME=${USERPROFILE}/Downloads/acme0.97win/acme
export VICE=${USERPROFILE}/Downloads/GTK3VICE-3.8-win64/bin
export PROG=80dual
${ACME}/acme -f cbm -o ${PROG}.prg -l ${PROG}.lbl -r ${PROG}.lst ${PROG}.asm \
&& ${VICE}/c1541 ${PROG}.d64 -attach ${PROG}.d64 8 -delete "${PROG}" -write ${PROG}.prg "${PROG}" \
&& ${VICE}/x128 -moncommands ${PROG}.lbl -autostart ${PROG}.d64 >/dev/null 2>&1 &