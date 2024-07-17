#!/bin/bash

# Install Nada Numpy
pip install nada-ai

# Initialize project structure
nada init nada-mlp

# Define Multi-Layer Perceptron Model
cat << EOF > src/main.py
import nada_numpy as na
from nada_ai import nn

class MyNN(nn.Module):
    """My simple neural net"""

    def __init__(self) -> None:
        """Model is a two layers and an activations"""
        self.linear_0 = nn.Linear(8, 4)
        self.linear_1 = nn.Linear(4, 2)
        self.relu = nn.ReLU()

    def forward(self, x: na.NadaArray) -> na.NadaArray:
        """My forward pass logic"""
        x = self.linear_0(x)
        x = self.relu(x)
        x = self.linear_1(x)
        return x

def nada_main():
    # Step 1: We use Nada Numpy wrapper to create "Provider" and "User"
    user = Party(name="User")
    provider = Party(name="Provider")

    # Step 2: Instantiate model object
    my_model = MyNN()

    # Step 3: Load model weights from Nillion network by passing model name (acts as ID)
    # In this example, Provider provides the model and User runs inference
    my_model.load_state_from_network("my_nn", provider, na.SecretRational)

    # Step 4: Load input data to be used for inference (provided by User)
    my_input = na.array((8,), user, "my_input", na.SecretRational)

    # Step 5: Compute inference
    # Note: completely equivalent to `my_model.forward(...)`
    result = my_model(my_input)

    # Step 6: We can use result.output() to produce the output for User and variable name "my_output"
    return result.output(user, "my_output")

EOF

# Compile, run, and test your Nada program
nada build
nada run my_nn_test
nada test my_nn_test
