{==============================================================================}
{ Altium Designer Dynamic Rat's-Nest (Connection Line) Display Script          }
{ Color-Codes Flight Lines & Forces Selective Subsystem Rat's-Nest Rendering   }
{ Specification Standard: Version 2.9-HIGHEST (Fully Consolidated I/O Scope)   }
{==============================================================================}

Procedure ConfigureSubsystemRatNets;
Var
    Board: IPCB_Board;
Begin
    Board := PCBServer.GetCurrentPCBBoard;
    If Board = Nil Then Exit;

    // Reset parameters to show all nets cleanly
    ResetParameters;
    AddStringParameter('Action', 'ShowAll');
    RunProcess('PCB:ManageNetlist');

    // Color-code critical flight-line classes for visual routing clarity

    // High-Speed Compute & Memory Buses
    ResetParameters;
    AddStringParameter('NetClass', 'PCIE_GEN5_DIFF');
    AddStringParameter('Color', '16711680'); // Blue
    RunProcess('PCB:SetNetClassColor');

    ResetParameters;
    AddStringParameter('NetClass', 'DDR5_DATA_BUS');
    AddStringParameter('Color', '65280'); // Green
    RunProcess('PCB:SetNetClassColor');

    ResetParameters;
    AddStringParameter('NetClass', 'HBM3_1024BIT_BUS');
    AddStringParameter('Color', '16776960'); // Cyan
    RunProcess('PCB:SetNetClassColor');

    // Studio Audio Isolation Domain
    ResetParameters;
    AddStringParameter('NetClass', 'AUDIO_ISOLATED_NETS');
    AddStringParameter('Color', '16711935'); // Magenta
    RunProcess('PCB:SetNetClassColor');

    // High-Speed Networking & Optical Interconnects
    ResetParameters;
    AddStringParameter('NetClass', 'QSFP_DD_400G_BUS');
    AddStringParameter('Color', '255'); // Red
    RunProcess('PCB:SetNetClassColor');

    ResetParameters;
    AddStringParameter('NetClass', 'CAT8_ETHERNET_DIFF');
    AddStringParameter('Color', '42495'); // Orange
    RunProcess('PCB:SetNetClassColor');

    // USB 3.2 & USB 4 High-Speed Data Links
    ResetParameters;
    AddStringParameter('NetClass', 'USB_HIGH_SPEED_BUS');
    AddStringParameter('Color', '65535'); // Yellow
    RunProcess('PCB:SetNetClassColor');

    // Analog Telephony & Fax Isolation Lines
    ResetParameters;
    AddStringParameter('NetClass', 'TELEPHONE_FAX_LINES');
    AddStringParameter('Color', '8421504'); // Gray / Neutral
    RunProcess('PCB:SetNetClassColor');

    // Force Altium viewport re-render
    ResetParameters;
    AddStringParameter('Action', 'Redraw');
    RunProcess('PCB:Zoom');
End;
