# Extended Hodgkin–Huxley Neuron Model

**Author:** Swastic Keshari (https://github.com/SWASTIC-7)

---

## Introduction

The Hodgkin–Huxley (HH) model is  an electrical representation of a biological neuron (a conduction-based model).

Meanwhile Extended Hodgkin–Huxley (HH) model incoporates additional ionic currents, intracellular calcium dynamics, and synaptic or network coupling to gnereralise the model. 

> **Note:** All variable names and formulas will be referenced from this file to maintain consistency and generality. 



## Membrane Potential Dynamics

The neuronal membrane is modeled as a parallel combination of a capacitor and multiple ion-specific conductances.  
Applying Kirchhoff’s current law yields

$$
C_m \frac{dV_i}{dt}
=
I_{\text{ext}}
- I_{\text{ion}}^{(i)}
+ I_{\text{syn}}^{(i)}
+ I_{\text{coupling}}(V_i, \{V_j\})
$$

where  
$C_m$ is the membrane capacitance,  
$V_i$ is the membrane potential of neuron $i$,  
$I_{\text{ext}}$ is the externally applied current,  
$I_{\text{ion}}$ is the total ionic current,  
$I_{\text{syn}}$ represents synaptic input,  
$I_{\text{coupling}}$ represents electrical coupling with other neurons.

**For simple HH model the equation becomes**
$$
C_m \frac{dV_i}{dt}
=
I_{\text{ext}}
- I_{\text{ion}}^{(i)}
+ I_{\text{coupling}}(V_i, \{V_j\})
$$


## Conductance-Based Ionic Currents

Each ionic current obeys Ohm’s law:

$$
I_k = g_k P_k(V,t) (V - E_k)
$$

where  
$g_k$ is the maximal conductance,  
$E_k$ is the reversal potential,  
$P_k$ is the probability that the channel is open.

The total ionic current is expressed as

$$
I_{\text{ion}}
=
I_{\text{Na}} + I_{\text{K}} + I_{\text{L}}
+ I_{\text{Ca}} + I_{\text{A}} + I_{\text{M}}
$$

where:

- $I_{Na}$ — Fast sodium current
- $I_K$ — Delayed rectifier potassium current  
- $I_L$ — Leak current
- $I_{Ca}$ — Calcium current
- $I_A$ — A-type potassium current
- $I_M$ — M-type potassium current


**For Simple HH model we conside only Sodium and Potassium**
$$
I_{\text{ion}}
=
I_{\text{Na}} + I_{\text{K}}
$$


## Gating Variable Dynamics

Ion channel gating is modeled using first-order Markov kinetics.  
Each gate transitions between closed and open states:

$$
C \xrightleftharpoons[\beta_x(V)]{\alpha_x(V)} O
$$

Let $x(t)$ denote the open probability of the gate. The dynamics follow

$$
\frac{dx}{dt}
=
\alpha_x(V)(1 - x) - \beta_x(V)x
$$

This can be rewritten as

$$
\frac{dx}{dt}
=
\frac{x_\infty(V) - x}{\tau_x(V)}
$$

where

$$
x_\infty(V) = \frac{\alpha_x(V)}{\alpha_x(V) + \beta_x(V)},
\quad
\tau_x(V) = \frac{1}{\alpha_x(V) + \beta_x(V)}
$$

---

## Classical Hodgkin–Huxley Currents

### Sodium Current

$$
I_{\text{Na}} = g_{\text{Na}} m_i^3 h_i (V_i - E_{\text{Na}})
$$

**Where:**
- $I_{Na}$ — Sodium ionic current
- $g_{Na}$ — Maximum sodium conductance
- $m_i$ — Sodium activation gating variable
- $h_i$ — Sodium inactivation gating variable
- $V_i$ — Membrane potential of neuron \( i \)
- $E_{Na}$ — Sodium reversal (Nernst) potential

$$
\frac{dm_i}{dt} = \frac{m_\infty(V_i) - m_i}{\tau_m(V_i)}
$$

- $\ m_\infty(V_i)$ — Steady-state activation value
- $\ \tau_m(V_i)$ — Voltage-dependent time constant for $m_i$

**Rate Constants:**

$$
\alpha_m(V) = \frac{0.1(V + 40)}{1 - \exp\left(-\frac{V + 40}{10}\right)}
$$

$$
\beta_m(V) = 4\exp\left(-\frac{V + 65}{18}\right)
$$

where:
$$
m_\infty(V) = \frac{\alpha_m(V)}{\alpha_m(V) + \beta_m(V)}, \quad \tau_m(V) = \frac{1}{\alpha_m(V) + \beta_m(V)}
$$

$$
\frac{dh_i}{dt} = \frac{h_\infty(V_i) - h_i}{\tau_h(V_i)}
$$

- $ h_\infty(V_i) $ — Steady-state inactivation value
- $\tau_h(V_i)$ — Voltage-dependent time constant for $h_i$

**Rate Constants:**

$$
\alpha_h(V) = 0.07\exp\left(-\frac{V + 65}{20}\right)
$$

$$
\beta_h(V) = \frac{1}{1 + \exp\left(-\frac{V + 35}{10}\right)}
$$

where:
$$
h_\infty(V) = \frac{\alpha_h(V)}{\alpha_h(V) + \beta_h(V)}, \quad \tau_h(V) = \frac{1}{\alpha_h(V) + \beta_h(V)}
$$

---

### Potassium Current

$$
I_{\text{K}} = g_{\text{K}} n_i^4 (V_i - E_{\text{K}})
$$

**Where:**
- $I_{\text{K}}$ — Delayed rectifier potassium current
- $g_{\text{K}}$ — Maximum potassium conductance
- $n_i$ — Potassium activation gating variable
- $ E_{\text{K}}$ — Potassium reversal potential

$$
\frac{dn_i}{dt} = \frac{n_\infty(V_i) - n_i}{\tau_n(V_i)}
$$

- $n_\infty(V_i)$— Steady-state potassium activation
- $\tau_n(V_i)$— Voltage-dependent time constant for $n_i$

**Rate Constants:**

$$
\alpha_n(V) = \frac{0.01(V + 55)}{1 - \exp\left(-\frac{V + 55}{10}\right)}
$$

$$
\beta_n(V) = 0.125\exp\left(-\frac{V + 65}{80}\right)
$$

where:
$$
n_\infty(V) = \frac{\alpha_n(V)}{\alpha_n(V) + \beta_n(V)}, \quad \tau_n(V) = \frac{1}{\alpha_n(V) + \beta_n(V)}
$$

---

### Leak Current

$$
I_{\text{L}} = g_{\text{L}} (V_i - E_{\text{L}})
$$

**Where:**
- $I_{\text{L}}$ — Leak current
- $g_{\text{L}}$ — Leak conductance
- $E_{\text{L}}$ — Leak reversal potential

---

## Extended Ionic Currents

### Calcium Current

$$
I_{\text{Ca}} = g_{\text{Ca}} s_i^2 (V_i - E_{\text{Ca}})
$$

**Where:**
- $I_{\text{Ca}}$ — Voltage-gated calcium current
- $g_{\text{Ca}}$ — Maximum calcium conductance
- $s_i$ — Calcium activation gating variable
- $E_{\text{Ca}}$ — Calcium reversal potential

$$
\frac{ds_i}{dt} = \frac{s_\infty(V_i) - s_i}{\tau_s(V_i)}
$$

- $s_\infty(V_i)$ — Steady-state calcium activation
- $\tau_s(V_i)$ — Calcium channel time constant

**Rate Constants:**

$$
\alpha_s(V) = \frac{0.1(V + 20)}{1 - \exp\left(-\frac{V + 20}{10}\right)}
$$

$$
\beta_s(V) = 0.5\exp\left(-\frac{V + 45}{80}\right)
$$

where:
$$
s_\infty(V) = \frac{\alpha_s(V)}{\alpha_s(V) + \beta_s(V)}, \quad \tau_s(V) = \frac{1}{\alpha_s(V) + \beta_s(V)}
$$

---

### A-Type Potassium Current

$$
I_{\text{A}} = g_{\text{A}} a_i^3 b_i (V_i - E_{\text{K}})
$$

**Where:**
- $I_{\text{A}}$ — A-type (transient) potassium current
- $g_{\text{A}}$ — Maximum A-type conductance
- $a_i$ — Activation variable
- $b_i$ — Inactivation variable

$$
\frac{da_i}{dt} = \frac{a_\infty(V_i) - a_i}{\tau_a(V_i)}
$$

$$
\frac{db_i}{dt} = \frac{b_\infty(V_i) - b_i}{\tau_b(V_i)}
$$

- $a_\infty, b_\infty$ — Steady-state gating functions
- $\tau_a, \tau_b$ — Voltage-dependent time constants

**Rate Constants for Activation (a):**

$$
\alpha_a(V) = \frac{0.02(V + 13)}{1 - \exp\left(-\frac{V + 13}{10}\right)}
$$

$$
\beta_a(V) = 0.0175\exp\left(-\frac{V + 43}{40}\right)
$$

where:
$$
a_\infty(V) = \frac{\alpha_a(V)}{\alpha_a(V) + \beta_a(V)}, \quad \tau_a(V) = \frac{1}{\alpha_a(V) + \beta_a(V)}
$$

**Rate Constants for Inactivation (b):**

$$
\alpha_b(V) = 0.0016\exp\left(-\frac{V + 53}{50}\right)
$$

$$
\beta_b(V) = \frac{0.05}{1 + \exp\left(-\frac{V + 23}{10}\right)}
$$

where:
$$
b_\infty(V) = \frac{\alpha_b(V)}{\alpha_b(V) + \beta_b(V)}, \quad \tau_b(V) = \frac{1}{\alpha_b(V) + \beta_b(V)}
$$

---

### M-Type Potassium Current

$$
I_{\text{M}} = g_{\text{M}} p_i (V_i - E_{\text{K}})
$$

**Where:**
- $I_{\text{M}}$ — M-type (slow, non-inactivating) potassium current
- $g_{\text{M}}$ — Maximum M-type conductance
- $p_i$ — M-type activation variable

$$
\frac{dp_i}{dt} = \frac{p_\infty(V_i) - p_i}{\tau_p(V_i)}
$$

- $p_\infty(V_i)$ — Steady-state M-channel activation
- $\tau_p(V_i)$ — Slow activation time constant

**Rate Constants:**

$$
\alpha_p(V) = \frac{0.0001(V + 30)}{1 - \exp\left(-\frac{V + 30}{9}\right)}
$$

$$
\beta_p(V) = -\frac{0.0001(V + 30)}{1 - \exp\left(\frac{V + 30}{9}\right)}
$$

where:
$$
p_\infty(V) = \frac{\alpha_p(V)}{\alpha_p(V) + \beta_p(V)}, \quad \tau_p(V) = \frac{1}{\alpha_p(V) + \beta_p(V)}
$$

---

## Intracellular Calcium Dynamics

$$
\frac{d[\text{Ca}^{2+}]_i}{dt}
=
-\alpha I_{\text{Ca}}
-
\frac{[\text{Ca}^{2+}]_i - [\text{Ca}^{2+}]_{\text{rest}}}{\tau_{\text{Ca}}}
$$

**Where:**
- $[\text{Ca}^{2+}]_i$ — Intracellular calcium concentration
- $\alpha$ — Current-to-concentration conversion factor
- $[\text{Ca}^{2+}]_{\text{rest}}$ — Resting calcium concentration
- $\tau_{\text{Ca}}$ — Calcium removal (buffering/pumping) time constant

---

## Synaptic and Network Coupling

### Chemical Synapses

$$
I_{\text{syn}}^{(i)}
=
\sum_j g_{ij} s_{ij} (V_i - E_{\text{syn}})
$$

**Where:**
- $I_{\text{syn}}^{(i)}$ — Synaptic current into neuron $i$
- $g_{ij}$ — Synaptic conductance from neuron $j$ to $i$
- $s_{ij}$ — Synaptic gating variable
- $E_{\text{syn}}$ — Synaptic reversal potential

$$
\frac{ds_{ij}}{dt}
=
\alpha_s T_j (1 - s_{ij}) - \beta_s s_{ij}
$$

- $\alpha_s$ — Synaptic rise rate
- $\beta_s$ — Synaptic decay rate
- $T_j$ — Presynaptic spike indicator or neurotransmitter release function

---

### Electrical Coupling (Gap Junctions)

$$
I_{\text{coupling}}
=
\sum_j g_{ij} (V_j - V_i)
$$

**Where:**
- $I_{\text{coupling}}$ — Electrical coupling current
- $g_{ij}$ — Gap-junction conductance
- $V_j$ — Membrane potential of neighboring neuron \( j \)

---

## Complete Extended Hodgkin–Huxley Model

$$
\boxed{
\begin{aligned}
C_m \frac{dV_i}{dt} &=
I_{\text{ext}}
- \sum_k I_k
+ I_{\text{syn}}
+ I_{\text{coupling}}, \\[6pt]
\frac{dx_i}{dt} &=
\frac{x_\infty(V_i) - x_i}{\tau_x(V_i)},
\quad x \in \{m,h,n,s,a,b,p\}, \\[6pt]
\frac{d[\text{Ca}^{2+}]_i}{dt}
&=
-\alpha I_{\text{Ca}}
-
\frac{[\text{Ca}^{2+}]_i - [\text{Ca}^{2+}]_{\text{rest}}}{\tau_{\text{Ca}}}
\end{aligned}
}
$$
