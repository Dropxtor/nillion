#!/bin/bash

# Install nilup, the Nillion SDK tool installer and version manager
curl https://nilup.nilogy.xyz/install.sh | bash

# Confirm global nilup tool installation
nilup -V

# Use nilup to install the latest version of the Nillion SDK
nilup install latest
nilup use latest
nilup init

# Optionally enable nilup telemetry, providing your Ethereum wallet address
# nilup instrumentation enable --wallet <your-eth-wallet-address>

# Confirm global Nillion tool installation
nillion -V

# List of Nillion SDK tools available globally
echo "Nillion SDK tools:"
echo "nilup: a tool to install the Nillion SDK and manage Nillion SDK versions."
echo "nillion: a cli-based Nillion Client and tool for interacting with the Nillion Network from the command line."
echo "nillion-devnet: a tool that allows you to spin up and interact with a local test Nillion network."
echo "node-key2peerid: a tool that creates a peer id from your node key."
echo "nada: a tool to manage Nada projects (create project, compile, run, and test programs, generate tests, etc.)."
echo "nada-run: a tool that executes programs against a stripped down version of a Nillion devnet."
echo "pynadac: a tool that compiles Nada programs; pynadac takes an input program defined in Nada and produces a compiled version of it ready to be run with nada-run or stored on the Nillion Network."

# Provide command structure and example usage for Nillion SDK tools
echo "Command structure:"
echo "<tool> [options] <command>"
echo ""
echo "For example, to generate a user key using the nillion command, run:"
echo "nillion user-key-gen user.key"
echo ""
echo "To get full usage details including a comprehensive list of global commands and options available for a specific tool, run:"
echo "<tool> --help"
echo ""
echo "For example, to view the available commands for the nada tool, run:"
echo "nada --help"

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
