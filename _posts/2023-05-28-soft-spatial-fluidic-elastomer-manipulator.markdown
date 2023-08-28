---
title: Review -- Design, kinematics, and control of a soft spatial fluidic elastomer manipulator
date:   2023-05-28 15:28:00 +0800
categories: [Research, Soft Robots]
tags: [notes, soft-actuator, paper]
math: true
img_path: /assets/230528/
---

This is a note on the article *Design, kinematics, and control of a soft spatial fluidic elastomer manipulator*. This paper presents a robotic manipulation system capable of autonomously positioning a multi-segment soft fluidic elastomer robot in three dimensions.

- A new spatial manipulator **morphology** that is modular in design and well suited for automation.
- Multi-step **casting process** to build manipulators 3D.
- A static model to understand how a single segment deforms.
- Model of the multi-segment **kinematics** of the soft manipulator
- **Power**: high capacity fluidic drive cylinders.
- A **real-time closed-loop control algorithm** that generates realizable curvature trajectories, measures the arms current state using localized segment endpoints, and leverages a cascaded control strategy.

## Introduction

Several advantages of the fluidic elastomer manipulator's continuum kinematics and soft material composition:

1. The manipulator's soft segments deform according to constant curvature.
2. The kinematics and extreme compliance of such a soft manipulator enable it to fit within and advance through confined environments.
3. A high degree of dexterity

### A review of soft manipulator designs

Continuously deformable backbones $\Longrightarrow$ Infinite DOFs

**Soft continuum manipulators**. Two primary morphologies:

1. Tendon driven arms
2. Fluidic elastomer actuators. Advantages:
   - can be lightweight making for easy integration into distal locations of the body;
   - conforms to the time varying shape of the manipulator; 
   - does not require rigid components to implement.

### A review of soft manipulator kinematics

#### Robot-independent model

Piece-wise constant curvature (PCC) model

Assumption: each body segment of a multi-segment arm is assumed to deform with constant curvature.

![2](2.png)

Forward kinematic transformation for a single continuum segment:

![2-1](2-1.png)

where $s=[0,~L]$

Obvious limitation: Not all continuum robots deform according to segmented constant curvature. A common exception is when a continuum body segment assumes a spiral, i.e. curvature increases from the segment’s base to tip.

#### Robot-dependent model

Mapping: actuation space $\rightarrow$ configuration space ($L,~ \kappa,~ \gamma$)

## System Overview

![3](3.png)

Subsystems: actuation, perception, power and computation

## Actuation

### Soft manipulator design

- Composed entirely from low durometer silicone rubbers
- Actuated by pressurizing fluid channels embedded within the arm. 

![4](4.png)

Morphology:

- **Modular** in both design and fabrication
- Each module has **four distributed fluidic actuators** allowing it to move in three spatial dimensions.
- **Hollow cylindrical interior** accommodates fluid transmission lines and allows modular assembly.
- **Soft segment endplates** contain markers allowing an external camera system to localize their positions.
- A **longitudinally tapered and clover-shaped exterior**.

![5](5.png)

**Bending motion** primitives:

Combining actuation in the x and y directions allows for bending in any direction with zero rotation around the longitudinal axis.

### Kinematic modeling

PCC-based kinematic model

#### Segment deformation

This simplified deformation model suggests that a significant portion of the actuator will deform under approximately constant curvature.

![7](7.png)

Consider the case of one of the segment's channels deforming under pressure.

1. Divide the channel in $J$ cross-sectional slices of uniform z-axis length cut parallel to the x-y plane.
2. Iteratively apply the model each time increasing $p_c$. At each iteration the channel’s circumferential and longitudinal deformed dimensions are recalculated based on the material stresses that are derived from the previous iteration’s deformed geometry.

![8](8.png)

#### Stresses and strains

Approximate the circumferential stress $\sigma_c$ in a thin cross-sectional channel slice by balancing static forces (Figure 7c).

$$
2\sigma_{ci}\hat{t_i}\tilde{w}_i\approx p_c\frac{\hat{h}_{i-1}+\hat{h}_i}{2}\tilde{w}_i \quad \forall~i=1,\dots,J
$$

$$
\sigma_{ci}\approx\frac{p_c\hat{h}_{i-1}^2}{4b\hat{t}_i\left(\hat{t}_i+\hat{h}_{i-1}\right)} \quad \forall~i
$$

When $\hat{h}_{i-1}=\hat{h}_i$

$$
\sigma_{ci}\approx p_c\frac{\hat{h}_{i-1}}{2\hat{t}_i}\quad\forall~i
$$

Similarly, the longitudinal stress $\sigma_L$

$$
\sigma_{Li}\approx\frac{p_c\hat{h}_{i-1}^2}{4b\hat{t}_i\left(\hat{t}_i+\hat{h}_{i-1}\right)}\quad\forall~i=1,\dots,J
$$

Free parameter: $b$ (to better match experimentally observed deformations)

Circumferential and longitudinal strain $\epsilon_c,~\epsilon_L$ can be determined by a look-up table based on stress.

#### Updating channel geometry

Express the **elongated wall** $\hat{w}$, the **expanded diameter** $\hat{h}$ and **compressed thickness** $\hat{t}$ using strain and the initial channel geometry.

The accumulated angle $\theta$ along the neutral axis at this simulation iteration

