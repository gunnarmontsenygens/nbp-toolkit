# N-Body Problem in Jacobi Coordinates Toolkit (MATLAB)

## Summary

This folder contains MATLAB utilities for modeling, simulating, and analyzing the gravitational **N-Body Problem (NBP)** using **Jacobi coordinates**.

The toolbox provides routines for transforming between barycentric and Jacobi coordinate systems, propagating the equations of motion, evaluating conserved quantities, computing relative geometric quantities, and visualizing N-body trajectories.

The implementation follows the Jacobi-coordinate formulation developed in **ASEN 6062 – Celestial Mechanics**, allowing the equations of motion to be expressed in reduced coordinates while eliminating the translational motion of the system barycenter.

Throughout the toolbox, the gravitational constant is normalized to

- `G = 1`

unless otherwise stated.

---

## Functions

### Mass Utilities

### m2M.m

**Description:** Computes the cumulative mass sequence associated with an N-body system.

The routine converts the individual body masses into the cumulative masses

```
M_j = Σ_{i=1}^{j} m_i
```

required by the Jacobi coordinate formulation.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `m_list` | Individual body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `M_list` | Cumulative mass sequence | – |

#### Notes

- Used throughout all Jacobi-coordinate transformations.

---

## Center-of-Mass Utilities

### CoMj.m

**Description:** Computes the center of mass of the first `j` bodies.

This routine evaluates the partial center of mass appearing in the recursive definition of the Jacobi coordinates.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_list` | Position vectors of the bodies | – |
| `m_list` | Individual body masses | – |
| `j` | Number of bodies included in the center of mass | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Rcj_vec` | Center-of-mass position of the first `j` bodies | – |

---

## Coordinate Transformations

### Barycentric → Jacobi

### r2Rj.m

**Description:** Computes the `j`-th Jacobi position vector from barycentric coordinates.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_list` | Barycentric position vectors | – |
| `m_list` | Body masses | – |
| `j` | Jacobi coordinate index | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Rj_vec` | `j`-th Jacobi position vector | – |

#### Notes

- Implements the recursive definition of Jacobi coordinates.

---

### r2R.m

**Description:** Computes the complete set of Jacobi position vectors from barycentric position vectors.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_list` | Barycentric position vectors | – |
| `m_list` | Body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `R_vec_list` | Complete set of Jacobi position vectors | – |

---

### v2V.m

**Description:** Computes the Jacobi velocity vectors from barycentric velocity vectors.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `v_vec_list` | Barycentric velocity vectors | – |
| `m_list` | Body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `V_vec_list` | Jacobi velocity vectors | – |

---

### RV2Xjac.m

**Description:** Constructs the complete Jacobi state vector from Jacobi position and velocity vectors.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `R_vec_list` | Jacobi position vectors | – |
| `V_vec_list` | Jacobi velocity vectors | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Complete Jacobi state vector | – |

---

### rv2Xbar.m

**Description:** Constructs the complete barycentric state vector from barycentric positions and velocities.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_list` | Barycentric position vectors | – |
| `v_vec_list` | Barycentric velocity vectors | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Xbar_vec` | Complete barycentric state vector | – |

---

### r2Xbar.m

**Description:** Constructs the barycentric position state vector from the barycentric position vectors of all bodies.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_list` | Barycentric position vectors | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Xbar_vec` | Barycentric position state vector | – |

### Jacobi → Barycentric

### Xjac2Rj.m

**Description:** Extracts the `j`-th Jacobi position vector from a complete Jacobi state vector.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Complete Jacobi state vector | – |
| `j` | Jacobi coordinate index | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Rj_vec` | `j`-th Jacobi position vector | – |

---

### Xjac2Vj.m

**Description:** Extracts the `j`-th Jacobi velocity vector from a complete Jacobi state vector.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Complete Jacobi state vector | – |
| `j` | Jacobi coordinate index | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Vj_vec` | `j`-th Jacobi velocity vector | – |

---

### Xjac2Rcj.m

**Description:** Computes the center-of-mass position of the first `j` bodies directly from a Jacobi state vector.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Complete Jacobi state vector | – |
| `m_list` | Body masses | – |
| `j` | Center-of-mass index | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Rcj_vec` | Center-of-mass position of the first `j` bodies | – |

#### Notes

- Uses the recursive Jacobi-coordinate relations.

---

### Xjac2r1.m

**Description:** Computes the barycentric position vector of Body 1 from a Jacobi state vector.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Complete Jacobi state vector | – |
| `m_list` | Body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `r1_vec` | Barycentric position of Body 1 | – |

