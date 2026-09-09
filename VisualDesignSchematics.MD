```

+----------------------------------------------------------------------------------------------------------------------------------------------------+ [Y = 250.00 mm]
|                                                     360.00 mm x 250.00 mm MONOLITHIC 7075-T6 UNIBODY PCB                                           |
|                                                                                                                                                    |
|  [RF KILL SWITCHES]                                                                                          [AI KEY]     [POWER]                  |
|  (25,235) (35,235) (45,235) (55,235)                     [CAP TOUCH SLIDER]                                  (295,235)    (340,235)                 |
|   [WLAN]   [WWAN]    [BT]    [NFC]                       (175.00, 235.00) mm                                  [SW_AI]     [SW_PWR]                 |
|                                                                                                                                                    |
|  +-----------------------------------------------------------------------------------------------------------------------+                         |
|  | MEMORY ZONE: QUAD DDR5X-6400 MT/s (DIMM-288)                                                                          |                         |
|  |                                                                                                                       |                         |
|  |   [M1: DDR5X CH0]         [M2: DDR5X CH1]                       [M3: DDR5X CH2]         [M4: DDR5X CH3]               |                         |
|  |   (90.00, 215.00)         (140.00, 215.00)                      (210.00, 215.00)        (260.00, 215.00)              |   [OPT_CAGE1] (345,195) |
|  |   <---- +-5 mils length match ---->                             <---- +-5 mils length match ---->                     |   QSFP-DD 400G CAGE     |
|  +-----------------------------------------------------------------------------------------------------------------------+   (8x50G PAM4)          |
|                                                                                                                                                    |
|  [DC1] (5,220)            [DCDC1] (20,210)                                                                                   [ETH1] (345,165)      |
|  DC JACK 12V/10A          VICOR 48V->12V                                                                                     Amphenol Cat8 RJ45    |
|                                                                                                                              40Gbps Shielded Port  |
|  [USB2] (5,190)                                             [U3: QUANTUM AI GPU]                                                                   |
|  TYPE-C EPR 240W                                            (175.00, 170.00) mm                                              [MOD1] (320,140)      |
|  (48V/5A PD 3.1)          [TB5_1] (25,180)                  Custom Nanowire (Rot: 90 deg)                                    Qualcomm SDX90 5G NR  |
|                           Intel Thunderbolt 5               300W TDP / 350W Flux                                             M.2 3052 Key-B Socket |
|  [USB1] (5,170)           (80/120 Gbps)                                                                                                            |
|  TYPE-C EPR 240W                                                                             [M5: HBM3-256GB]                [SIM1] (345,140)      |
|                                                                                              (225.00, 155.00) mm             Nano-SIM Cage         |
|                           [VRM1] (120,150)                                                   Samsung Stacked BGA             (Spring-Loaded)       |
|                           TI TPS53689 VRM                   [COOLERMASTER VC]                819 GB/s Bus                                          |
|                           [Q1] (110,145)                    (120.00 x 80.00) mm                                              [ANT2] (350,160)      |
|                           Infineon OptiMOS                  Graphene Vapor Chamber                                           [ANT1] (350,120)      |
|                           [PMIC1] (100,150)                 1500 W/mK Thermal Core                                           Molex 5G mmWave /     |
|  [TEL1] (5,115)           NXP PF8100 PMIC                                                                                    Sub-6 Dual Connectors |
|  RJ11 56K MODEM                                                                                                                                    |
|  (1500V Isolated)                                                                                                                                  |
|                           +-----------------------+                    +-----------------------+                                                   |
|                           | [U1: CPU CORE]        | === PCIe Gen5 ===> | [U2: DISCRETE GPU]    |                             [WLAN1] (320,85)      |
|  [OPT1] (10,90)           | Intel Core i9-14900HX | <== 100 Ohm Diff = | NVIDIA RTX Ada5090M   |                             Qualcomm FastConnect  |
|  Panasonic Slimline       | (125.00, 120.00) mm   |                    | (225.00, 120.00) mm   |                             7900 (M.2 2230)       |
|  SATA Blu-ray Drive       | BGA-1700 (125W/175W)  |                    | BGA-2400 (250W/300W)  |                             Wi-Fi 7 / BT 5.4 / UWB|
|  (Rot: 90 deg)            +-----------------------+                    +-----------------------+                                                   |
|                                                                                                                              [NFC1] (320,60)       |
|                           [SE1] (80,90)   [OT1] (90,90)    [PLUTON1] (100,90)   [TPM1] (110,90)                              HP 13.56MHz NFC       |
|                           ARM-SE-TZ       OpenTitan RoT    Microsoft Pluton     Infineon TPM 2.0                                                   |
|                           TrustZone       Silicon RoT      Cryptoprocessor      FIPS 140-3 Level 3                                                 |
|                                                                                                                              [SD1] (340,45)        |
|                           [RTC1] (80,75)  [SPI1] (120,75)  [U4: NPU DEDICATED]                                               Micron 2TB SD Express |
|                           Panasonic       Winbond Dual     Intel TOPS45                                                      [SD2] (345,45)        |
|                           VL2330 CMOS     SPI Socket A/B   (175.00, 70.00) mm                                                Amphenol Slot (8.0)   |
|                                                                                                                                                    |
|  +-----------------------------------------------------------------------------------------------------------------------+                         |
|  | [BAT1: QUANTUMSCAPE 480Wh/kg SOLID-STATE BATTERY PACK] (105.00 to 255.00, Y: 20.00 to 120.00) mm                     |                         |
|  | Graphene Solid-State Electrolyte | 11.1V Nominal | SMBus v3.2 Active Telemetry | 30+ Hr Flight Endurance              |                         |
|  +-----------------------------------------------------------------------------------------------------------------------+                         |
|                                                                                                                                                    |
|  +-------------------------------------------------------+                                                                   [FP1] (325,20)        |
|  | AUDIO ISOLATED MOAT (BottomLayer - Star Ground Moat)  |                                                                   Goodix 508 DPI        |
|  |                                                       |                                                                   Sapphire Match-On-Chip|
|  |  [AMP1] (20,25)        [DAC1] (35,35)                 |                     [SUB1] (175,25)                               Fingerprint (9H Mohs) |
|  |  THX AAA-888           ESS SABRE ES9039PRO            |                     Tectonic 15W Sub-Bass                                               |
|  |  Dual-Stage Feed-Fwd   32-Bit 768kHz DAC              |                     Decoupled Transducer                                                |
|  |                                                       |                     (35 Hz - 350 Hz)                                                    |
|  |  [JMP1] (30,50)        [OSC1] (48,25)  [OSC2] (58,25) |                                                                                         |
|  |  Harwin Gold Jumpers   Crystek 45.15M  Crystek 49.15M |                                                                                         |
|  |  (Audio Moat Bridge)   <82fs Jitter    <82fs Jitter   |                                                                                         |
|  |                                                       |                                                                                         |
|  |  [J1] (5,15)           [DSP1] (50,45)                 |                                                                   [SPK2] (335,15)       |
|  |  Amphenol 3.5mm Gold   Lattice ECP5-5G FPGA           |                                                                   Knowles High-Res      |
|  |  Isolated Ground Ring  Dirac Live Room Correction     |                                                                   Right Acoustic Chamber|
|  +-------------------------------------------------------+                                                                                         |
|  [SPK1] (15,15) Knowles High-Res Left Acoustic Chamber                                                                                             |
+----------------------------------------------------------------------------------------------------------------------------------------------------+ [Y = 0.00 mm]
 [X = 0.00 mm]                                                    [X = 180.00 mm]                                                     [X = 360.00 mm]

```


