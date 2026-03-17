#include <stdio.h>
#include <cuda_runtime.h>

// Cuda kernels to update ion channel values in Hodgkin-Huxley model

__global__ void sodium(double voltage, double activation, double inactivation, double conductance, double reversal_potential) {
    
    double sodium_current = conductance * (activation * activation * activation) * inactivation * (voltage - reversal_potential);
        
}

__global__ void potassium(double voltage, double activation, double conductance, double reversal_potential) {
    
    double potassium_current = conductance * (activation * activation * activation* activation) * (voltage - reversal_potential);
        
}

__global__ void calcium(double voltage, double activation, double conductance, double reversal_potential) {
    
    double calcium_current = conductance * (activation * activation) * (voltage - reversal_potential);
        
}

__global__ void a_type_potassium(double voltage, double activation, double inactivation, double conductance, double reversal_potential) {
    
    double a_type_potassium_current = conductance * (activation * activation * activation) * inactivation * (voltage - reversal_potential);
        
}

__global__ void m_type_potassium(double voltage, double activation, double conductance, double reversal_potential) {
    
    double m_type_potassium_current = conductance * activation * (voltage - reversal_potential);
        
}

int main() {
    double voltage = -65.0; // Example voltage
    sodium<<<1, 1>>>(voltage, 0.5, 0.5, 120.0, 50.0);
    potassium<<<1, 1>>>(voltage, 0.5, 36.0, -77.0);
    calcium<<<1, 1>>>(voltage, 0.5, 10.0, 120.0);
    a_type_potassium<<<1, 1>>>(voltage, 0.5, 0.5, 10.0, -80.0);
    m_type_potassium<<<1, 1>>>(voltage, 0.5, 20.0, -80.0);
    
    return 0;
}