---

### Xbar2rj.m

**Description:** Extracts the barycentric position vector of Body `j` from a barycentric state vector.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xbar_vec` | Complete barycentric state vector | – |
| `j` | Body index | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `rj_vec` | Position vector of Body `j` | – |

---

### Xbar2vj.m

**Description:** Extracts the barycentric velocity vector of Body `j` from a barycentric state vector.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xbar_vec` | Complete barycentric state vector | – |
| `j` | Body index | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `vj_vec` | Velocity vector of Body `j` | – |

---

### Xjac2r.m

**Description:** Converts a complete Jacobi state vector into the barycentric position vectors of all bodies.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Complete Jacobi state vector | – |
| `m_list` | Body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_list` | Barycentric position vectors | – |

#### Notes

- Performs the inverse Jacobi transformation.

---

### Xjac_list2r_list.m

**Description:** Converts a history of Jacobi state vectors into barycentric position histories.

This routine is primarily intended for post-processing and visualization of numerical simulations.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_hist` | History of Jacobi state vectors | – |
| `m_list` | Body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_hist` | Barycentric position history | – |

---

## Relative Geometry Utilities

### Xjac2rij.m

**Description:** Computes the relative position vector between two bodies directly from a Jacobi state vector.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Complete Jacobi state vector | – |
| `m_list` | Body masses | – |
| `i` | First body index | – |
| `j` | Second body index | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `rij_vec` | Relative position vector from Body `i` to Body `j` | – |

---

### rijparRl.m

**Description:** Computes the contribution of an individual Jacobi coordinate to a specified relative position vector.

This utility is useful for constructing analytical expressions involving relative distances in Jacobi coordinates.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `i` | First body index | – |
| `j` | Second body index | – |
| `l` | Jacobi coordinate index | – |
| `m_list` | Body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `coeff` | Contribution coefficient | – |

#### Notes

- Frequently used in deriving the N-body potential in Jacobi coordinates.

---

### idx_comp.m

**Description:** Determines the complementary index set associated with a given body or Jacobi coordinate.

This utility is primarily intended for internal indexing operations used throughout the toolbox.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `...` | Index information | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `...` | Complementary index set | – |

## Dynamics

### f_NBP_jac.m

**Description:** Computes the equations of motion for the gravitational N-Body Problem in Jacobi coordinates.

The routine evaluates the time derivatives of the Jacobi state vector by combining the kinetic and gravitational contributions derived from the Jacobi-coordinate formulation.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `t` | Time | – |
| `Xjac_vec` | Jacobi state vector | – |
| `m_list` | Individual body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `dXjac_dt` | Time derivative of the Jacobi state vector | – |

#### Notes

- Assumes the normalized gravitational constant `G = 1`.
- Eliminates the translational motion of the system barycenter.
- Intended for use with MATLAB ODE solvers such as `ode45`, `ode113`, or similar.

---

## Integral Quantities

### T_NBP.m

**Description:** Computes the total kinetic energy of the N-Body Problem.

The kinetic energy is evaluated directly from the Jacobi-coordinate representation of the system.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Jacobi state vector | – |
| `m_list` | Individual body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `T` | Total kinetic energy | – |

---

### U_NBP.m

**Description:** Computes the total gravitational potential energy of the N-Body Problem.

The potential energy is evaluated as the sum of all pairwise gravitational interactions.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Jacobi state vector | – |
| `m_list` | Individual body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `U` | Total gravitational potential energy | – |

#### Notes

- Uses the Jacobi-coordinate formulation of the gravitational potential.

---

### E_NBP.m

**Description:** Computes the total mechanical energy of the N-Body Problem.

The total energy is obtained as

```text
E = T + U
```

where `T` is the kinetic energy and `U` is the gravitational potential energy.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Jacobi state vector | – |
| `m_list` | Individual body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `E` | Total mechanical energy | – |

---

### H_NBP.m

**Description:** Computes the total angular momentum vector of the N-Body Problem.

The angular momentum is evaluated from the Jacobi-coordinate representation of the system.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Jacobi state vector | – |
| `m_list` | Individual body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `H_vec` | Total angular momentum vector | – |

---

### Ip_NBP.m

**Description:** Computes the polar moment of inertia of the N-Body Problem about the system barycenter.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `Xjac_vec` | Jacobi state vector | – |
| `m_list` | Individual body masses | – |

#### Output

| Variable | Description | Units |
|---------|-------------|-------|
| `Ip` | Polar moment of inertia | – |

#### Notes

- Evaluated with respect to the system barycenter.

---

## Visualization

### animateNBP_2D.m

**Description:** Generates a two-dimensional animation of an N-body trajectory in barycentric coordinates.

The animation displays the trajectories of all bodies together with their instantaneous positions and the system barycenter.

#### Inputs

| Variable | Description | Units |
|---------|-------------|-------|
| `r_vec_hist` | Position history of all bodies | – |
| `t` | Time history | – |
| `m_list` | Individual body masses | – |
| `AnimateStep` | Animation step size (optional) | – |
| `Nanim` | Number of interpolated animation frames (optional) | – |

#### Output

This function does not return any output variables.

#### Notes

- Produces a two-dimensional animation using the x- and y-components of the trajectories.
- Body marker sizes are scaled according to mass.
- Cubic interpolation is used to generate smooth animations.
- The system barycenter is displayed throughout the simulation.

---

## Notes

- The equations of motion are formulated using **Jacobi coordinates**, eliminating the translational motion of the system barycenter.
- Throughout the toolbox, the gravitational constant is normalized to **G = 1** unless otherwise specified.
- The toolbox supports an arbitrary number of bodies and is applicable to the general gravitational N-Body Problem.
- Coordinate transformation utilities are provided for converting between **barycentric** and **Jacobi** coordinate systems.
- The conserved quantities (kinetic energy, potential energy, total energy, angular momentum, and polar moment of inertia) can be monitored to verify the numerical accuracy of an integration.
- Unless otherwise noted, all routines assume an inertial reference frame.

---

## Vector Format Conventions

- Position and velocity vectors are stored as **row vectors**,

```text
r_i = [x_i  y_i  z_i]

