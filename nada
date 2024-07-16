#!/bin/bash

# Create a new Nada project
mkdir quickstart
cd quickstart
nada init nada_quickstart_programs

# Set up a Python virtual environment and install nada-dsl
python3 -m venv .venv
source .venv/bin/activate
pip install nada-dsl

# Write your first Nada program
touch src/secret_addition.py
echo "from nada_dsl import *

def nada_main():

    party1 = Party(name=\"Party1\")

    my_int1 = SecretInteger(Input(name=\"my_int1\", party=party1))

    my_int2 = SecretInteger(Input(name=\"my_int2\", party=party1))

    new_int = my_int1 + my_int2

    return [Output(new_int, \"my_output\", party1)]

" > src/secret_addition.py

# Compile, run, and test your Nada program
nada build
nada run secret_addition_test
nada test secret_addition_test
