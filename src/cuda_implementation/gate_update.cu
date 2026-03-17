#include <stdio.h>
#include <cuda_runtime.h>


// Cuda kernels to update gate values in Hodgkin-Huxley model

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

__global__ void potassium_activation(double voltage) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    double alph_n, beta_n;
    alph_n = 0.01 * (voltage + 55) / (1 - exp(-(voltage + 55) / 10));
    beta_n = 0.125 * exp(-(voltage + 65) / 80);
    double n_inf = (alph_n / (alph_n + beta_n));
  
    double tau_n = 1 / (alph_n + beta_n);
    
    // Need RK4 to update them 
}

__global__ void calcium_activation(double voltage) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    double alph_s, beta_s;
    alph_s = 0.1 * (voltage + 20) / (1 - exp(-(voltage + 20) / 10));
    beta_s = 0.5 * exp(-(voltage + 45) / 80);
    double s_inf = (alph_s / (alph_s + beta_s));
  
    double tau_s = 1 / (alph_s + beta_s);
    
    // Need RK4 to update them 

}

__global__ void a_type_potassium_activation(double voltage) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    double alph_a, beta_a;
    alph_a = 0.02 * (voltage + 13) / (1 - exp(-(voltage + 13) / 10));
    beta_a = 0.0175 * exp(-(voltage + 43) / 40);
    double a_inf = (alph_a / (alph_a + beta_a));
  
    double tau_a = 1 / (alph_a + beta_a);
    
    // Need RK4 to update them 
}

__global__ void a_type_potassium_inactivation(double voltage) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    double alph_b, beta_b;
    alph_b = 0.0016 * exp(-(voltage + 53) / 50);
    beta_b = 0.05 / (1 + exp(-(voltage + 23) / 10));
    double b_inf = (alph_b / (alph_b + beta_b));
  
    double tau_b = 1 / (alph_b + beta_b);
    
    // Need RK4 to update them 
}

__global__ void m_type_potassium_activation(double voltage) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    double alph_p, beta_p;
    alph_p = 0.0001 * (voltage + 30) / (1 - exp(-(voltage + 30) / 9));
    beta_p = 0.0001 * (voltage + 30) / (1 - exp(-(voltage + 30) / 9));
    double p_inf = (alph_p / (alph_p + beta_p));
  
    double tau_p = 1 / (alph_p + beta_p);
    
    // Need RK4 to update them 
}

int main() {
    double voltage = -65.0; // Example voltage
    sodium_activation<<<1, 1>>>(voltage);
    sodium_inactivation<<<1, 1>>>(voltage);
    potassium_activation<<<1, 1>>>(voltage);
    calcium_activation<<<1, 1>>>(voltage);
    a_type_potassium_activation<<<1, 1>>>(voltage);
    a_type_potassium_inactivation<<<1, 1>>>(voltage);
    m_type_potassium_activation<<<1, 1>>>(voltage);

    return 0;
}