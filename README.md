## simAOCS

This repository contains a 6 DoF simulator of a satellite by modelling:
- Sensors, with random noise, bias and sampling frequency:
    - Gyroscope
    - Magnetometer
    - Star Tracker
    - GNSS receiver
    - Reaction wheel encoder
- Actuators, with saturations:
    - Reaction Wheels
    - Magnetorquers
    - RCS thrusters
- Non linear plant dynamics:
    - Translational motion propagated in ECI frame
    - Rotational motion propagated in Body frame w.r.t ECI (quaternion based)
    - Variable mass and inertia tensor
    - (Simplified) aerodynamic force
    - Random torque perturbations
- Environmental models:
    - 4th degree zonal harmonic gravity model
    - World Magnetic Model 2025 (WMM)
    - NRLMSISE-00 atmospheric model with solar flux and geomagnetic index inputs

A basic GNC design is also implemented, based on detumbling, desaturation and pointing control modes.

The inputs are declared in a script, which is preprocessed in the *sim_prepro.m* function prior to simulation.

Postpros for logged state, sensors, actuators, GNC, navigation and control signals are present in the *postpro/* folder, also including a 3D ground track plotting function

Single shot (not Monte Carlo campaings) are supported via the *sim_singleShot.m* script, which requires the previous execution of *sim_main.m* in order to load the simulator. The results storing is handled automatically.

The simulator requires several toolbox and blocksets.

**DISCLAIMER: This simulator is intended for educational purposes, and no guarantees regarding the modelling or GNC design and performance are provided**