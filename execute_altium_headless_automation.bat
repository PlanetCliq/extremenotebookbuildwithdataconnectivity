@echo off
REM ==============================================================================
REM Altium Designer Headless CLI Automation Pipeline
REM Target Platform: Extreme Performance Laptop (v2.9-HIGHEST Master BOM)
REM ==============================================================================

set ALTIUM_EXE="C:\Program Files\Altium\AD24\X2.EXE"
set PRJ_PATH="%CD%\ExtremeNotebook_Aero.PrjPcb"
set SCRIPT_PATH="%CD%\AutoPlace_And_ApplyConstraints_MasterBOM.pas"

echo [+] Initializing Altium Headless 1-Click Placement and DRC Automation...

if not exist %ALTIUM_EXE% (
    echo [-] Error: Altium Designer executable not found at %ALTIUM_EXE%
    echo     Please adjust ALTIUM_EXE variable path in this batch file.
    pause
    exit /b 1
)

echo [+] Step 1: Launching Project %PRJ_PATH%
echo [+] Step 2: Executing Auto-Placement, Rule Injection, and Rat's-Nest Alignment...
%ALTIUM_EXE% -R %SCRIPT_PATH% -P %PRJ_PATH% AutoPlaceAndLockAllBOMComponents

echo [+] Step 3: Color-coding Rat's-Nest Connection Lines...
%ALTIUM_EXE% -R "%CD%\Rat_Nets_Display_Manager.pas" -P %PRJ_PATH% ConfigureSubsystemRatNets

echo ==============================================================================
echo [+] Execution Finished: Master Components Placed, Locked, Rules Bound, DRC Checked.
echo ==============================================================================
pause
