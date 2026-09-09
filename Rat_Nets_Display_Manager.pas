{==============================================================================}
{ Altium Designer Dynamic Rat's-Nest (Connection Line) Display Script          }
{ Color-Codes Flight Lines & Forces Selective Subsystem Rat's-Nest Rendering  }
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

    ResetParameters;
    AddStringParameter('NetClass', 'AUDIO_ISOLATED_NETS');
    AddStringParameter('Color', '16711935'); // Magenta
    RunProcess('PCB:SetNetClassColor');

    // Force Altium viewport re-render
    ResetParameters;
    AddStringParameter('Action', 'Redraw');
    RunProcess('PCB:Zoom');
End;