```

Layer ID,Layer Name,Copper Weight,Target Signals & Impedance Class
L1,TopLayer,2.0 oz (70 μm),"BGA Breakout, FastConnect RF Microstrip (50 Ω SE, 85 Ω Diff), DDR5X Escapes"
L2,InnerGround_L2,1.5 oz (52.5 μm),Solid Unbroken RF Reference Ground Plane (Zero-split under high-speed traces)
L3,InnerSignal_L3,1.0 oz (35 μm),"Stripline PCIe Gen5 x16 (100 Ω), HBM3 1024-bit Bus, QSFP-DD 400G PAM4 (85 Ω)"
L4,InnerPower_L4,2.0 oz (70 μm),"Split Power Islands: 1.2V Core (TI VRM), 1.1V Mem, 1.0V QPU, 1.8V GPU Aux"
L5,InnerGround_L5,1.5 oz (52.5 μm),Continuous Interplane Shielding Matrix with 1.0 mm Perimeter Stitching Vias
L6,InnerSignal_L6,1.0 oz (35 μm),"Low-Noise Mixed Signal, AI Hotkey NMI Line, RF Kill Switch EC Interrupt Traces"
L7,InnerPower_L7,2.0 oz (70 μm),"Heavy Copper Power Bus: 48V EPR (Vicor ZVS), 12V Intermediate, 11.1V Battery"
L8,InnerSignal_L8,1.0 oz (35 μm),"Stripline Dual NVMe Gen5 x4 (85 Ω), SD Express 8.0, SATA Differential Bus"
L9,InnerGround_L9,1.5 oz (52.5 μm),Isolated Analog Star Ground Moat (Dedicated return for ESS DAC & Crystek Clocks)
L10,BottomLayer,2.0 oz (70 μm),"Crystek MCLK Traces, THX Feed-Forward Power Traces, Sub-Bass High-Current Lines"

```

