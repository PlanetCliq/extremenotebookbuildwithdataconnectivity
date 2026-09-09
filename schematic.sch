(EXPERT_MASTER_SCHEMATIC
  (VERSION 2.9-HIGHEST)
  (TITLE "Extreme Performance Laptop - Aerospace Grade Schematic (Fully Consolidated)")

  ;; =========================================================================
  ;; 1. Core Power Domains & Low-Dropout Regulators
  ;; =========================================================================
  (NET NET_PWR_CORE_1V2
    (SOURCE VRM_TI_TPS.VOUT)
    (LOAD CPU_INTEL_I9_14900HX.VCC_CORE,
          GPU_NVIDIA_ADA5090M.VCC_CORE,
          GPU_NANOWIRE_AI_QUANTUM.VCC_CORE,
          NPU_INTEL_TOPS45.VCC_CORE)
    (DECOUPLING "100nF per BGA power pin, low-ESR bulk polymer capacitors placed within 1.5mm of die perimeter")
    (RULE "Target PDN impedance <0.5Ω up to 500MHz; transient response <50mV droop under 200A step load")
  )
  (NET NET_PWR_MEM_1V1
    (SOURCE VRM_TI_TPS.VOUT_MEM)
    (LOAD MEMORY_DDR5X_MICRON[DIMM0..DIMM3].VDD)
    (DECOUPLING "100nF per pin, distributed across four DIMM sockets, staggered microvia fanout")
    (RULE "Fly-by power routing; length matched to ±0.127mm with clock pairs")
  )
  (NET NET_PWR_HBM
    (SOURCE VRM_TI_TPS.VOUT_HBM)
    (LOAD MEMORY_HBM3_STACK.VDD)
    (DECOUPLING "220nF per stack landing; low-profile reverse-geometry capacitors directly underneath BGA")
    (RULE "Flux 200W sustained; localized power-island temperature monitored continuously")
  )
  (NET NET_PWR_GPU_1V8
    (SOURCE MOSFET_INFINEON_OPTIMOS.DRAIN)
    (LOAD GPU_NVIDIA_ADA5090M.VDD_AUX)
    (RULE "Low-ESR capacitors within 2mm of pins; dedicated continuous ground return plane directly adjacent")
  )
  (NET NET_PWR_BATT_11V1
    (SOURCE SOLID_STATE_BATTERY.VBAT)
    (LOAD SYSTEM_DC_RAILS, DC_DC_CONVERTER.VIN)
    (RULE "Active SMBus v3.2 battery telemetry; bidirectional surge and transient suppression clamp applied")
  )
  (NET NET_PWR_CMOS
    (SOURCE CMOS_BATTERY.VBAT)
    (LOAD CPU_INTEL_I9_14900HX.RTC_VCC, SYSTEM_EC.RTC_VCC)
    (RULE "Ultra-low leakage diode isolation circuit; maintains real-time clock retention down to 1.8V")
  )
  (NET NET_PWR_IO_3V3
    (SOURCE PMIC_NXP.VOUT_3V3)
    (LOAD NFC_MODULE_HP.VCC,
          THUNDERBOLT5_CONTROLLER.VCC,
          TPM_INFINEON.VCC,
          SD_EXPRESS_SLOT.VCC,
          WWAN_MODULE_QUALCOMM_X90.VCC,
          WWAN_X75_MODULE.VCC,
          WIFI7_BT_QUALCOMM_FASTCONNECT.VCC,
          INDUSTRIAL_SD_CARD.VCC,
          SENSOR_FUSION_CONTROLLER.VCC)
    (DECOUPLING "100nF local decoupling on every supply pin; surface-mount ferrite beads for high-frequency isolation")
  )
  (NET NET_PWR_USB_EPR_48V
    (SOURCE PORT_USB_PD[0..1].VBUS)
    (LOAD DC_DC_CONVERTER.VIN_48V)
    (RULE "EPR 240W 48V/5A bidirectional power negotiation compliant with USB-PD 3.1 specification")
  )
  (NET NET_PWR_DC_12V
    (SOURCE DC_JACK.VCC)
    (LOAD VRM_TI_TPS.VIN, SYSTEM_DC_RAILS)
    (RULE "12V/10A DC input; TVS overvoltage suppression diode and reverse-polarity P-channel MOSFET gate")
  )
  (NET NET_PWR_AUDIO_3V3
    (SOURCE PMIC_NXP.VOUT_LDO_A3V3)
    (LOAD DAC_ESS_SABRE_ES9039PRO.AVDD,
          DSP_DIRAC_LIVE.VCC,
          OSCILLATOR_AUDIO_PRIMARY.VCC,
          OSCILLATOR_AUDIO_SECONDARY.VCC)
    (DECOUPLING "47nF ceramic caps + ultra-low-noise TPS7A-series LDO post-regulation; ripple <2µV RMS")
  )
  (NET NET_PWR_AUDIO_5V
    (SOURCE PMIC_NXP.VOUT_5V)
    (LOAD AMP_THX_AAA888.VCC)
    (DECOUPLING "100nF local decoupling; dedicated LC Pi-filter on analog amplifier rail")
  )
  (NET NET_PWR_FAN_5V
    (SOURCE PMIC_NXP.VOUT_FAN)
    (LOAD DYSON_BLOWER_LARGE[0..2].VCC,
          DYSON_BLOWER_MEDIUM[0..2].VCC,
          BLADELESS_IONIC_BLOWER.VCC)
    (DECOUPLING "47nF filter caps per blower header; soft-start inrush current limiter")
  )
  (NET NET_PWR_DISPLAY_12V
    (SOURCE SYSTEM_DC_RAILS)
    (LOAD DISPLAY_MICROLED.VCC)
    (DECOUPLING "220nF bulk array with high-frequency EMI common-mode suppression choke")
  )
  (NET NET_PWR_STORAGE_5V
    (SOURCE PMIC_NXP.VOUT_5V_SEC)
    (LOAD BLU_RAY_BWD_DRIVE.VCC)
    (RULE "Current-limited power switch with active thermal shutdown")
  )

  ;; =========================================================================
  ;; 2. High-Speed Stripline & Microstrip Differential Pairs
  ;; =========================================================================
  (NET NET_PCIE_GPU
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX[0..15] -> GPU_NVIDIA_ADA5090M.PCIe_RX[0..15])
    (CONNECTION GPU_NVIDIA_ADA5090M.PCIe_TX[0..15] -> CPU_INTEL_I9_14900HX.PCIe_RX[0..15])
    (RULE "PCIe Gen5 32GT/s; intra-pair skew ≤0.15mm; inter-pair skew ≤1.25mm; jitter budget <0.15UI; backdrilled stubs")
  )
  (NET NET_DDR5_BUS
    (WIDTH "128 bits")
    (CONNECTION CPU_INTEL_I9_14900HX.DDR5_CTRL -> MEMORY_DDR5X_MICRON[DIMM0..DIMM3].DATA[0..127])
    (RULE "Single-ended 50Ω, differential clock 100Ω; length match ±0.127mm across all 4 DIMMs; fly-by topology")
  )
  (NET NET_HBM_STACK
    (WIDTH "1024 bits")
    (CONNECTION GPU_NVIDIA_ADA5090M.HBM_CTRL -> MEMORY_HBM3_STACK.CTRL)
    (RULE "819 GB/s bandwidth; single-ended 45Ω, differential 85Ω; length matched to ±0.075mm; flux validated")
  )
  (NET NET_NVME_GEN5
    (DIFF_PAIR TRUE IMPEDANCE "85Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_CTRL[0..7] -> NVMe_GEN5_SSD[0..1].PCIe_LANE[0..3])
    (RULE "PCIe Gen5 x4 per slot; 14GB/s throughput; stripline routing on Layer 8; controlled depth backdrill")
  )
  (NET NET_PCIE_TB5
    (DIFF_PAIR TRUE IMPEDANCE "85Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX[16..19] -> THUNDERBOLT5_CONTROLLER.PCIe_RX[0..3])
    (CONNECTION THUNDERBOLT5_CONTROLLER.PCIe_TX[0..3] -> CPU_INTEL_I9_14900HX.PCIe_RX[16..19])
    (RULE "PAM3 signaling; 80Gbps bidirectional / 120Gbps boost; skew ≤3ps; low-capacitance ESD protection array")
  )
  (NET NET_PCIE_WWAN
    (DIFF_PAIR TRUE IMPEDANCE "85Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX[20..21] -> WWAN_MODULE_QUALCOMM_X90.PCIe_RX[0..1])
    (CONNECTION WWAN_MODULE_QUALCOMM_X90.PCIe_TX[0..1] -> CPU_INTEL_I9_14900HX.PCIe_RX[20..21])
    (RULE "PCIe Gen3 x2 link; shielded routing channel with via fence stitching every 1.5mm")
  )
  (NET NET_PCIE_WIFI
    (DIFF_PAIR TRUE IMPEDANCE "85Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.PCIe_TX[22] -> WIFI7_BT_QUALCOMM_FASTCONNECT.PCIe_RX)
    (CONNECTION WIFI7_BT_QUALCOMM_FASTCONNECT.PCIe_TX -> CPU_INTEL_I9_14900HX.PCIe_RX[22])
    (RULE "PCIe Gen4 x1 link; FastConnect 7900 Wi-Fi 7 / BT 5.4 / UWB high-throughput channel")
  )
  (NET NET_QSFP_FR4
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION QSFP_DD_400G_FR4 -> NETWORK_BACKPLANE)
    (RULE "400G FR4 8x50G PAM4 optical interconnect; skew budget ≤5ps; differential insertion loss <-12dB @ 26GHz")
  )
  (NET NET_QSFP_ZR
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION QSFP_DD_400G_ZR -> NETWORK_BACKPLANE)
    (RULE "400G ZR coherent optics; reach 120km; total jitter <0.15UI")
  )
  (NET NET_QSFP_ZR_PLUS
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION QSFP_DD_400G_ZR_PLUS -> NETWORK_BACKPLANE)
    (RULE "400G ZR+ amplified DWDM link; reach >1000km; impedance matched 100Ω differential")
  )
  (NET NET_QSFP_PORTS
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION QSFP_DD_PORT_MOLEX.TX[0..7] -> NETWORK_BACKPLANE.TX[0..7])
    (CONNECTION QSFP_DD_PORT_MOLEX.RX[0..7] -> NETWORK_BACKPLANE.RX[0..7])
    (RULE "400G optical lines; 8-channel differential signaling; metal chassis grounding fingers fully engaged")
  )
  (NET NET_ETHERNET_CAT8
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.ETH_CTRL -> ETHERNET_PORT_CAT8)
    (RULE "40Gbps RJ45 shielded; 2000MHz bandwidth; differential pair isolation with grounded shield guard traces")
  )
  (NET NET_USB4_V2
    (DIFF_PAIR TRUE IMPEDANCE "90Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.USB_CTRL -> USB4_V2_PORT[0..1])
    (RULE "120Gbps asymmetric / 80Gbps symmetric; ESD protection diodes placed immediately at connector pins")
  )
  (NET NET_SATA_BUS
    (DIFF_PAIR TRUE IMPEDANCE "100Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.SATA_CTRL -> BLU_RAY_BWD_DRIVE)
    (RULE "SATA Revision 3.0 6Gbps; differential signaling with DC blocking capacitors")
  )
  (NET NET_SD_EXPRESS
    (DIFF_PAIR TRUE IMPEDANCE "85Ω differential")
    (CONNECTION CPU_INTEL_I9_14900HX.SD_CTRL -> SD_EXPRESS_SLOT)
    (CONNECTION SD_EXPRESS_SLOT -> INDUSTRIAL_SD_CARD)
    (RULE "SD Express 8.0 PCIe Gen4 x1; 985MB/s throughput; shielded routing on Layer 8")
  )

  ;; =========================================================================
  ;; 3. Studio Audio, Clocking & Acoustic Interconnects
  ;; =========================================================================
  (NET NET_AUDIO_MCLK_45M
    (CONNECTION OSCILLATOR_AUDIO_PRIMARY.CLK_OUT -> DAC_ESS_SABRE_ES9039PRO.MCLK1)
    (RULE "Crystek 45.1584MHz ultra-low phase noise master clock (<82fs jitter); length matched, surrounded by solid ground copper")
  )
  (NET NET_AUDIO_MCLK_49M
    (CONNECTION OSCILLATOR_AUDIO_SECONDARY.CLK_OUT -> DAC_ESS_SABRE_ES9039PRO.MCLK2)
    (RULE "Crystek 49.1520MHz ultra-low phase noise master clock (<82fs jitter); length matched, surrounded by solid ground copper")
  )
  (NET NET_AUDIO_BUS
    (CONNECTION DAC_ESS_SABRE_ES9039PRO.I2S_IN -> DSP_DIRAC_LIVE.AUDIO_IN)
    (RULE "32-bit / 768kHz multi-channel I2S digital audio bus; clock skew compensation applied")
  )
  (NET NET_AUDIO_OUT
    (CONNECTION DSP_DIRAC_LIVE.AUDIO_OUT -> AMP_THX_AAA888.IN)
    (RULE "Balanced differential audio stream; THD+N ≤ -120dB; isolated analog routing on Layer 10")
  )
  (NET NET_AUDIO_SPK_L
    (CONNECTION AMP_THX_AAA888.OUT_SPK_L -> AUDIO_SPEAKER_STEREO_PAIR[0].INPUT)
    (RULE "High-current analog speaker trace (width ≥1.0mm); Knowles 5W 4Ω tuned chamber connection")
  )
  (NET NET_AUDIO_SPK_R
    (CONNECTION AMP_THX_AAA888.OUT_SPK_R -> AUDIO_SPEAKER_STEREO_PAIR[1].INPUT)
    (RULE "High-current analog speaker trace (width ≥1.0mm); Knowles 5W 4Ω tuned chamber connection")
  )
  (NET NET_AUDIO_SUB_BASS
    (CONNECTION AMP_THX_AAA888.OUT_SUB -> AUDIO_SUB_BASS_TRANSDUCER.INPUT)
    (RULE "Differential sub-bass drive rail; Tectonic 15W 4Ω low-frequency driver (35Hz-350Hz); trace resistance <0.05Ω")
  )
  (NET NET_HEADPHONE_OUT
    (CONNECTION AMP_THX_AAA888.OUT_HP -> AUDIO_JACK_3.5MM.L/R)
    (RULE "Low-noise headphone drive; gold-plated contacts; separate ground return trace back to audio star point")
  )
  (NET NET_BT_AUDIO
    (CONNECTION WIFI7_BT_QUALCOMM_FASTCONNECT.PCM_I2S -> DAC_ESS_SABRE_ES9039PRO.I2S_AUX)
    (RULE "Snapdragon Sound aptX Lossless bit-exact CD audio pipeline (16-bit 44.1kHz / 24-bit 96kHz)")
  )

  ;; =========================================================================
  ;; 4. Hardware Security, Biometrics & Hardware Kill Switches
  ;; =========================================================================
  (NET NET_TPM_BUS
    (CONNECTION TPM_INFINEON.LPC_BUS -> CPU_INTEL_I9_14900HX.LPC_CTRL)
    (RULE "FIPS 140-3 Level 3 hardware root of trust; encrypted cryptographic bus transaction")
  )
  (NET NET_PLUTON_SPI
    (CONNECTION PLUTON_SEC_CHIP.SPI_BUS -> CPU_INTEL_I9_14900HX.SPI_CTRL)
    (RULE "Encrypted SPI bus validation; hardware platform attestation; active anti-rollback protection")
  )
  (NET NET_SEC_CTRL
    (CONNECTION OPEN_TITAN_ROOT_OF_TRUST.CTRL -> SYSTEM_SECURITY_MANAGER,
                SECURE_ENCLAVE_COPROCESSOR.CTRL -> SYSTEM_SECURITY_MANAGER)
    (RULE "Silicon-level cryptographic verification; ARM TrustZone active; anti-tamper latch monitored")
  )
  (NET NET_EEPROM_FLASH
    (CONNECTION CPU_INTEL_I9_14900HX.SPI_CTRL -> EEPROM_FLASH_DEBUG_SOCKET)
    (RULE "Dual BIOS/firmware redundancy; automatic golden recovery fallback via hardware watchdogs")
  )
  (NET NET_FINGERPRINT_SPI
    (CONNECTION FINGERPRINT_SENSOR.SPI -> SECURE_ENCLAVE_COPROCESSOR.SPI_SECURE)
    (CONNECTION FINGERPRINT_SENSOR.IRQ -> SYSTEM_EC.GPIO_FP_IRQ)
    (RULE "Goodix 508 DPI match-on-chip encrypted pipe directly terminated in ARM-SE-TZ hardware enclave")
  )
  (NET NET_AI_HOTKEY_TRIGGER
    (CONNECTION PROGRAMMABLE_AI_HOTKEY.PIN -> SYSTEM_EC.GPIO_AI_KEY_IRQ)
    (RULE "Non-maskable instant wake interrupt to Embedded Controller; direct hardware trigger for Gemini, Claude, Grok, or local ONNX models")
  )
  (NET NET_HW_JUMPER_CFG
    (CONNECTION HW_CONFIG_JUMPERS -> SYSTEM_EC.GPIO_STRAP_PINS)
    (RULE "Harwin gold micro-jumpers: J1 Audio Ground Moat, J2 BIOS Fallback, J3 Flash Write-Protect, J4 High-Impedance Gain")
  )
  (NET NET_EC_KILL_SWITCH_BUS
    (CONNECTION WIFI_TOGGLE_BUTTON.GPIO_OUT -> SYSTEM_EC.GPIO_WIFI_KILL)
    (CONNECTION CELLULAR_TOGGLE_BUTTON.GPIO_OUT -> SYSTEM_EC.GPIO_WWAN_KILL)
    (CONNECTION BLUETOOTH_TOGGLE_BUTTON.GPIO_OUT -> SYSTEM_EC.GPIO_BT_KILL)
    (CONNECTION NFC_TOGGLE_BUTTON.GPIO_OUT -> SYSTEM_EC.GPIO_NFC_KILL)
    (RULE "Hardware-level RF kill plane; non-maskable EC interrupt gates power to wireless transceivers in <50µs")
  )

  ;; =========================================================================
  ;; 5. Optical Display, Camera & Visual Sensors
  ;; =========================================================================
  (NET NET_DISPLAY_BUS
    (CONNECTION CPU_INTEL_I9_14900HX.LVDS_TX -> DISPLAY_MICROLED.LVDS_TX)
    (RULE "eDP 1.4b 4-lane link; 3840x2160 native @ 165Hz; embedded display ground shield copper pour")
  )
  (NET NET_DISPLAY_PROTECTOR
    (CONNECTION DISPLAY_MICROLED -> DISPLAY_PANEL_PROTECTOR)
    (RULE "Full optical resin bonding layer; refractive index matched (n=1.51); anti-reflective, scratch-resistant")
  )
  (NET NET_CAMERA_STREAM
    (CONNECTION CAMERA_8K_LASER_GUIDED.MIPI_CSI -> CAMERA_CONTROLLER.CSI_IN)
    (RULE "MIPI CSI-2 4-lane high-speed video stream; 8K 60fps raw video transfer")
  )
  (NET NET_CAMERA_DATA
    (CONNECTION CAMERA_INFRARED_SENSOR.I2C -> CAMERA_CONTROLLER.I2C_IR)
    (CONNECTION CAMERA_MICROPHONE_ARRAY.PDM -> CAMERA_CONTROLLER.PDM_MIC)
    (CONNECTION CAMERA_CONTROLLER.USB3_OUT -> CPU_INTEL_I9_14900HX.USB_HOST)
    (RULE "Omnivision IR depth synchronization and Knowles beamforming microphone array telemetry")
  )
  (NET NET_WINDOWS_HELLO
    (CONNECTION WINDOWS_HELLO_IR_SENSOR.DATA -> WINDOWS_HELLO_FIRMWARE_MODULE.IR_IN)
    (CONNECTION WINDOWS_HELLO_FIRMWARE_MODULE.AUTH_OUT -> CPU_INTEL_I9_14900HX.SECURE_AUTH)
    (RULE "Biometric data encryption pipe; direct verification through TPM 2.0 PCR registers")
  )

  ;; =========================================================================
  ;; 6. RF Antenna Feeds, Modems & Telephony
  ;; =========================================================================
  (NET NET_WWAN_RF
    (CONNECTION WWAN_MODULE_QUALCOMM_X90.RF_OUT[0..1] -> WWAN_ANTENNA[0..1])
    (CONNECTION WWAN_X75_MODULE.RF_OUT[0..1] -> WWAN_ANTENNA[0..1])
    (RULE "50Ω RF microstrip impedance matched; 5G NR mmWave and Sub-6 array channels; VSWR <1.8:1")
  )
  (NET NET_SIM_DATA
    (CONNECTION NANO_SIM_SLOT -> WWAN_MODULE_QUALCOMM_X90.SIM_IF)
    (RULE "ISO 7816-3 smart card interface; integrated ESD protection and bypass capacitance")
  )
  (NET NET_NFC_BUS
    (CONNECTION NFC_MODULE_HP.NFC_TX/RX -> SENSOR_FUSION_CONTROLLER.I2C_NFC)
    (RULE "13.56MHz loop antenna circuit with differential matching capacitor bridge")
  )
  (NET NET_TELEPHONE_LINE
    (CONNECTION TELEPHONE_LINE_PORT -> SYSTEM_EC.MODEM_LINE)
    (RULE "Legacy 56Kbps analog modem port; 1500V galvanic isolation barrier transformer")
  )

  ;; =========================================================================
  ;; 7. Human Interface, Sensors & Capacitive Matrix
  ;; =========================================================================
  (NET NET_TRACKPAD
    (CONNECTION TRACKPAD_HAPTIC -> TRACKPAD_CONTROLLER)
    (CONNECTION TRACKPAD_CONTROLLER -> SYSTEM_EC.I2C_TRACKPAD)
    (RULE "Capacitive multi-touch reporting; solenoid haptic feedback activation command line")
  )
  (NET NET_KEYBOARD
    (CONNECTION KEYBOARD_BASE_STYLE -> SYSTEM_EC.KB_MATRIX)
    (CONNECTION NUM_KEYPAD -> SYSTEM_EC.NUMPAD_MATRIX)
    (RULE "N-key rollover scanning matrix; pure white LED backlighting power plane")
  )
  (NET NET_CAP_TOUCH_BUS
    (CONNECTION CAP_TOUCH_SLIDER.I2C -> SYSTEM_EC.I2C_INPUT)
    (CONNECTION CAP_TOUCH_BUTTON.I2C -> SYSTEM_EC.I2C_INPUT)
    (CONNECTION CAP_TOUCH_DUAL_TOGGLE.I2C -> SYSTEM_EC.I2C_INPUT)
    (CONNECTION SCREENSHOT_BUTTON.GPIO -> SYSTEM_EC.GPIO_INPUT)
    (CONNECTION GAME_MODE_BUTTON.GPIO -> SYSTEM_EC.GPIO_INPUT)
    (RULE "I2C capacitive switch matrix polling; hardware-locked keycode reporting")
  )
  (NET NET_POWER_BUTTON
    (CONNECTION POWER_BUTTON_DEEP_PRESS.PIN -> SYSTEM_EC.POWER_BTN_IN)
    (RULE "Alps Alpine deep-press 1.5mm travel tactile switch; hardware debounce filter; power sequencer latch")
  )
  (NET NET_IMU_SENSOR_BUS
    (CONNECTION IMU_SENSOR.SPI -> SENSOR_FUSION_CONTROLLER.SPI_BUS)
    (RULE "6-axis motion tracking telemetry (BMI270); SPI bus operating at 10MHz")
  )
  (NET NET_ENV_SENSOR_BUS
    (CONNECTION ENVIRONMENTAL_SENSOR.I2C -> SENSOR_FUSION_CONTROLLER.I2C_BUS)
    (RULE "SHT40 temperature/humidity polling over I2C; 100ms interval")
  )
  (NET NET_SENSOR_FUSION_UPLINK
    (CONNECTION SENSOR_FUSION_CONTROLLER.I2C_HOST -> CPU_INTEL_I9_14900HX.I2C_HUB)
    (RULE "Filtered contextual sensor payload feed dispatched directly to system host processor")
  )

  ;; =========================================================================
  ;; 8. Thermal Dissipation Paths & Closed-Loop Fan Matrix
  ;; =========================================================================
  (NET NET_THERMAL_PATH
    (CONNECTION CPU_INTEL_I9_14900HX -> GRAPHENE_VAPOR_CHAMBER)
    (CONNECTION GPU_NVIDIA_ADA5090M -> GRAPHENE_VAPOR_CHAMBER)
    (CONNECTION GPU_NANOWIRE_AI_QUANTUM -> GRAPHENE_VAPOR_CHAMBER)
    (CONNECTION THERMAL_COLD_PLATE_INSERTS -> GRAPHENE_VAPOR_CHAMBER)
    (RULE "1500W/mK in-plane conductivity; 300W continuous vapor phase thermal spreading")
  )
  (NET NET_LIQUID_METAL
    (CONNECTION LIQUID_METAL_TIM -> CPU_INTEL_I9_14900HX, GPU_NVIDIA_ADA5090M)
    (RULE "Thermal Grizzly Conductonaut gallium-indium alloy; thermal resistance <0.01K/W; 95% coverage")
  )
  (NET NET_BLOWERS
    (CONNECTION DYSON_BLOWER_LARGE[0..2] -> CHASSIS_UNIBODY_BASE.EXHAUST)
    (CONNECTION DYSON_BLOWER_MEDIUM[0..2] -> CHASSIS_UNIBODY_BASE.EXHAUST)
    (CONNECTION BLADELESS_IONIC_BLOWER -> CHASSIS_UNIBODY_BASE.EXHAUST)
    (RULE "Airflow >25CFM large, >15CFM medium, >20CFM ionic; collective noise <28dBA under 675W continuous load")
  )
  (NET NET_THERMAL_SENSORS
    (CONNECTION THERMAL_SENSOR[MAX31875] -> SYSTEM_EC.SMBUS_THERMAL)
    (RULE "Multi-zone SMBus temperature feedback loop; continuous closed-loop PWM fan control")
  )
)