$$
\theta=\sum_{i=1}^J \arccos\left(\frac{-\hat{w}_i^2+\hat{h}_{i-1}^2+\bar{w}^2+\hat{h}_i^2}{2\hat{h}_i\sqrt{\hat{h}_{i-1}^2+\bar{w}^2}}\right)-\arctan\left(\frac{\bar{w}}{\hat{h}_{i-1}}\right)
$$


#### Conditions for constant curvature

Only the actuated region of the segment, i.e. the channel with arc length $L$ is expected to deform under constant curvature.

#### Segment transformation

Transformation from the base of a segment to the tip

$$
\mathbf{S}_\mathrm{tip}^\mathrm{base}=\mathbf{R}_z(\gamma)~\mathbf{T}_z(L_P)~\mathbf{R}_y\left(\frac{\theta}{2}\right)~\mathbf{T}_z(d(\theta))~\mathbf{R}_y\left(\frac{\theta}{2}\right)~\mathbf{T}_z(L_P)
$$

The kinematics of a multi-segment soft arm composed of N segments can be represented by cascading single segment transformations together:

$$
\mathbf{M}_\mathrm{tipN}^\mathrm{base}=\prod_{i=1}^N \mathbf{S}_\mathrm{tip}^\mathrm{base}(\gamma_i,~\theta_i)
$$

#### Model evaluations

Compare **bending angle** $\theta$ at each incremental fill level.

#### Limitations

- Deviate at lower pressures
- Not directly establish the validity of the PCC-based model's ability to describe the backbone's continuous deformation
- Physical limitations. (maximum achievable bend angle of a segment)
- Force output limitation.(When the rubber is subject to high rates of strain, the material exhibits increased stiffness and more effectively transfers input fluid energy into actuator tip force. Then, when the load is constant, the elastomer exhibits a decrease in stiffness and accordingly the actuator’s channel expands under the fluid energy lessening the actuator’s tip force)

### Manipulator fabrication

Fabricate the arm through a casting process that uses **pourable silicone rubber** and **3D printed molds**.

Fabrication process:

![13](13.png)

The mold consists of four parts:

1. two-part outer shell (orange)
2. interior piece (blue)
3. metal rods (grey)
4. removable sleeve (fuchsia)

> All inlet pieces are cut to length and cleaned with **rubbing alcohol** to ensure good bond between their surface and the silicone rubber
>
>
{:.prompt-tip}

## Power

- Pressurized fluids (air because of its low viscosity)

- Challenges:

	1. need to supply each actuator with a continuous source of fluid energy for prolonged operation
	2. need the ability to continuously adjust input energy for smooth curvature control

- Fluidic drive cylinders

![15](15.png)

## Processing and control

![alg2](alg2.png)

1. `generateTraj()` generates a realizable curvature velocity trajectory $\dot{\kappa}(t)$ from $\kappa_0$ to $\kappa_f$. The velocity trajectory is trapezoidal.
2. `driveSegments()` advances the arm segments along the aforementioned trajectory under closed-loop control.
   1. New measurement of segment endpoints in reference to a base frame.
   2. Transform into the sagittal plane specified by the rotation $\gamma$.
   3. Use the endpoints to determine the measured curvature configuration representation $\kappa_\mathrm{meas}$. (`singleSegInvKin()`)
   4. Compute a reference configuration $\kappa_\mathrm{target}$.
   5. Input the computed error $\kappa_\mathrm{target}-\kappa_\mathrm{meas}$ to low level cascaded PI-PID controllers.

## Capabilities

### Confined environment

The **minimum confining space** for a continuum manipulator segment can be significantly **smaller** than a rigid manipulator link in environments whose boundaries can be parameterized by curved cylinders or tubes.

### Shape fitting

In an environment where a collision-free path is parameterized by a curved shape, a continuum manipulator can generally fit the curvature of the path better than a rigid link manipulator with discrete joints.

Scenarios that cause an error between the continuum robot's curvature and the path's curvature:

![22](22.png)

#### Shape fitting algorithm

Objective: to incrementally advance a soft continuum manipulator along a curved path.

![alg3](alg3.png)

For each segment on the path, two points along the segment’s neutral axis, the mid and endpoint, are fit to the path by choosing the segment’s curvature $\kappa$ to **minimize the Euclidean norm** between the two points and their **projection** onto the path.

Forward kinematics procedure `forwardKin()`: recursively determining a point on the arm located a distance $s$ on segment $i$ given curvature and length.

![alg4](alg4.png)

### Positioning

Inverse kinematics problem: a constrained nonlinear optimization

1. Calculate $\gamma$ as well as find a locally-optimal reference configuration $\kappa^*$ that position the arm's end-effector at a goal point within a statically reachable envelope.
2. Use the procedures in Algorithm 2 to plan and execute a curvature trajectory $\dot{\kappa}(t)$.

![alg5](alg5.png)

#### Positioning algorithm

`moveToObject()`

1. Localize an object's center in $\mathbb{R}^3$ using the external camera system (`localizeObject()`)
2. Translate into a predetermined offset

`moveToPoint()`: strategy for moving the arm

1. Rotate the arm into a sagittal plane defined by $\gamma$
2. Iterative search for manipulator configuration
3. `singleSegInvKin()` uniquely fits a PCC model to the data

`inverseKin()`: determine the trajectory's end configuration $\kappa_f$.
