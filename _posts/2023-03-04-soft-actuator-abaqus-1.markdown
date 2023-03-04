---
title: Modeling Shell-Reinforced Linear SPA using Abaqus
date:   2023-02-17 10:28:00 +0800
categories: [Research, Notes, Abaqus]
tags: [notes, abaqus, soft-actuator]
math: true
img_path: /assets/230304/
---

In this note, a demo of a shell-reinforced linear soft pneumatic actuator is presented. From the demo, we can have a general idea of the procedures of dynamic analysis using Abaqus.

References:

1. [Modeling soft pneumatic actuators][https://softroboticstoolkit.com/book/modeling-soft-pneumatic-actuators/modeling]
2. [Open-source models for bending shell-reinforced actuators][http://sandbox.softroboticstoolkit.com/book/scripts]

## Step 1: Create Actuator Geometry (Parts)

- A **single air chamber** is modeled for providing enhanced mechanical reliability of the actuator by eliminating stress concentrations at narrow passage walls. 
- The **cross-section** of the air chamber is circular.
- The bending actuator achieves **bending motion** due to a thin un-stretchable layer attached at the bottom of the structure.
- Due to the **symmetry** of the structure, only half the portion of the entire actuator is created and modeled.

Geometric Parameter:

The following geometry is generated in Abaqus CAE for a bending actuator with an *outer diameter* of 4 mm, *wall thickness* of 2 mm and *total length* of 40 mm. The *number of cuts* on shell surface is 7, at a *cut spacing* of 1 mm.

![](shell_model.jpg)
_Shell part of the linear actuator (4 parts are created, namely Cuts, Cylinder, Shell and Shell with Cuts)_

## Step 2: Define Material Constitutive Model

In the demo, the chamber is made in Exoflex-30 material while the thin un-stretchable shell layer is made of a plastic material such as PET.

The material Ecoflex-30 is modeled using a **hyperelastic** model. A 3-term Ogden model is used for Ecoflex-30 in this example, with the following coefficients:

mu1 = 0.001887; alpha 1 = -3.848; mu2 = 0.02225; alpha2 = 0.663; mu3= 0.003574; alpha 3 = 4.225; D1 = 2.93; D2 = 0; D3 = 0

![](ecoflex-30.png)
_Hyperelastic property of Ecoflex-30_

The shell is modeled using a linear elastic model (due to stresses in shell not exceeding elastic range). The elastic property can be defined by Young's modulus and Poisson's ratio:

![](plastic.png)
_Linear elastic property of plastic_