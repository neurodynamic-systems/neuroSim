# Runge-Kutta 4th Order Method (RK4)

**A Beginner's Guide to Numerical Integration**

---

## Introduction

The Runge-Kutta 4th order method (RK4) is a numerical technique for solving ordinary differential equations (ODEs). When simulating the Hodgkin-Huxley neuron model, we need to solve a system of coupled differential equations that describe how the membrane potential and gating variables change over time. Unlike simple algebraic equations, these differential equations often cannot be solved analytically, so we use numerical methods like RK4 to approximate the solution.

---

## The Problem: Solving Differential Equations

Consider a general first-order ordinary differential equation:

$$
\frac{dy}{dt} = f(t, y)
$$

where:
- $y$ is the variable we want to find (e.g., membrane potential $V$)
- $t$ is time
- $f(t, y)$ is a function that describes how $y$ changes with time

Given an initial condition $y(t_0) = y_0$, we want to find $y(t)$ for future times.

**Example from Hodgkin-Huxley:**

$$
\frac{dV}{dt} = \frac{1}{C_m}(I_{\text{ext}} - I_{\text{ion}} + I_{\text{coupling}})
$$

Here, $f(t, V) = \frac{1}{C_m}(I_{\text{ext}} - I_{\text{ion}} + I_{\text{coupling}})$

---

## Why Not Just Use Euler's Method?

The simplest numerical method is **Euler's method**:

$$
y_{n+1} = y_n + h \cdot f(t_n, y_n)
$$

where $h$ is the time step size.

**Problem:** Euler's method is only first-order accurate, meaning the error accumulates quickly. For stiff equations like the Hodgkin-Huxley model (where variables change rapidly), this leads to:
- Large errors
- Numerical instability
- Need for extremely small time steps (slow simulation)

**Solution:** Use higher-order methods like RK4 that provide better accuracy with larger time steps.

---

## The Runge-Kutta 4th Order Method

### Core Idea

