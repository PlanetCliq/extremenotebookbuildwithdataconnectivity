# Extended Multiphysics Simulation Plan

## Purpose

This plan turns the COMSOL, ANSYS, and Silvaco references into an executable
simulation program for the extreme notebook architecture. It separates
device-level work from package and system-level work, then defines the data
passed between them.

The models are engineering templates, not certification evidence. Material
properties, component power maps, and measured blower curves must replace the
placeholder values before design release.

## Model Hierarchy

| Level | Primary tool | Model | Required output |
|---|---|---|---|
| Device | Silvaco Atlas / Victory Device | MOSFET, PMIC switch, battery interface | Loss density, junction temperature, electrical curves |
| Package | COMSOL or ANSYS Mechanical | Die, TIM, heat spreader, solder, package | Thermal resistance, warpage, interface stress |
| System thermal | COMSOL, ANSYS Icepak, Fluent, or CFX | PCB, vapor chamber, blowers, chassis, battery | Temperature field, airflow, pressure drop |
| System electrical | ANSYS SIwave/Maxwell or COMSOL AC/DC | VRM, planes, vias, high-speed routes | IR drop, current density, PDN impedance, Joule heat |
| System mechanical | ANSYS Mechanical or COMSOL Solid Mechanics | Unibody, hinges, mounts, PCB, display | Stress, displacement, modes, shock response |

## Shared Inputs

Load the values in `simulation_parameters.yml` into each solver. Preserve the
same coordinate system, component origins, power names, and material IDs so
results can be exchanged without manual remapping.

### Geometry

- Import `3DCADModelFile.step` for the enclosure and mechanical interfaces.
- Import `3DCADExchangeFile.IGES` when a surface-healing workflow is required.
- Use the PCB stack-up and component locations from `pcblayout.pcb` and
  `Altium_Master_Design.NET`.
- Suppress cosmetic fillets, logos, and non-structural fasteners during the
  first mesh convergence pass.

### Mesh and Convergence

1. Start with a system mesh sized to resolve the thinnest thermal interface
   and the smallest power via region.
2. Add local refinement at CPU/GPU/TIM contacts, VRM pins, hinge roots, and
   screw bosses.
3. Repeat the solve at 0.75x and 0.5x characteristic element size.
4. Accept the mesh only when maximum temperature, voltage drop, and peak
   von Mises stress change by less than 5 percent between the final two meshes.

## Study A: Thermal and Airflow

### Objective

Determine steady-state and transient temperatures for CPU, GPU, NPU, memory,
VRM, battery, vapor chamber, and chassis under realistic blower operation.

### Cases

| Case | Load | Ambient | Duration | Purpose |
|---|---|---:|---:|---|
| T1 idle | 15 percent compute | 25 C | 600 s | Baseline thermal resistance |
| T2 CPU | 175 W CPU plus board load | 25 C | 1800 s | CPU sustained limit |
| T3 GPU | 250 W GPU plus memory load | 25 C | 1800 s | GPU sustained limit |
| T4 combined | 175 W CPU plus 250 W GPU plus NPU/board load | 25 C | 3600 s | Worst-case cooling |
| T5 hot ambient | T4 | 40 C | 3600 s | Environmental margin |
| T6 cold start | T4 ramp | -40 C to 85 C | 100 cycles | Thermal fatigue input |

### Boundary Conditions

- Apply component losses as volumetric heat sources, not surface fluxes,
  wherever package geometry is available.
- Use measured blower mass-flow and pressure curves in Fluent, CFX, or Icepak.
- Use natural or forced convection only on surfaces not represented by the
  airflow domain.
- Include contact resistance for TIM, vapor chamber, copper insert, and
  chassis interfaces.
- Couple electrical loss from Study B into the heat-transfer model.

### Required Results

- Maximum and 95th percentile temperature for every heat-generating component.
- Temperature at battery cells, chassis user-contact zones, and connector
  housings.
- Airflow rate, pressure drop, recirculation, and bypass flow.
- Thermal resistance from each die to ambient.
- Time to 90 percent of steady-state temperature and cool-down time.

## Study B: Electrical and Electrothermal Power Integrity

### Objective

Quantify voltage margin, current density, switching losses, and heat generated
by the high-power delivery network and high-speed interconnects.

### Cases

| Case | Excitation | Frequency or time | Primary result |
|---|---|---|---|
| E1 DC rails | CPU/GPU/NPU rated load | DC | Plane IR drop and current density |
| E2 load step | 20 to 100 percent load | 10 ns to 10 ms | Transient droop and recovery |
| E3 PDN sweep | VRM output impedance | 10 kHz to 10 GHz | Resonance and anti-resonance |
| E4 switching | VRM gate-drive waveform | Device transient | MOSFET loss and junction heat |
| E5 battery | Charge/discharge profile | 0.1 C to 3 C | Cell current, heat, and margin |

### Solver Mapping

- Use Silvaco to extract temperature-dependent MOSFET and diode losses.
- Use COMSOL AC/DC or ANSYS Maxwell/SIwave for planes, vias, package
  parasitics, and electromagnetic coupling.
- Export Joule loss density to Study A.
- Export temperature-dependent resistivity back into the electrical solve for
  electrothermal iteration.

### Required Results

- CPU, GPU, memory, and battery rail voltage at the load pins.
- Peak transient droop and recovery time.
- Current density in planes, vias, MOSFETs, connectors, and battery tabs.
- PDN impedance and resonance frequencies.
- Loss budget by VRM stage and the resulting thermal source map.