v_i = [vx_i  vy_i  vz_i]
```

- Position and velocity lists follow the conventions

  - `r_vec_list` → `N × 3`
  - `v_vec_list` → `N × 3`

  where each row corresponds to one body.

- Body masses are stored as

```text
m_list = [m₁;
          m₂;
          ⋮
          mₙ]
```

or equivalently as row vectors whenever accepted by the corresponding routine.

- The Jacobi position vectors are ordered as

```text
R_vec_list = [R₁;
              R₂;
              ⋮
              Rₙ₋₁]
```

where each row is a three-dimensional Jacobi coordinate.

- Likewise, the Jacobi velocity vectors are stored as

```text
V_vec_list = [V₁;
              V₂;
              ⋮
              Vₙ₋₁]
```

- The complete Jacobi state vector is ordered as

```text
Xjac = [R₁;
        V₁;
        R₂;
        V₂;
        ⋮
        Rₙ₋₁;
        Vₙ₋₁]
```

- The complete barycentric state vector is ordered as

```text
Xbar = [r₁;
        v₁;
        r₂;
        v₂;
        ⋮
        rₙ;
        vₙ]
```

---

## Usage Examples

Complete examples demonstrating the use of the functions in this toolbox can be found in the following assignments and reports.

| Document | Functions Used | Description |
|----------|----------------|-------------|
| **ASEN 6062 – Homework 1** | `m2M`, `CoMj`, `r2Rj`, `r2R`, `v2V`, `rijparRl` | Derivation of the Jacobi-coordinate formulation of the N-Body Problem, including cumulative masses, partial centers of mass, Jacobi coordinates, and the coefficients relating relative position vectors to Jacobi coordinates. |
| **ASEN 6062 – Computational Homework 1** | `RV2Xjac`, `f_NBP_jac`, `T_NBP`, `U_NBP`, `E_NBP`, `H_NBP`, `Ip_NBP`, `Xjac2r`, `animateNBP_2D` | Numerical integration of the gravitational N-Body Problem in Jacobi coordinates, verification of conserved quantities, reconstruction of barycentric trajectories, and visualization of the resulting motion. |
| **ASEN 6062 – Computational Homework 2** | `Xjac2rij`, `Xjac2Rcj`, `Xjac2Rj`, `Xjac2Vj`, `Xjac_list2r_list`, `Xbar2rj`, `Xbar2vj` | Development of the Restricted Full N-Body Problem by extracting barycentric and Jacobi quantities required for evaluating the gravitational acceleration acting on a massless body. |
| **ASEN 6062 Lecture Notes** | Entire toolbox | Mathematical derivation of the Jacobi-coordinate formulation of the N-Body Problem, including coordinate transformations, equations of motion, conserved quantities, and recursive definitions used throughout the implementation. |
