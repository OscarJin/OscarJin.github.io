---
title: Modeling Shell-Reinforced Bending SPA using Abaqus
date:   2023-03-04 17:28:00 +0800
categories: [Research, Soft Robots]
tags: [notes, abaqus, soft-actuator]
math: true
img_path: /assets/230304/
---

In this note, a demo of a shell-reinforced bending soft pneumatic actuator (SPA) is presented. From the demo, we can have a general idea of the procedures of **implicit dynamic analysis** using Abaqus.

References:

1. [Modeling soft pneumatic actuators][modeling]
2. [Open-source models for bending shell-reinforced actuators][model-src]


## Step 1: Create Actuator Geometry (Parts)

- A **single air chamber** is modeled for providing enhanced mechanical reliability of the actuator by eliminating stress concentrations at narrow passage walls. 
- The **cross-section** of the air chamber is circular.
- The bending actuator achieves **bending motion** due to a thin un-stretchable layer attached at the bottom of the structure.
- Due to the **symmetry** of the structure, only half the portion of the entire actuator is created and modeled.

Geometric Parameter:

The following geometry is generated in Abaqus CAE for a bending actuator with an *outer diameter* of 4 mm, *wall thickness* of 2 mm and *total length* of 40 mm. The *number of cuts* on shell surface is 7, at a *cut spacing* of 1 mm.

![](shell_model.jpg)
_Shell part of the linear actuator (4 parts are created, namely Cuts, Cylinder, Shell and Shell with Cuts)_

## Step 2: Define Properties

### Material Constitutive Model

In the demo, the chamber is made in Exoflex-30 material while the thin un-stretchable shell layer is made of a plastic material such as PET.

The material Ecoflex-30 is modeled using a **hyperelastic** model. A 3-term Ogden model is used for Ecoflex-30 in this example, with the following coefficients:

mu1 = 0.001887; alpha1 = -3.848; mu2 = 0.02225; alpha2 = 0.663; mu3= 0.003574; alpha 3 = 4.225; D1 = 2.93; D2 = 0; D3 = 0

![](ecoflex-30.png)
_Hyperelastic property of Ecoflex-30_

The shell is modeled using a linear elastic model (due to stresses in shell not exceeding elastic range). The elastic property can be defined by Young's modulus and Poisson's ratio:

![](plastic.png)
_Linear elastic property of plastic_

### Sections and Material Assignment

Create the sections of the parts of the actuator (Cylinder and Shell), using the default settings.

![](sections.png)
_Sections of the model_

Assign the part (section) Cylinder with the material Ecoflex-30 and Shell with plastic.

> Material can only be assigned to a part when a section is defined.
> 
{:.prompt-tip}

## Step 3: Define Assembly

1. **Create Instances** to add parts to the assembly.
2. We can further create some Sets and Surfaces, such as the inner of the tube (Tube_Inner).

![](tube_inner.png)
_Create inner surface of the tube_

## Step 4: Define Steps

### Define Implicit Dynamic Step

- Time period: 200
- Nlgeom: On

> Nlgeom must be turned **on** for large deformation!
>
{:.prompt-warning}

- Application: Quasi-static
- Incrementation Type: Automatic
- Maximum number of increments: 10000
- Increment size: Initial 15, Minimum 1E-6, Maximum 15

![](step.png)
_Incrementation of the step defined_

### Define Field Output

- F-Output-1

![](f-output-1.png)

- Pressure

![](pressure-output.png)

### Define History Output

- H-Output-1

![](h-output-1.png)
_Choose all items in 'Energy'_

- Displacement

![](displacement.png)

## Step 5: Meshing

In this case, due to the hyperelastic behavior of the material used to create the actuator core, **standard linear 3-D stress elements** are used with hybrid formulation and reduced integration. 

For the **shell** structure, **standard linear shell elements** with reduced integration are used. The following image shows the mesh generated for the shell, as an example.

![](mesh.png)
_Meshing result_

## Step 6: Define Interactions

> To achieve bending motion profile, a thin strip portion at the bottom of the shell is attached to the core surface using an adhesive. The shell is permitted to slide over the surface of the actuator and guide its trajectory in the remaining portions. To implement this condition in Abaqus, a tie constraint is imposed at the thin unstretchable portion while a contact property is defined to include finite sliding in tangential orientation with a specified coefficient of friction in the remaining portions.
> 
{:.prompt-info}

First define the **interaction property** *Tangential Behavior*:

- Friction formulation: Penalty
- Friction Coeff.: 0.2

![](interaction-behavior.png)

Then define the sliding interaction between the cylinder and the shell.

![](sliding.png)

## Step 7: Define Pressure Loads

An input pressure of 50 kPa was specified on the chamber walls.

![](pressure.png)

## Step 8: Define Boundary Conditions (BCs)

- Half Symmetry

![](symm-shell.png)
_Half symmetry of shell_

![](symm-y.png)
_Half symmetry of cylinder_

- No translation or rotation for the inlet portion

![](fixed-end.png)
_Fixed end_

## Step 9: Create Job

Create a job using the default settings and Submit!

## Step 10: Post-processing

A variety of analysis can be performed.

![](result.png)
_Abaqus ODB result plots for linear extension motion generated are shown for the free displacement condition_



[modeling]: https://softroboticstoolkit.com/book/modeling-soft-pneumatic-actuators/modeling
[model-src]: http://sandbox.softroboticstoolkit.com/book/scripts