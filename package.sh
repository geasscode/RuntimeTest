#!/bin/bash -l
fir build_ipa . -w -S RuntimeTest && \
fir p fir_build/RuntimeTest-1.0-build-1.ipa -T b668e48c86ec4baf052b4a37899f4eb2
