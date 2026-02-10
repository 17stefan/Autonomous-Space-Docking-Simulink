# Autonomous-Space-Docking-Simulink
Autonomous Space Docking &amp; Planetary Landing simulation in MATLAB/Simulink. Features Interstellar-inspired black hole gravity, S-R Flip-Flop docking logic, and predictive trajectory navigation using Simscape Multibody.

Part 1: Environment and Gravitational Dynamics (Updated)This section details the setup of the gravitational singularity, the planetary dynamics, and the physical properties of the bodies involved, noting that the capsule is the only component imported from CAD software.
1. Central Gravity (The Singularity)To simulate the attraction of a black hole, a custom central gravity field was implemented.A central point-mass attraction was created using an External Force and Torque block.The logic calculates a force vector directed toward the origin $(0,0,0)$ of the world frame.This forces both the spacecraft and the capsule to drift toward the singularity, requiring active thrust to maintain a stable trajectory for docking.
2.  Planet Rotation and StabilityThe planet acts as the final target and is configured with specific rotational and orbital logic.The planet is connected to the world frame via a Revolute Joint to allow for spin.The joint is set to Provided by Input, receiving a constant velocity signal to maintain steady rotation throughout the simulation.The planet is not subject to the central gravity force; it is fixed to the world frame.This setup represents a planet already in a stable orbital equilibrium, providing a consistent landing target for the spacecraft.

3. Mixed Physics: CAD Import vs. Native GeometryThe simulation combines imported CAD data for the capsule with native Simscape shapes for the other components.Capsule (CAD Import): The capsule is the only body imported as a .STEP file.Its physical properties—mass, center of mass, and inertia tensors—are pulled directly from the geometry via the smiData structure.Spacecraft and Planet (Native): These bodies are modeled using standard Simscape Solid blocks.Their mass properties are either calculated from their basic geometry (sphere/cylinder) or defined manually to match the desired scale of the mission.Solver Stability: The ode15s solver was selected to handle the stiff equations resulting from the high gravitational pull and the rigid body interactions.


Part 2: Docking Logic and Relative Propulsion
This section describes how the capsule identifies the ship's position and the logic used to lock them together mid-flight.

1. Relative Distance via 6-DOF Joint
Instead of using external sensors, the relative distance is calculated using the internal coordinate data of the system.

Data Extraction: Position signals are pulled directly from the 6-DOF Joint.

The Math: These coordinates are fed into a Subtract block to determine the gap between the two bodies.

The Condition: A comparison block checks if the result is less than 5 meters. This specific value acts as the "go/no-go" trigger for the docking sequence.

2. Autonomous Capsule Propulsion
During the approach phase, the movement is not shared; the capsule is the active hunter.

Powered Pursuit: Only the capsule is equipped with thrusters/motors in this stage.

Navigation: The capsule uses its own propulsion to close the gap, moving toward the passive ship until it enters the 5-meter docking zone.

3. The Docking Trigger (Locking)
When the 5-meter condition is met, the simulation transitions from a chase to a unified flight.

Mode Switching: The condition signal is sent to the Bushing Joint to change its state.

Hard Dock: By sending a -1 signal to the joint's mode port, all degrees of freedom are instantly locked, "welding" the capsule to the ship.

Signal Integrity: To ensure the joint locks correctly, the Simulink-PS Converter is set to provide the signal without filtering, avoiding intermediate values that would cause solver errors.

4. Post-Docking Dynamics
After the lock is confirmed, the physics of the system change to reflect the new combined mass.

Mass Integration: Since the capsule's mass is derived from its CAD geometry (smiData.Solid(1).mass), the simulation accounts for the added weight of the capsule on the ship.

Unified Flight: Once docked, the ship and capsule move together as a single rigid assembly, heading toward the planet's surface while maintaining a fixed relative position.


Part 3: Navigation and Planetary Landing StrategyThis final stage focuses on the guidance system required to land the docked assembly on a moving planet. Because the planet is rotating and traveling through the scene, the system must "lead" the target rather than simply flying toward its current position.
1.  Real-Time Data AcquisitionI used Transform Sensors to track the state vectors of both the docked ship-capsule assembly and the planet. By extracting the Position and Velocity signals for both objects, I established a live data feed for the navigation controller.
2.  Trajectory Prediction LogicTo ensure a successful intercept, I implemented a prediction algorithm based on kinematic differential equations.Instead of chasing the planet’s current location, the system forecasts the planet's future position.By integrating the planet's constant linear velocity and its rotational angular velocity over time, the model calculates where the planet will be by the time the ship arrives.
3.  Intercept Calculation (t_min and Directional Vector)The core of the navigation "brain" involves two main steps:Time-to-Intercept (t_min): The system estimates the minimum time required to close the gap based on the relative distance and the current approach speed.Directional Vector: Once the future position of the planet is predicted for that specific time ($t_{min}$), the system generates a Directional Unit Vector. This vector points from the ship's current position to the planet’s future "meeting point," providing a precise heading for the thrusters to follow.4. Automatic Landing and Simulation TerminationThe landing is defined by the physical dimensions of the planet, which has a radius of 30 meters.Surface Detection: I used a comparison block to monitor the magnitude of the distance between the ship and the planet's center.Stop Condition: A logic gate is set to trigger once this distance is less than or equal to 30 meters.Mission Success: This trigger is connected to a Stop Simulation block, which automatically freezes the physics engine the moment the ship touches the surface, confirming a successful mission completion.