Instead of using just the slope at the current point (like Euler's method), RK4 estimates the slope at four different points within the time step and takes a weighted average. This gives a much more accurate approximation of the true solution.

### The RK4 Formula

To advance from $y_n$ at time $t_n$ to $y_{n+1}$ at time $t_{n+1} = t_n + h$:

$$
\boxed{
\begin{aligned}
k_1 &= h \cdot f(t_n, y_n) \\[6pt]
k_2 &= h \cdot f\left(t_n + \frac{h}{2}, y_n + \frac{k_1}{2}\right) \\[6pt]
k_3 &= h \cdot f\left(t_n + \frac{h}{2}, y_n + \frac{k_2}{2}\right) \\[6pt]
k_4 &= h \cdot f(t_n + h, y_n + k_3) \\[6pt]
y_{n+1} &= y_n + \frac{1}{6}(k_1 + 2k_2 + 2k_3 + k_4)
\end{aligned}
}
$$

### What Do These Terms Mean?

- **$k_1$**: Slope at the beginning of the interval
  - Uses the current state $y_n$ at time $t_n$
  
- **$k_2$**: Slope at the midpoint, using $k_1$ to estimate $y$ at the midpoint
  - Takes a half-step forward using $k_1$
  
- **$k_3$**: Slope at the midpoint again, but using $k_2$ for the estimate
  - Takes a half-step forward using $k_2$ (better estimate than $k_1$)
  
- **$k_4$**: Slope at the end of the interval, using $k_3$
  - Takes a full step forward using $k_3$

- **Final Update**: Weighted average giving more importance to the midpoint slopes
  - $k_1$ and $k_4$ each get weight $\frac{1}{6}$
  - $k_2$ and $k_3$ each get weight $\frac{2}{6} = \frac{1}{3}$

---

## Visual Intuition

Think of it like getting directions to a destination:

1. **$k_1$**: Check the slope where you are now
2. **$k_2$**: Walk halfway using $k_1$'s direction, check the slope there
3. **$k_3$**: Return to start, walk halfway using $k_2$'s direction, check the slope there
4. **$k_4$**: Return to start, walk all the way using $k_3$'s direction, check the slope there
5. **Final step**: Use all four slope estimates to make the best possible step

By sampling the slope at multiple points, RK4 captures the curvature of the solution much better than a single-slope method.

---

## Application to the Hodgkin-Huxley Model

The Hodgkin-Huxley model is a **system** of coupled ODEs:

$$
\begin{aligned}
\frac{dV}{dt} &= f_V(V, m, h, n) \\[4pt]
\frac{dm}{dt} &= f_m(V, m) \\[4pt]
\frac{dh}{dt} &= f_h(V, h) \\[4pt]
\frac{dn}{dt} &= f_n(V, n)
\end{aligned}
$$

### RK4 for Systems of Equations

We apply RK4 to **all** variables simultaneously:

**Step 1:** Compute $k_1$ for all variables
$$
\begin{aligned}
k_{1,V} &= h \cdot f_V(V_n, m_n, h_n, n_n) \\
k_{1,m} &= h \cdot f_m(V_n, m_n) \\
k_{1,h} &= h \cdot f_h(V_n, h_n) \\
k_{1,n} &= h \cdot f_n(V_n, n_n)
\end{aligned}
$$

**Step 2:** Compute $k_2$ for all variables
$$
\begin{aligned}
k_{2,V} &= h \cdot f_V\left(V_n + \frac{k_{1,V}}{2}, m_n + \frac{k_{1,m}}{2}, h_n + \frac{k_{1,h}}{2}, n_n + \frac{k_{1,n}}{2}\right) \\
k_{2,m} &= h \cdot f_m\left(V_n + \frac{k_{1,V}}{2}, m_n + \frac{k_{1,m}}{2}\right) \\
k_{2,h} &= h \cdot f_h\left(V_n + \frac{k_{1,V}}{2}, h_n + \frac{k_{1,h}}{2}\right) \\
k_{2,n} &= h \cdot f_n\left(V_n + \frac{k_{1,V}}{2}, n_n + \frac{k_{1,n}}{2}\right)
\end{aligned}
$$

**Step 3:** Compute $k_3$ for all variables
$$
\begin{aligned}
k_{3,V} &= h \cdot f_V\left(V_n + \frac{k_{2,V}}{2}, m_n + \frac{k_{2,m}}{2}, h_n + \frac{k_{2,h}}{2}, n_n + \frac{k_{2,n}}{2}\right) \\
k_{3,m} &= h \cdot f_m\left(V_n + \frac{k_{2,V}}{2}, m_n + \frac{k_{2,m}}{2}\right) \\
k_{3,h} &= h \cdot f_h\left(V_n + \frac{k_{2,V}}{2}, h_n + \frac{k_{2,h}}{2}\right) \\
k_{3,n} &= h \cdot f_n\left(V_n + \frac{k_{2,V}}{2}, n_n + \frac{k_{2,n}}{2}\right)
\end{aligned}
$$

**Step 4:** Compute $k_4$ for all variables
$$
\begin{aligned}
k_{4,V} &= h \cdot f_V(V_n + k_{3,V}, m_n + k_{3,m}, h_n + k_{3,h}, n_n + k_{3,n}) \\
k_{4,m} &= h \cdot f_m(V_n + k_{3,V}, m_n + k_{3,m}) \\
k_{4,h} &= h \cdot f_h(V_n + k_{3,V}, h_n + k_{3,h}) \\
k_{4,n} &= h \cdot f_n(V_n + k_{3,V}, n_n + k_{3,n})
\end{aligned}
$$

**Step 5:** Update all variables
$$
\begin{aligned}
V_{n+1} &= V_n + \frac{1}{6}(k_{1,V} + 2k_{2,V} + 2k_{3,V} + k_{4,V}) \\
m_{n+1} &= m_n + \frac{1}{6}(k_{1,m} + 2k_{2,m} + 2k_{3,m} + k_{4,m}) \\
h_{n+1} &= h_n + \frac{1}{6}(k_{1,h} + 2k_{2,h} + 2k_{3,h} + k_{4,h}) \\
n_{n+1} &= n_n + \frac{1}{6}(k_{1,n} + 2k_{2,n} + 2k_{3,n} + k_{4,n})
\end{aligned}
$$

---

## Compact Vector Notation

For a system of equations, we can write RK4 more compactly using vector notation.

Let $\mathbf{y} = [V, m, h, n]^T$ and $\mathbf{f}(\mathbf{y}) = [f_V, f_m, f_h, f_n]^T$

Then:

$$
\boxed{
\begin{aligned}
\mathbf{k}_1 &= h \cdot \mathbf{f}(\mathbf{y}_n) \\[6pt]
\mathbf{k}_2 &= h \cdot \mathbf{f}\left(\mathbf{y}_n + \frac{\mathbf{k}_1}{2}\right) \\[6pt]
\mathbf{k}_3 &= h \cdot \mathbf{f}\left(\mathbf{y}_n + \frac{\mathbf{k}_2}{2}\right) \\[6pt]
\mathbf{k}_4 &= h \cdot \mathbf{f}(\mathbf{y}_n + \mathbf{k}_3) \\[6pt]
\mathbf{y}_{n+1} &= \mathbf{y}_n + \frac{1}{6}(\mathbf{k}_1 + 2\mathbf{k}_2 + 2\mathbf{k}_3 + \mathbf{k}_4)
\end{aligned}
}
$$

---

## Algorithm Pseudocode

```
Given: Initial state y₀, time step h, total time T
Output: Solution y(t) at discrete time points

1. Initialize: t = 0, y = y₀
2. While t < T:
   a. Compute k₁ = h * f(t, y)
   b. Compute k₂ = h * f(t + h/2, y + k₁/2)
   c. Compute k₃ = h * f(t + h/2, y + k₂/2)
   d. Compute k₄ = h * f(t + h, y + k₃)
   e. Update: y = y + (k₁ + 2k₂ + 2k₃ + k₄)/6
   f. Advance time: t = t + h
   g. Store y(t)
3. Return solution
```

---

## Key Properties of RK4

### Accuracy

- **Local truncation error**: $O(h^5)$ — error in a single step scales as $h^5$
- **Global error**: $O(h^4)$ — accumulated error over many steps scales as $h^4$
- This is much better than Euler's method which has $O(h^2)$ global error

### Stability

RK4 has good stability properties for a wide range of problems, including:
- Mildly stiff systems
- Oscillatory solutions
- Nonlinear dynamics

For the Hodgkin-Huxley model, typical time steps are:
- $h = 0.01$ ms to $h = 0.05$ ms provide good accuracy
- Smaller steps needed for very stiff coupling or high-frequency dynamics

### Computational Cost

- **4 function evaluations per time step** (compared to 1 for Euler's method)
- But can use much larger time steps with better accuracy
- Overall: more efficient than lower-order methods

---

## Choosing the Time Step

The time step $h$ must be chosen carefully:

**Too large:**
- Loss of accuracy
- May miss rapid dynamics
- Potential numerical instability

**Too small:**
- Unnecessary computation
- Accumulation of round-off errors
- Slower simulation

**Rule of thumb for HH neurons:**
- Start with $h = 0.01$ ms
- Check convergence by halving $h$ and comparing results
- If results don't change significantly, $h$ is acceptable

**Adaptive methods** (not covered here) automatically adjust $h$ based on estimated error.

---

## Why RK4 for GPU Implementation?

RK4 is particularly well-suited for GPU-accelerated simulations:

1. **Parallelizable**: Each neuron's state can be updated independently in parallel
2. **Fixed time step**: All neurons advance with the same $h$, simplifying synchronization
3. **No branching**: The algorithm has no conditional statements that would cause thread divergence
4. **Memory-efficient**: Only needs to store current state and intermediate $k$ values
5. **Deterministic**: Same initial conditions always produce the same results

---

## Example: Single Time Step

Consider a simple ODE: $\frac{dy}{dt} = -y$, with $y(0) = 1$ and $h = 0.1$

**Analytical solution:** $y(0.1) = e^{-0.1} \approx 0.904837$

**RK4 solution:**

$$
\begin{aligned}
k_1 &= 0.1 \times (-1.0) = -0.1 \\
k_2 &= 0.1 \times (-(1.0 - 0.05)) = -0.095 \\
k_3 &= 0.1 \times (-(1.0 - 0.0475)) = -0.09525 \\
k_4 &= 0.1 \times (-(1.0 - 0.09525)) = -0.090475 \\
y(0.1) &= 1.0 + \frac{1}{6}(-0.1 - 0.19 - 0.1905 - 0.090475) \\
&= 1.0 - 0.095162 \\
&= 0.904838
\end{aligned}
$$

**Error:** $|0.904838 - 0.904837| = 0.000001$ — excellent accuracy!

---

## Summary

The Runge-Kutta 4th order method is the workhorse of numerical integration for neuron simulations because it:

✓ Provides high accuracy with reasonable time steps  
✓ Remains stable for the stiff, nonlinear HH equations  
✓ Maps naturally to parallel GPU architectures  
✓ Balances computational cost and precision effectively  

Understanding RK4 is essential for implementing and optimizing large-scale neural network simulations on GPUs.

---

## Further Reading

- Press, W. H., et al. (2007). *Numerical Recipes: The Art of Scientific Computing* (3rd ed.). Cambridge University Press.
- Butcher, J. C. (2016). *Numerical Methods for Ordinary Differential Equations* (3rd ed.). Wiley.
- Dayan, P., & Abbott, L. F. (2001). *Theoretical Neuroscience*. MIT Press.
