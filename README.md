# Digital Implementation of Feedback Linearization and Simple Linearization for a Van der Pol System

This repository contains the source code, simulations, and documentation for the digital implementation of control strategies applied to a Van der Pol oscillator. [cite_start]The project compares **Feedback Linearization** and **Simple Linearization** techniques to stabilize the system's limit cycles[cite: 1, 7].

## 📄 Project Overview

[cite_start]The Van der Pol oscillator is a non-linear system known for self-sustaining oscillations (limit cycles)[cite: 14]. [cite_start]This project models the oscillator using an analog electronic circuit and implements digital control algorithms using **LabVIEW** and **National Instruments Data Acquisition (NI DAQ)** hardware[cite: 9, 16].

[cite_start]The primary objective is to control the system efficiently, minimizing steady-state error and maximum overshoot[cite: 17].

## ⚙️ System Description

[cite_start]The system is governed by the Van der Pol differential equation[cite: 21]:

$$
\frac{d^{2}x}{dt^{2}} - \mu(1-x^{2})\frac{dx}{dt} + x = 0
$$

[cite_start]In state-space representation, where $x_1$ is position and $x_2$ is velocity[cite: 26, 102]:

$$
\begin{cases}
\dot{x}_{1} = x_{2} \\
\dot{x}_{2} = -kx_{1} + c(1-x_{1}^{2})x_{2} + u
\end{cases}
$$

**System Parameters used in this study:**
* [cite_start]$k = 1$ [cite: 32]
* [cite_start]$c = 0.1$ (determines non-linearity) [cite: 32]
* [cite_start]$u$: Control signal [cite: 31]

## 🎛️ Control Algorithms

This project implements and compares two distinct control strategies.

### 1. Simple Linearization
[cite_start]This method approximates the non-linear system to a linear one around the equilibrium point $(0,0)$ using Taylor series expansion[cite: 96, 151].

* **Logic:** Jacobian linearization.
* **Implemented Control Law:**
    $$u = 1 - 5(x_{1}-1) - 5x_{2}$$
    [cite_start]*(Derived assuming gains $k_1 = -5, k_2 = -5$)*[cite: 136].

### 2. Feedback Linearization
[cite_start]This method transforms the non-linear system into a linear system via non-linear feedback cancellation[cite: 97].

* **Logic:** Defines a new input $v$ to cancel non-linear terms.
* **Implemented Control Law:**
    $$u = -9(x_{1}-1) - 3x_{2} + x_{1} - 0.1(1-x_{1}^{2})x_{2}$$
    [cite_start]*(Derived using PD control on the linearized system)*[cite: 240].

## 🔌 Hardware Implementation

[cite_start]The Van der Pol oscillator is physically modeled using an analog circuit[cite: 8, 75].

### [cite_start]Components List[cite: 78, 80]:
* **Operational Amplifiers:** LM741 (Integrators and Summers)
* **Multipliers:** AD633 (For non-linear $x^2$ terms)
* **Resistors:** $1M\Omega$ (main integrators), $130\Omega$, $1.2k\Omega$, etc.
* **Capacitors:** $1\mu F$

### Circuit Diagram
*(Ensure your repo contains the schematic image, e.g., in an `images/` folder)*
![Circuit Diagram](path/to/circuit_diagram_image.png)

## 💻 Software & Tools

* [cite_start]**Proteus:** Used for circuit simulation and open-loop validation[cite: 47].
* [cite_start]**MATLAB/Simulink:** Used for algorithm design, stability analysis, and simulation[cite: 138].
* [cite_start]**LabVIEW:** Used for real-time digital control implementation[cite: 248].
* [cite_start]**NI-DAQ:** Interface for reading states $x_1, x_2$ and outputting control $u$[cite: 248].

## 📊 Results & Performance

Both controllers successfully stabilized the system. [cite_start]However, **Feedback Linearization** proved to be more robust and faster[cite: 345].

| Performance Metric | Feedback Linearization | Simple Linearization |
| :--- | :--- | :--- |
| **Settling Time** | 1.2 s | 2.5 s |
| **Overshoot** | 5% | 15% |
| **Steady State Error** | 0.01 | 0.05 |
[cite_start]*(Data based on Table I of the project report)* [cite: 344]



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

* [cite_start]**Leandro Llontop Herrera** - *Universidad Nacional de Ingeniería* [cite: 2]
* [cite_start]**Juan Contreras Avendaño** - *Universidad Nacional de Ingeniería* [cite: 3]
* [cite_start]**Jordan Delgado Gutierrez** - *Universidad Nacional de Ingeniería* [cite: 5]
* [cite_start]**Carlos Felipe Sebastián Aldave Torres** - *Universidad Nacional de Ingeniería* [cite: 6]

## 📚 References

1.  V. Sundarapandian, "Output Regulation of Van der Pol Oscillator," *IE(1) Journal-EL*, vol. [cite_start]88, pp. 20-27, Dec. 2007. [cite: 371]
2.  J.-J. [cite_start]E. Slotine and W. Li, *Applied Nonlinear Control*, Prentice-Hall, 1991. [cite: 372]
3.  [cite_start]A. Isidori, *Nonlinear Control Systems*, Springer Science & Business Media, 1995. [cite: 375]
