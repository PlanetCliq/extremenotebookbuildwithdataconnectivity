## Thermal Material Bill of Materials (BoM)

| Component | Material | Thickness | Spread/Shape | Size (mm) | Qty | Manufacturer | Color |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **CPU Intel i9‑14900HX** | Liquid Metal TIM | 0.1–0.2 mm | Full die rectangular | 45×35 | 1 tube | Thermal Grizzly | Silver metallic |
| **GPU NVIDIA Ada 5090M** | Phase‑change pad + graphite sheet | 0.2–0.3 mm | Rectangular die + VRAM squares | Die 50×40, VRAM 12×12 each | 1 set | Honeywell / Panasonic | Grey pad, black graphite |
| **GPU Nanowire AI Quantum** | Nano gap filler | 0.3–0.5 mm | Custom irregular pad | 60×45 | 1 | Fujipoly | White silicone |
| **Memory DDR5X DIMMs** | Graphite thermal sheet | 0.2 mm | Long strip | 133×30 | 2 | Panasonic PGS | Black |
| **Memory HBM3 Stack** | Phase‑change pad | 0.3 mm | Square | 25×25 | 1 | Panasonic Soft‑PCM | Grey |
| **NVMe Gen5 SSDs** | Graphite sheet | 0.5 mm | Rectangular strip | 80×22 | 2 | Fujipoly | Black |
| **VRM TI TPS53689** | Gap filler pad | 0.5–1.0 mm | Rectangular blocks | 10×10 | 3 rails | Bergquist / Laird | White |
| **MOSFET Infineon BSC123N08NS3** | Phase‑change pad | 0.3–0.5 mm | Small square | 5×5 | 6 | Panasonic / Honeywell | Grey |
| **PMIC NXP PF8100** | Graphite sheet | 0.5 mm | Square | 8×8 | 2 | Panasonic PGS | Black |

---

## Thermal Application & Die-Cutting Readiness Guide

* **Liquid Metal TIM (Thermal Grizzly Conductonaut)**  
  * **Supply Form**: Syringe or tube format.  
  * **Application Protocol**: Applied directly to CPU and GPU dies. Requires precise robotic or manual dispensing with dual laser-cut fluorosilicone perimeter containment barriers to prevent migration.  

* **Phase‑Change Pads (Honeywell PTM7950, Panasonic Soft‑PCM)**  
  * **Supply Form**: Bulk sheets or pre-cut pads.  
  * **Application Protocol**: Precision die-cut to exact dimensions for VRMs, power MOSFETs, and memory stacks. Phase-change behavior activates under initial thermal load to fill microscopic interfacial voids.  

* **Nano Gap Fillers (Silicone-Based Thermal Putty/Sheets)**  
  * **Supply Form**: Dispensable putty, rolls, or sheets.  
  * **Application Protocol**: Designed to bridge irregular micro-gaps between high-density components (such as the Nanowire AI Quantum processor) and the CoolerMaster graphene vapor chamber.  

* **Graphite Thermal Sheets (Panasonic PGS, Fujipoly)**  
  * **Supply Form**: High-conductivity large-format sheets.  
  * **Application Protocol**: Requires custom die-cutting to match the exact outlines of DDR5X memory modules, M.2 NVMe Gen5 SSDs, and internal chassis spreaders.  

* **Custom Heat Spreading Solutions (Graphene Vapor Chamber, C11000 Copper Plates)**  
  * **Supply Form**: Pre-engineered assemblies.  
  * **Application Protocol**: Factory-integrated directly into the monolithic 7075-T6 unibody structure and thermal stack. Non-field-serviceable; custom vacuum-diffusion brazed.  

> **Production Note**: All pads, gap fillers, and graphite sheets are supplied fully die-cut to exact tolerance dimensions for rapid assembly, while liquid metal TIMs and putty fillers are dispensed under controlled cleanroom conditions (ISO Class 6).
