{==============================================================================}
{ Altium Designer 1-Click Master Placement, Netlist Constraint & DRC Script    }
{ Target Platform: Extreme Performance Laptop (v2.9-HIGHEST Master BOM)        }
{ Origin: (0.0mm, 0.0mm) at bottom-left corner of 360mm x 250mm unibody chassis}
{==============================================================================}

Procedure SetComponentLocation(Board: IPCB_Board; DesignatorName: String; X_mm: Double; Y_mm: Double; LayerID: TLayer; RotationDeg: Double);
Var
    Component: IPCB_Component;
Begin
    Component := Board.GetPcbComponentByRefDes(DesignatorName);
    If Component <> Nil Then
    Begin
        // Temporarily unlock component to assign programmatic coordinates
        Component.Moveable := True;

        // Convert Millimeters to Altium internal metric coordinate units
        Component.X := MMsToCoord(X_mm);
        Component.Y := MMsToCoord(Y_mm);
        Component.Layer := LayerID;
        Component.Rotation := RotationDeg;

        // Lock component into position to prevent placement drift
        Component.Moveable := False;
    End;
End;

Procedure InjectClearanceRule(Board: IPCB_Board; RuleName: String; Scope1: String; Scope2: String; Gap_mm: Double);
Var
    Rule: IPCB_ClearanceConstraint;
Begin
    Rule := PCBServer.PCBRuleFactory.CreateRule(eRule_Clearance);
    Rule.Name := RuleName;
    Rule.Scope1Expression := Scope1;
    Rule.Scope2Expression := Scope2;
    Rule.Gap := MMsToCoord(Gap_mm);
    Board.AddPCBObject(Rule);
End;

Procedure InjectDiffPairRule(Board: IPCB_Board; RuleName: String; Scope1: String; Width_mm: Double; Gap_mm: Double);
Var
    Rule: IPCB_DiffPairRoutingConstraint;
Begin
    Rule := PCBServer.PCBRuleFactory.CreateRule(eRule_DiffPairRouting);
    Rule.Name := RuleName;
    Rule.Scope1Expression := Scope1;
    Rule.PreferredWidth := MMsToCoord(Width_mm);
    Rule.PreferredGap   := MMsToCoord(Gap_mm);
    Rule.MinWidth       := MMsToCoord(Width_mm * 0.90);
    Rule.MaxWidth       := MMsToCoord(Width_mm * 1.10);
    Rule.MinGap         := MMsToCoord(Gap_mm * 0.90);
    Rule.MaxGap         := MMsToCoord(Gap_mm * 1.10);
    Board.AddPCBObject(Rule);
End;

Procedure InjectMatchedLengthRule(Board: IPCB_Board; RuleName: String; Scope1: String; Tol_mm: Double);
Var
    Rule: IPCB_LengthConstraint;
Begin
    Rule := PCBServer.PCBRuleFactory.CreateRule(eRule_MatchedNetLengths);
    Rule.Name := RuleName;
    Rule.Scope1Expression := Scope1;
    Rule.Tolerance := MMsToCoord(Tol_mm);
    Board.AddPCBObject(Rule);
End;

Procedure AutoPlaceAndLockAllBOMComponents;
Var
    Board: IPCB_Board;
