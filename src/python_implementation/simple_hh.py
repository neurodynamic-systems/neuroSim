# implementation of simple Hodkin-Huxley neuron model
# for references to variables and equations see: Extended_HH.md

import numpy as np
import matplotlib.pyplot as plt

C_m = 1.0       # membrane capacitance (uF/cm^2)
g_Na = 120.0    # max sodium conductance (mS/cm^2)
g_K  = 36.0     # max potassium conductance (mS/cm^2)
g_L  = 0.3      # leak conductance (mS/cm^2)

E_Na = 50.0     # sodium reversal potential (mV)
E_K  = -77.0    # potassium reversal potential (mV)
E_L  = -54.387  # leak reversal potential (mV)

def alpha_m(V):
    return 0.1 * (V + 40) / (1 - np.exp(-(V + 40) / 10))

def beta_m(V):
    return 4.0 * np.exp(-(V + 65) / 18)

def alpha_h(V):
    return 0.07 * np.exp(-(V + 65) / 20)

def beta_h(V):
    return 1.0 / (1 + np.exp(-(V + 35) / 10))

def alpha_n(V):
    return 0.01 * (V + 55) / (1 - np.exp(-(V + 55) / 10))

def beta_n(V):
    return 0.125 * np.exp(-(V + 65) / 80)

def I_ion(V, m, h, n):
    """
    Total ionic current:
    I = I_Na + I_K + I_L
    """
    I_Na = g_Na * m**3 * h * (V - E_Na)
    I_K  = g_K  * n**4       * (V - E_K)
    I_L  = g_L               * (V - E_L)
    return I_Na + I_K + I_L

def HH_derivative_Equations(state, I_ext):
    """
    state = [V, m, h, n]
    """
    V, m, h, n = state

    dVdt = (I_ext - I_ion(V, m, h, n)) / C_m
    dmdt = alpha_m(V)*(1 - m) - beta_m(V)*m
    dhdt = alpha_h(V)*(1 - h) - beta_h(V)*h
    dndt = alpha_n(V)*(1 - n) - beta_n(V)*n

    return np.array([dVdt, dmdt, dhdt, dndt])


