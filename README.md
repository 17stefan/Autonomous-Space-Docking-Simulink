# Autonomous-Space-Docking-Simulink
An autonomous MATLAB/Simulink simulation of a spacecraft performing a high-stakes docking maneuver and planetary landing. Built using Simscape Multibody, the project features custom gravitational physics, logic-based docking triggers, and predictive trajectory guidance.

Part 1: Environment & Gravitational Dynamics
This section details the setup of the gravitational singularity, the planetary dynamics, and the physical properties of the bodies involved.

1. Central Gravity (The Singularity)
To simulate the attraction of a black hole, a custom central gravity field was implemented:
    External Force and Torque: Used to create a central point-mass attraction.
    Vector Logic: Forces are directed toward the origin (0,0,0) of the world frame.
    Drift Physics: Both the spacecraft and capsule drift toward the singularity, requiring active thrust to maintain a stable docking trajectory.
  
3. Planet Rotation and Stability
The planet acts as the final target with specific rotational and orbital logic:
    Revolute Joint: Connects the planet to the world frame to allow for spin.
    Constant Velocity: Joint actuation is set to Provided by Input, receiving a steady signal for continuous rotation.
    Fixed Orbit: The planet is fixed to the world frame to represent a stable orbital equilibrium, providing a consistent landing target.

3. Mixed Physics: CAD Import vs. Native Geometry
    Capsule (CAD Import): The only component imported via a .STEP file. Physical properties (mass, center of mass, inertia) are pulled directly from the geometry via the smiData structure.
    Native Geometry: The spacecraft and planet are modeled using standard Simscape Solid blocks with manually defined mass properties.
    Solver: The ode15s solver was selected to handle the stiff equations resulting from high gravitational pull and rigid body interactions.

Part 2: Docking Logic & Relative Propulsion
Describes how the capsule identifies the ship's position and the logic used to "lock" them together mid-flight.

1. Relative Distance via 6-DOF Joint
     Data Extraction: Position signals are pulled directly from the 6-DOF Joint.
     Logic: Coordinates are fed into a Subtract block to determine the gap.
     Trigger: A comparison block initiates docking once the distance is less than 5 meters.

2. Autonomous Capsule Propulsion
     Active Hunter: During the approach, only the capsule is equipped with active thrusters.
     Navigation: The capsule closes the gap toward the passive ship until it enters the 5-meter docking zone.

3. The Docking Trigger (Locking)
     Mode Switching: The condition signal is sent to a Weld Joint to change its state.
     Hard Dock: A -1 signal is sent to the joint's mode port, instantly "welding" all degrees of freedom.
  

Part 3: Navigation & Planetary Landing
The final stage focuses on the guidance system required to land on a moving planet.

1. Real-Time Data Acquisition
     I used Transform Sensors to track state vectors (Position and Velocity) for both the docked assembly and the planet center.

2. Trajectory Prediction Logic
To ensure a successful intercept, I implemented a prediction algorithm:
     Kinematic Differential Equations: Instead of chasing the planet’s current location, the system forecasts its future position.
     Integration: By integrating constant linear and angular velocity, the model calculates the intercept point by the time the ship arrives.

3. Intercept Calculation
     Time-to-Intercept ($t_{min}$): Estimates the minimum time to close the gap based on approach speed.
     Directional Vector: Generates a Directional Unit Vector toward the predicted "meeting point," providing a precise heading for thrusters.

4. Automatic Landing Termination
     Surface Detection: Monitors the distance magnitude relative to the planet's 30-meter radius.
     Stop Condition: A logic gate triggers once distance $\leq 30$ meters.
     Mission Success: Triggers a Stop Simulation block to freeze the engine at the moment of touchdown.