## Study C: Mechanical, Modal, and Shock Analysis

### Objective

Verify the enclosure, hinge, PCB supports, thermal stack, and battery mounts
under static, thermal, vibration, and drop loads.

### Cases

| Case | Applied load | Primary result |
|---|---|---|
| M1 static | Assembly mass and preload | Stress and displacement |
| M2 thermal expansion | 25 C to 85 C mapped from T4 | Contact pressure and warpage |
| M3 modal | Free and mounted boundary conditions | Natural frequencies and modes |
| M4 random vibration | MIL-STD-810G profile | RMS stress and fatigue damage |
| M5 drop | 1.2 m, 26 orientations | Peak acceleration and plastic strain |
| M6 hinge fatigue | Repeated opening/closing cycle | Life and pin/boss stress |

### Boundary Conditions

- Model screw preload and bonded/contact interfaces explicitly where they
  control load transfer.
- Map the transient temperature field from Study A into the structural model.
- Map pressure and force loads from blowers and the display assembly.
- Use nonlinear contact for hinge interfaces, thermal stack compression, and
  battery restraints.
- Use elastoplastic material behavior for drop analysis; do not infer drop
  safety from a linear static solve.

### Required Results

- Peak von Mises stress, principal stress, strain, and displacement.
- Chassis and display alignment at operating temperature.
- Contact pressure and separation in TIM and vapor chamber interfaces.
- First six modes and separation from blower and drive excitation frequencies.
- Shock response, plastic strain, and fatigue damage accumulation.

## Coupling and Data Exchange

1. Silvaco exports device loss density and temperature-dependent electrical
   parameters.
2. System electrical analysis exports rail losses and Joule heat.
3. Thermal/CFD analysis exports temperature and pressure fields.
4. Mechanical analysis imports those fields and exports deformation/contact
   changes.
5. Repeat electrical and thermal solves until maximum temperature changes by
   less than 1 C and rail voltage changes by less than 1 percent.

Store all exported fields with the same component IDs and SI units. Record
solver version, mesh hash, material revision, boundary-condition revision, and
convergence status with every result.

## Acceptance Criteria

| Metric | Target |
|---|---:|
| CPU junction temperature | < 95 C |
| GPU junction temperature | < 85 C |
| Battery temperature | < 45 C |
| Temperature convergence between final coupling iterations | < 1 C |
| Rail voltage change after electrothermal iteration | < 1 percent |
| Final mesh result change | < 5 percent |
| Chassis stress | Below verified material allowable |
| Hinge life | > 50,000 cycles |
| No mode within defined blower excitation band | Required |

## Correlation and Reporting

Correlate T1-T5 against thermal chamber and telemetry data in
`TestValidationReports.LOG.TXT`. Correlate M3-M6 against vibration, shock, and
hinge test records. For each mismatch greater than 10 percent, identify whether
the cause is geometry, material data, power mapping, contact resistance, or
sensor placement before changing model parameters.

Each release package should include:

- Solver project and version
- Geometry and mesh statistics
- Input parameter file and revision
- Convergence history
- Thermal, electrical, and mechanical result plots
- Correlation table with measured data
- Known assumptions and unresolved risks


## Latest Adherence Norms
- **Recycled Content Validation**: UL Environmental Claim Validation Procedure (ECVP 2809‑2, June 2024).  
  - Example: Minimum 82.9% of device (excluding PSU) contains 100% recycled cobalt.  
- **Packaging Standards**: IEEE Std 1680.1‑2018 compliance.  
  - FSC certification required for wood‑based fibre packaging.  
- **Material Use**:  
  - Aerospace aluminium alloy 7075‑T6 in enclosures, customized for high strength-to-weight ratio and thermal stability.  
  - Titanium alloy Ti‑6Al‑4V in hinges and port cages, optimized for fatigue resistance and precision fit.  
  - Copper alloy thermal inserts, engineered for conductivity >380 W/m·K.  
  - 100% recycled rare earth metals in magnets, validated by UL for sustainability.  
  - All metals remain validated under UL and IEC standards despite custom machining and aerospace‑grade performance tuning.

---

## Validated Claims Across Extreme Notebook Build

| **Certification** | **Focus Areas** | **Validation Method** |
|-------------------|-----------------|-----------------------|
| **TCO Certified** | Climate impact, hazardous substances, circularity, supply chain responsibility | Independent verification |
| **EPEAT** | Climate, chemicals of concern, circularity, responsible supply chains | GEC‑approved Conformity Assurance Bodies (CABs) |
| **UL ECVP** | Recycled content validation (metals, alloys, rare earths) | UL Environmental Claim Validation |
| **FSC** | Sustainable packaging, fibre sourcing | FSC chain‑of‑custody certification |

---

### 🔧 Notes on Metals & Customization
- **Aluminium 7075‑T6**: CNC‑milled for chassis and thermal frames, retains UL validation while achieving aerospace‑grade rigidity.  
- **Titanium Ti‑6Al‑4V**: Used in hinges and cages, certified for fatigue resistance and corrosion protection.  
- **Copper Alloy Inserts**: Customized for thermal conduction in GPU/NPU modules, validated under IEC thermal standards.  
- **Rare Earth Magnets**: 100% recycled, performance‑tuned for connector retention, validated by UL for sustainability.  
- **All Materials**: Sustainably sourced, recycled content claims verified, and performance customization remains within certification boundaries.
