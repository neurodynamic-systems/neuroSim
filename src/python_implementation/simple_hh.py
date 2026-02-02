# implementation of simple Hodkin-Huxley neuron model


import numpy as np
import matplotlib.pyplot as plt

C_membrane = 1.0       # membrane capacitance (uF/cm^2)
G_Na = 120.0    # max sodium conductance (mS/cm^2)
G_K  = 36.0     # max potassium conductance (mS/cm^2)
G_L  = 0.3      # leak conductance (mS/cm^2)

E_Na = 50.0     # sodium reversal potential (mV)
E_K  = -77.0    # potassium reversal potential (mV)
E_L  = -54.387  # leak reversal potential (mV)