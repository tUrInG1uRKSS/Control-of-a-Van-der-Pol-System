# Digital Implementation of Feedback Linearization and Simple Linearization for a Van der Pol System

This repository contains the source code, simulations, and documentation for the digital implementation of control strategies applied to a Van der Pol oscillator. The project compares **Feedback Linearization** and **Simple Linearization** techniques to stabilize the system's limit cycles.

## 📄 Project Overview

The Van der Pol oscillator is a non-linear system known for self-sustaining oscillations (limit cycles). This project models the oscillator using an analog electronic circuit and implements digital control algorithms using **LabVIEW** and **National Instruments Data Acquisition (NI DAQ)** hardware.

The primary objective is to control the system efficiently, minimizing steady-state error and maximum overshoot.
![IMG_20240627_153843](https://github.com/user-attachments/assets/373dd4e5-8ed5-4a47-96e4-95b7cfbbf2ca)


## ⚙️ System Description

The system is governed by the Van der Pol differential equation:

$$
\frac{d^{2}x}{dt^{2}} - \mu(1-x^{2})\frac{dx}{dt} + x = 0
$$

In state-space representation, where $$x_1$$ is position and $$x_2$$ is velocity:

$$
\begin{cases}
\dot{x}_{1} = x_{2} \\
\dot{x}_{2} = -kx_{1} + c(1-x_{1}^{2})x_{2} + u
\end{cases}
$$

**System Parameters used in this study:**
* $$k = 1$$ 
* $$c = 0.1$$ (determines non-linearity)
* $$u$$: Control signal

## 🎛️ Control Algorithms

This project implements and compares two distinct control strategies.

### 1. Simple Linearization
This method approximates the non-linear system to a linear one around the equilibrium point $(0,0)$ using Taylor series expansion.

* **Logic:** Jacobian linearization.
* **Implemented Control Law:**
    $$u = 1 - 5(x_{1}-1) - 5x_{2}$$
  
    *(Derived assuming gains $$k_1 = -5, k_2 = -5$$ )*.

### 2. Feedback Linearization
This method transforms the non-linear system into a linear system via non-linear feedback cancellation.

* **Logic:** Defines a new input $$v$$ to cancel non-linear terms.
* **Implemented Control Law:**
    $$u = -9(x_{1}-1) - 3x_{2} + x_{1} - 0.1(1-x_{1}^{2})x_{2}$$
    *(Derived using PD control on the linearized system)*.

## 🔌 Hardware Implementation

The Van der Pol oscillator is physically modeled using an analog circuit.

### Components List:
* **Operational Amplifiers:** LM741 (Integrators and Summers)
* **Multipliers:** AD633 (For non-linear $$x^2$$ terms)
* **Resistors:** $$1M\Omega$$ (main integrators), $$130\Omega$$, $$1.2k\Omega$$, etc.
* **Capacitors:** $$1\mu F$$

### Circuit Diagram
<img width="1232" height="751" alt="image" src="https://github.com/user-attachments/assets/582b292a-9f32-40d5-9590-ec979df95299" />


## 💻 Software & Tools

* **Proteus:** Used for circuit simulation and open-loop validation.
* **MATLAB/Simulink:** Used for algorithm design, stability analysis, and simulation.
* **LabVIEW:** Used for real-time digital control implementation.
* **NI-DAQ:** Interface for reading states $$x_1, x_2$$ and outputting control $$u$$.

## 📊 Results & Performance

Both controllers successfully stabilized the system. However, **Feedback Linearization** proved to be more robust and faster.

| Performance Metric | Feedback Linearization | Simple Linearization |
| :--- | :--- | :--- |
| **Settling Time** | 1.2 s | 2.5 s |
| **Overshoot** | 5% | 15% |
| **Steady State Error** | 0.01 | 0.05 |

*(Data based on Table I of the project report)*

## 🚀 How to Run

1.  **Simulation:**
    * Open the MATLAB scripts in `src/matlab/` to view the phase portraits and step responses.
    * Open the Proteus project in `src/proteus/` to see the circuit behavior.
2.  **Implementation:**
    * Connect the NI-DAQ to the analog circuit as shown in the schematics.
    * Open `Main_Control.vi` in LabVIEW.
    * Select the appropriate COM port/Channel for the DAQ.
    * Run the VI to start the control loop.

## 👥 Authors

* **Leandro Llontop Herrera** - *Universidad Nacional de Ingeniería* 
* **Juan Contreras Avendaño** - *Universidad Nacional de Ingeniería* 
* **Jordan Delgado Gutierrez** - *Universidad Nacional de Ingeniería* 
* **Carlos Felipe Sebastián Aldave Torres** - *Universidad Nacional de Ingeniería*

## 📚 References

1.  V. Sundarapandian, "Output Regulation of Van der Pol Oscillator," *IE(1) Journal-EL*, vol. 88, pp. 20-27, Dec. 2007.
2.  J.-J. E. Slotine and W. Li, *Applied Nonlinear Control*, Prentice-Hall, 1991. 
3.  A. Isidori, *Nonlinear Control Systems*, Springer Science & Business Media, 1995. 
