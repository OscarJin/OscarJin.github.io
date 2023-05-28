---
title: Design, kinematics, and control of a soft spatial fluidic elastomer manipulator
date:   2023-05-28 15:28:00 +0800
categories: [Research, Soft Robots]
tags: [notes, soft-actuator, paper]
math: true
img_path: /assets/230528/
---

This is a note on the article *Design, kinematics, and control of a soft spatial fluidic elastomer manipulator*. This paper presents a robotic manipulation system capable of autonomously positioning a multi-segment soft fluidic elastomer robot in three dimensions.

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

Bending motion primitives:

Combining actuation in the x and y directions allows for bending in any direction with zero rotation around the longitudinal axis.
