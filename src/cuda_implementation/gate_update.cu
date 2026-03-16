#include <stdio.h>
#include <cuda_runtime.h>


// CUda kernel to update gate values in Hodgkin-Huxley model
__global__ void sodium_activation(double voltage) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    double alph_m, beta_m;
    alph_m = 0.1 * (voltage + 40) / (1 - exp(-(voltage + 40) / 10));
    beta_m = 4 * exp(-(voltage + 65) / 18);
    double m_inf = (alph_m / (alph_m + beta_m));
  
    double tau_m = 1 / (alph_m + beta_m);
    
    // Need RK4 to update them 
}

__global__ void sodium_inactivation(double voltage) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    double alph_h, beta_h;
    alph_h = 0.07 * exp(-(voltage + 65) / 20);
    beta_h = 1 / (1 + exp(-(voltage + 35) / 10));
    double h_inf = (alph_h / (alph_h + beta_h));
  
    double tau_h = 1 / (alph_h + beta_h);
    
    // Need RK4 to update them 
}

int main() {
    double voltage = -65.0; // Example voltage
    sodium_activation<<<1, 1>>>(voltage);
    sodium_inactivation<<<1, 1>>>(voltage);

    return 0;
}