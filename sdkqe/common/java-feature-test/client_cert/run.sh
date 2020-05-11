#!/bin/bash

(cd cert && ./gen_keystore.sh cb_entry_point)
(cd lib && ./build_jar.sh)
(cd src && ./run.sh)