```
========================================================================================================================
                                     AEROSPACE GRADE EXTREME PERFORMANCE LAPTOP (v2.9-HIGHEST)
                                                 SYSTEM ARCHITECTURE & SCHEMATIC MAP
========================================================================================================================

 [TOP CHASSIS LID: Monolithic Aluminum 7075-T6 + Corning Gorilla Glass 7 + AUO 16" MicroLED 4K UHD 165Hz Display]
 [CAMERA ARRAY: Sony IMX585 8K Laser-Guided + Omnivision IR Windows Hello + Knowles PDM Microphone Matrix]
------------------------------------------------------------------------------------------------------------------------
 [INTERACTIVE TOP EDGE]
 (25,235)      (35,235)      (45,235)      (55,235)                      (175,235)                  (295,235)      (340,235)
 [WLAN_KILL]   [WWAN_KILL]   [BT_KILL]     [NFC_KILL]                    [CAP TOUCH SLIDER]         [AI_HOTKEY]    [POWER_BTN]
 (NMI Gate)    (NMI Gate)    (NMI Gate)    (NMI Gate)                    (TTP229 Gold Contacts)     (PB-AI-OMNI)   (1.5mm Depth)
------------------------------------------------------------------------------------------------------------------------
 [MEMORY ZONE: Quad-Channel DDR5X-6400 MT/s DIMM Slots]
  +------------------+  +------------------+                        +------------------+  +------------------+
  | [M1: DIMM CH0]   |  | [M2: DIMM CH1]   |                        | [M3: DIMM CH2]   |  | [M4: DIMM CH3]   |
  | (90.00, 215.00)  |  | (140.00, 215.00) |                        | (210.00, 215.00) |  | (260.00, 215.00) |
  +------------------+  +------------------+                        +------------------+  +------------------+
  <-------- Length-Matched ±5 mils -------->                        <-------- Length-Matched ±5 mils -------->

 [HIGH-SPEED I/O LEFT MARGIN]                                        [HIGH-SPEED I/O RIGHT MARGIN]
 [DC1] (5,220)       - Delta 12V/10A DC Barrel Jack                  [OPT_CAGE1] (345,195) - Arista QSFP-DD 400G Cage
 [USB2] (5,190)      - Amphenol USB-C EPR 240V (PD 3.1)              [ETH1] (345,165)      - Amphenol Cat8 RJ45 40Gbps
 [TB5_1] (25,180)    - Intel Thunderbolt 5 (80/120 Gbps)             [MOD1] (320,140)      - Qualcomm SDX90 5G Baseband
 [USB1] (5,170)      - Amphenol USB-C EPR 240V (PD 3.1)              [SIM1] (345,140)      - Nano-SIM Spring Cage
 [TEL1] (5,115)      - Conexant 56K RJ11 Modem (1500V Isolation)     [ANT2] (350,160)      - Molex 5G mmWave/Sub-6 Antenna 2
 [OPT1] (10,90)      - Panasonic Slimline Blu-ray Drive              [ANT1] (350,120)      - Molex 5G mmWave/Sub-6 Antenna 1
                                                                     [WLAN1] (320,85)      - FastConnect 7900 Wi-Fi 7
                                                                     [NFC1] (320,60)       - HP 13.56MHz NFC Module
                                                                     [SD1/SD2] (340/345,45)- Micron 2TB & SD Express
------------------------------------------------------------------------------------------------------------------------
 [CENTRAL COMPUTE & ACCELERATOR CORE]
       +-----------------------+                    +-----------------------+
       | [U1: CPU CORE]        | === PCIe Gen5 ===> | [U2: DISCRETE GPU]    |
       | Intel Core i9-14900HX | <== 100-Ohm Diff = | NVIDIA RTX Ada5090M   |        [M5: HBM3-256GB STACK]
       | (125.00, 120.00) mm   |                    | (225.00, 120.00) mm   |        (225.00, 155.00) mm
       | BGA-1700 (125W/175W)  |                    | BGA-2400 (250W/300W)  |        Samsung 1024-bit Bus (819 GB/s)
       +-----------------------+                    +-----------------------+
                   ||                                           ||
                   \/                                           \/
       +-----------------------+                    +-----------------------+
       | [U4: NPU DEDICATED]   |                    | [U3: QUANTUM AI GPU]  |
       | Intel TOPS45 (45 TOPS)|                    | Custom Nanowire QPU   |
       | (175.00, 70.00) mm    |                    | (175.00, 170.00) mm   |
       +-----------------------+                    +-----------------------+

 [THERMAL & POWER CONVERSION CORE]
   [VRM1] (120,150) - TI TPS53689 Multi-Phase VRM        [COOLERMASTER VAPOR CHAMBER] (120x80x2.0mm)
   [Q1] (110,145)   - Infineon OptiMOS MOSFETs          1500 W/mK Sintered Copper-Graphene Wick
   [PMIC1] (100,150)- NXP PF8100 Multi-Rail PMIC        + Liquid Metal TIM (Thermal Grizzly Conductonaut)
   [DCDC1] (20,210) - Vicor PI3749 48V->12V ZVS         + 7-Blower Dyson Volute Matrix (<28 dBA)

 [SECURITY ROOTS OF TRUST & ENCLAVES]
   [SE1] (80,90)    - ARM-SE-TZ TrustZone Secure Enclave
   [OT1] (90,90)    - LowRISC OpenTitan Discrete Silicon RoT
   [PLUTON1] (100,90)- Microsoft Pluton On-Die Cryptoprocessor
   [TPM1] (110,90)  - Infineon SLB9670 TPM 2.0 (FIPS 140-3 Level 3)
   [SPI1] (120,75)  - Winbond Dual-SPI Socket A/B (W25Q512 Redundant Flash)
   [RTC1] (80,75)   - Panasonic VL2330 CMOS Backup Cell
------------------------------------------------------------------------------------------------------------------------
 [BATTERY INFRASTRUCTURE]
  +------------------------------------------------------------------------------------------------------------------+
  | [BAT1: QUANTUMSCAPE 480Wh/kg SOLID-STATE BATTERY PACK] (X: 105.00 to 255.00, Y: 20.00 to 120.00) mm                |
  | Graphene Solid-State Electrolyte | 11.1V Nominal | SMBus v3.2 Telemetry | 30+ Hr Endurance | 3000+ Cycles            |
  +------------------------------------------------------------------------------------------------------------------+
------------------------------------------------------------------------------------------------------------------------
 [STUDIO ACOUSTIC ENGINE (BottomLayer - Isolated Ground Moat)]
  [SPK1] (15,15) Knowles High-Res Speaker (Left)     [SUB1] (175,25) Tectonic 15W Decoupled Sub-Bass Driver (35Hz-350Hz)
  [AMP1] (20,25) THX AAA-888 Dual-Stage Amp          [JMP1] (30,50) Harwin Gold Jumpers (J1 Analog Moat Bridge)
  [DAC1] (35,35) ESS SABRE ES9039PRO 32-Bit DAC      [DSP1] (50,45) Lattice FPGA Dirac Live Room Correction
  [OSC1] (48,25) Crystek 45.1584MHz Master Clock     [OSC2] (58,25) Crystek 49.1520MHz Master Clock (<82fs Jitter)
  [J1] (5,15)    Amphenol Shielded 3.5mm Jack        [SPK2] (335,15) Knowles High-Res Speaker (Right)
  [FP1] (325,20) Goodix 508 DPI Sapphire Match-On-Chip Fingerprint Sensor (9H Hardness)
========================================================================================================================

```