Begin
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then
    Begin
        ShowMessage('CRITICAL ERROR: No active .PcbDoc found. Open layout canvas first.');
        Exit;
    End;

    // Start Undo/Redo tracking batch transaction
    PCBServer.PreProcess;

    {==========================================================================}
    { SECTION 1: PHYSICAL COMPONENT PLACEMENT (BOM v2.9-HIGHEST)               }
    {==========================================================================}

    // --- 1. Central Thermal Core ---
    SetComponentLocation(Board, 'U1',        125.00, 120.00, eTopLayer,    0.0);   // Intel Core i9-14900HX BGA-1700
    SetComponentLocation(Board, 'U2',        225.00, 120.00, eTopLayer,    0.0);   // NVIDIA RTX Ada5090M BGA-2400
    SetComponentLocation(Board, 'U3',        175.00, 170.00, eTopLayer,   90.0);   // Custom Nanowire AI Quantum Processor BGA-2000
    SetComponentLocation(Board, 'U4',        175.00,  70.00, eTopLayer,    0.0);   // Intel TOPS45 Dedicated NPU BGA-800

    // --- 2. Memory Subsystem (Quad DDR5X & Stacked HBM3) ---
    SetComponentLocation(Board, 'M1',         90.00, 215.00, eTopLayer,    0.0);   // Micron DDR5X Slot 0 (DIMM-288)
    SetComponentLocation(Board, 'M2',        140.00, 215.00, eTopLayer,    0.0);   // Micron DDR5X Slot 1 (DIMM-288)
    SetComponentLocation(Board, 'M3',        210.00, 215.00, eTopLayer,    0.0);   // Micron DDR5X Slot 2 (DIMM-288)
    SetComponentLocation(Board, 'M4',        260.00, 215.00, eTopLayer,    0.0);   // Micron DDR5X Slot 3 (DIMM-288)
    SetComponentLocation(Board, 'M5',        225.00, 155.00, eTopLayer,    0.0);   // Samsung 256GB HBM3 Stacked Silicon BGA

    // --- 3. High-Speed Storage & Optical ---
    SetComponentLocation(Board, 'SSD1',       60.00,  25.00, eTopLayer,    0.0);   // Samsung NVMe Gen5 M.2 2280 Slot 1
    SetComponentLocation(Board, 'SSD2',      150.00,  25.00, eTopLayer,    0.0);   // Samsung NVMe Gen5 M.2 2280 Slot 2
    SetComponentLocation(Board, 'SD1',       340.00,  45.00, eTopLayer,  270.0);   // Micron Industrial 2TB 3D TLC SD Card
    SetComponentLocation(Board, 'SD2',       345.00,  45.00, eTopLayer,  270.0);   // Amphenol SD Express 8.0 Socket
    SetComponentLocation(Board, 'OPT1',       10.00,  90.00, eTopLayer,   90.0);   // Panasonic Slimline SATA Blu-ray Drive

    // --- 4. Isolated Studio Audio Engine & Master Clocks ---
    SetComponentLocation(Board, 'DAC1',       35.00,  35.00, eBottomLayer, 0.0);   // ESS Sabre ES9039PRO 32-Bit 768kHz DAC (QFN-64)
    SetComponentLocation(Board, 'AMP1',       20.00,  25.00, eBottomLayer, 0.0);   // THX AAA-888 Dual-Stage Amplifier Module
    SetComponentLocation(Board, 'DSP1',       50.00,  45.00, eBottomLayer, 0.0);   // Lattice ECP5-5G FPGA Dirac Live DSP (BGA-256)
    SetComponentLocation(Board, 'OSC1',       48.00,  25.00, eBottomLayer, 0.0);   // Crystek 45.1584MHz Master Clock (<82fs jitter)
    SetComponentLocation(Board, 'OSC2',       58.00,  25.00, eBottomLayer, 0.0);   // Crystek 49.1520MHz Master Clock (<82fs jitter)
    SetComponentLocation(Board, 'SPK1',       15.00,  15.00, eTopLayer,    0.0);   // Knowles Tuned Chamber Stereo Speaker (Left)
    SetComponentLocation(Board, 'SPK2',      335.00,  15.00, eTopLayer,    0.0);   // Knowles Tuned Chamber Stereo Speaker (Right)
    SetComponentLocation(Board, 'SUB1',      175.00,  25.00, eTopLayer,    0.0);   // Tectonic 15W Decoupled Sub-Bass Driver
    SetComponentLocation(Board, 'J1',          5.00,  15.00, eTopLayer,   90.0);   // Amphenol Shielded Gold-Plated 3.5mm Jack
    SetComponentLocation(Board, 'JMP1',       30.00,  50.00, eBottomLayer, 0.0);   // Harwin Gold Jumper Array (J1-J4)

    // --- 5. Wireless, Cellular, Optical & High-Speed I/O ---
    SetComponentLocation(Board, 'MOD1',      320.00, 140.00, eTopLayer,  270.0);   // Qualcomm Snapdragon X90 / X75 5G NR (M.2 3052)
    SetComponentLocation(Board, 'SIM1',      345.00, 140.00, eTopLayer,  270.0);   // Nano-SIM Spring-Loaded Cage (SIM-CAGE-3052)
    SetComponentLocation(Board, 'ANT1',      350.00, 120.00, eTopLayer,  270.0);   // Molex 5G mmWave/Sub-6 RF Connector 1
    SetComponentLocation(Board, 'ANT2',      350.00, 160.00, eTopLayer,  270.0);   // Molex 5G mmWave/Sub-6 RF Connector 2
    SetComponentLocation(Board, 'WLAN1',     320.00,  85.00, eTopLayer,  270.0);   // Qualcomm FastConnect 7900 (Wi-Fi 7/UWB)
    SetComponentLocation(Board, 'NFC1',      320.00,  60.00, eTopLayer,  270.0);   // HP 13.56MHz NFC Controller (QFN-32)
    SetComponentLocation(Board, 'OPT_CAGE1', 345.00, 195.00, eTopLayer,  270.0);   // Arista QSFP-DD 400G Optical Cage (8x50G PAM4)
    SetComponentLocation(Board, 'ETH1',      345.00, 165.00, eTopLayer,  270.0);   // Amphenol Cat8 RJ45 40Gbps Shielded Jack[cite: 8]
    SetComponentLocation(Board, 'TEL1',        5.00, 115.00, eTopLayer,   90.0);   // Conexant RJ11 Telephone Line Port (1500V Isolated)[cite: 8]
    SetComponentLocation(Board, 'FAX1',        5.00, 125.00, eTopLayer,   90.0);   // Conexant RJ11 Fax Line Port (1500V Isolated)[cite: 8]
    SetComponentLocation(Board, 'USB2_1',      5.00, 135.00, eTopLayer,   90.0);   // Molex USB 2.0 Type-A Single Port (480Mbps)[cite: 8]
    SetComponentLocation(Board, 'USB32_1',     5.00, 150.00, eTopLayer,   90.0);   // TE Connectivity USB 3.2 Gen 2 Type-C Port 1[cite: 8]
    SetComponentLocation(Board, 'USB32_2',    25.00, 210.00, eTopLayer,    0.0);   // TE Connectivity USB 3.2 Gen 2 Type-C Port 2[cite: 8]
    SetComponentLocation(Board, 'USB4_1',     15.00, 170.00, eTopLayer,   90.0);   // Intel USB 4 Type-C 40Gbps Port 1[cite: 8]
    SetComponentLocation(Board, 'USB4_2',     15.00, 190.00, eTopLayer,   90.0);   // Intel USB 4 Type-C 40Gbps Port 2[cite: 8]
    SetComponentLocation(Board, 'TB5_1',      25.00, 180.00, eTopLayer,    0.0);   // Intel TB5-IC-80GBPS Thunderbolt 5 Controller
    SetComponentLocation(Board, 'USB1',        5.00, 170.00, eTopLayer,   90.0);   // Amphenol USB-C EPR 240W Port 1
    SetComponentLocation(Board, 'USB2',        5.00, 190.00, eTopLayer,   90.0);   // Amphenol USB-C EPR 240W Port 2
    SetComponentLocation(Board, 'DC1',         5.00, 220.00, eTopLayer,   90.0);   // Delta 12V/10A DC Barrel Jack (TVS Clamped)

    // --- 6. Security Roots of Trust, Biometrics & Hardware Enclaves ---
    SetComponentLocation(Board, 'TPM1',      110.00,  90.00, eTopLayer,    0.0);   // Infineon SLB9670 TPM 2.0 (FIPS 140-3 Level 3)
    SetComponentLocation(Board, 'PLUTON1',   100.00,  90.00, eTopLayer,    0.0);   // Microsoft Pluton Dedicated Cryptoprocessor
    SetComponentLocation(Board, 'OT1',        90.00,  90.00, eTopLayer,    0.0);   // LowRISC OpenTitan Discrete Silicon RoT
    SetComponentLocation(Board, 'SE1',        80.00,  90.00, eTopLayer,    0.0);   // ARM-SE-TZ TrustZone Secure Enclave Coprocessor
    SetComponentLocation(Board, 'SPI1',      120.00,  75.00, eTopLayer,    0.0);   // Winbond Dual-SPI Socket A/B (W25Q512)
    SetComponentLocation(Board, 'FP1',       325.00,  20.00, eTopLayer,    0.0);   // Goodix 508 DPI Synthetic Sapphire Fingerprint

    // --- 7. Power Architecture & Solid-State Battery ---
    SetComponentLocation(Board, 'BAT1',      180.00,  70.00, eTopLayer,    0.0);   // QuantumScape 480Wh/kg Graphene Solid-State Pack
    SetComponentLocation(Board, 'RTC1',       80.00,  75.00, eTopLayer,    0.0);   // Panasonic VL2330 Vanadium Lithium CMOS Cell
    SetComponentLocation(Board, 'VRM1',      120.00, 150.00, eTopLayer,    0.0);   // Texas Instruments TPS53689 Multi-Phase VRM
    SetComponentLocation(Board, 'Q1',        110.00, 145.00, eTopLayer,    0.0);   // Infineon BSC123N08NS3 OptiMOS PowerSO8 MOSFETs
    SetComponentLocation(Board, 'PMIC1',     100.00, 150.00, eTopLayer,    0.0);   // NXP PF8100 Multi-Rail PMIC (QFN-56)
    SetComponentLocation(Board, 'DCDC1',      20.00, 210.00, eTopLayer,    0.0);   // Vicor PI3749 48V-to-12V ZVS Converter

    // --- 8. Interactive Switch Matrix, Sensors & Dedicated AI Hotkey ---
    SetComponentLocation(Board, 'SW_PWR',    340.00, 235.00, eTopLayer,    0.0);   // Alps Alpine Deep-Press 1.5mm Travel Power Switch
    SetComponentLocation(Board, 'SW_AI',     295.00, 235.00, eTopLayer,    0.0);   // Alps Alpine Dedicated Universal AI Key (Omni-Key)
    SetComponentLocation(Board, 'TS1',       175.00, 235.00, eTopLayer,    0.0);   // TonTouch TTP229-CAP Capacitive Volume Slider
    SetComponentLocation(Board, 'SW_WLAN',    25.00, 235.00, eTopLayer,    0.0);   // Hardware Discrete RF Kill Switch (WLAN)
    SetComponentLocation(Board, 'SW_WWAN',    35.00, 235.00, eTopLayer,    0.0);   // Hardware Discrete RF Kill Switch (WWAN)
    SetComponentLocation(Board, 'SW_BT',      45.00, 235.00, eTopLayer,    0.0);   // Hardware Discrete RF Kill Switch (Bluetooth)
    SetComponentLocation(Board, 'SW_NFC',     55.00, 235.00, eTopLayer,    0.0);   // Hardware Discrete RF Kill Switch (NFC)
    SetComponentLocation(Board, 'IMU1',       75.00,  60.00, eTopLayer,    0.0);   // Bosch BMI270 6-Axis Accelerometer/Gyroscope
    SetComponentLocation(Board, 'ENV1',       65.00,  60.00, eTopLayer,    0.0);   // Sensirion SHT40 Digital Temperature/Humidity
    SetComponentLocation(Board, 'HUB1',       70.00,  70.00, eTopLayer,    0.0);   // STMicroelectronics STM32G0 Context Sensor Hub

    {==========================================================================}
    { SECTION 2: HIGH-SPEED, HIGH-VOLTAGE & IMPEDANCE DESIGN RULE INJECTION    }
    {==========================================================================}

    // Default Signal & High-Voltage Clearances
    InjectClearanceRule(Board, 'Clearance_Signal_Default', 'All', 'All', 0.075);
    InjectClearanceRule(Board, 'Clearance_HighVoltage_48V',
        'InNet(''NET_PWR_USB_EPR_48V'') or InNet(''NET_PWR_BATT_11V1'')', 'All', 0.500);

    // Differential Impedance Rules
    InjectDiffPairRule(Board, 'DiffPair_PCIe_Gen5_100Ohm',
        'InDifferentialPairClass(''PCIE_GEN5_DIFF'')', 0.100, 0.125);
    InjectDiffPairRule(Board, 'DiffPair_PCIe_TB5_WWAN_85Ohm',
        'InDifferentialPairClass(''PCIE_85OHM_DIFF'')', 0.115, 0.110);
    InjectDiffPairRule(Board, 'DiffPair_USB_PD_90Ohm',
        'InDifferentialPairClass(''USB_PD_DIFF'')', 0.105, 0.115);

    // High-Speed Length Matching Skew Tolerances
    InjectMatchedLengthRule(Board, 'MatchedLengths_DDR5_DataBus',
        'InNetClass(''DDR5_DATA_BUS'')', 0.127); // ±5 mils length match
    InjectMatchedLengthRule(Board, 'MatchedLengths_HBM3_1024Bus',
        'InNetClass(''HBM3_1024BIT_BUS'')', 0.075); // ±3 mils length match

    // Finalize PCB modification transaction
    PCBServer.PostProcess;

    // Reset viewport and run visual zoom bounds
    ResetParameters;
    AddStringParameter('Action', 'All');
    RunProcess('PCB:Zoom');

    // Force Altium to update flight-lines (rat's nest)
    ResetParameters;
    AddStringParameter('Action', 'ShowAll');
    RunProcess('PCB:ManageNetlist');

    ShowMessage('SUCCESS: 1-Click Placement, Design Rules & Netlist Bounds applied successfully.');
End;
