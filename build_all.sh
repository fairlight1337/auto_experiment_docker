#!/bin/bash

cd auto_experiment_base
./build.sh
cd -

cd auto_experiment
./build.sh
cd -

cd experiments
./build_experiments.sh
cd -