```

====================================================================================================
 TOP: Corning Gorilla Glass 7 (0.7mm) + AUO 16" MicroLED Panel (3.5mm) [3840x2160 @ 165Hz]
----------------------------------------------------------------------------------------------------
 THERMAL INTERFACE: Thermal Grizzly Conductonaut Liquid Metal (73 W/mK, <0.01 K/W)
 CONTAINMENT: Dual Fluorosilicone Laser-Cut Gasket Compression Rings (0.40mm Height)
----------------------------------------------------------------------------------------------------
 COLD PLATE: Oxygen-Free Copper C11000 (390 W/mK, 0.05um Ra Flatness)
 VAPOR CHAMBER: CoolerMaster Graphene Sintered Wick (120x80x2.0mm, 1500 W/mK, 300W Load)
----------------------------------------------------------------------------------------------------
 BLOWER ARRAY: 3x Large 80mm Rear + 3x Medium 60mm Flank + 1x Ionic Micro Bladeless (<28 dBA)
----------------------------------------------------------------------------------------------------
 BOARD SUBSTRATE: 10-Layer Rogers RO4003C Ceramic Hydrocarbon (1.60mm Finished Board Thickness)
 MICROVIAS: Laser Blind/Buried (0.100mm Drill, 0.220mm Pad, VIPPO Copper Filled)
 BACKDRILL: Controlled Depth Stub Removal on PCIe Gen5 / QSFP-DD 400G (Max Residual Stub <= 0.100mm)
----------------------------------------------------------------------------------------------------
 BASE: Monolithic Aerospace Aluminum 7075-T6 CNC Unibody (MIL-A-8625 Type III DLC Finish)
 HINGES: Dual Titanium Ti-6Al-4V Grade 5 Dual-Axis Mechanisms (Torque: 1.40 N*m, 50,000 Cycles)
====================================================================================================

```
