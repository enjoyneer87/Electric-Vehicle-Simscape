%% Motor Thermal parameters 
% Script to generate PMSM Motor Thermal Parameters.

% Copyright 2022 - 2023 The MathWorks, Inc.

%% Material Properties
electricDrive.IronDensity=760.0; % Iron density in Kg/m3
electricDrive.IronThConductivity=50;
electricDrive.IronSpHeat=447.0;
electricDrive.CopperDensity=896.0; % Copper Density in Kg/m3
electricDrive.CopperThconductivity=300;
electricDrive.CopperSpHeat=385.0;

%% Parameters
% Stator Input Parameters
electricDrive.MotorThermal.Npl=4;
electricDrive.MotorThermal.No_stator_slot=48;
electricDrive.MotorThermal.Statotor_Bore_id=130.96;
electricDrive.MotorThermal.stator_od=198.12;
electricDrive.MotorThermal.stator_tooth_width=4.15;
electricDrive.MotorThermal.slotDepth=21.1;
electricDrive.MotorThermal.stackLength=151.38;
%Rotor Input Parameters
electricDrive.MotorThermal.rotorStackLength=151.6;
electricDrive.MotorThermal.rotor_od=129.97;
electricDrive.MotorThermal.GrossRotorMass=16.45;
electricDrive.MotorThermal.magnetMass=1.895;
electricDrive.MotorThermal.BridgeThickness=1.5;
% 3-Phase Winding Input Parameters
electricDrive.MotorThermal.WindingOverhang=0.2;
electricDrive.MotorThermal.SlotPackingFactor=0.4;
%Coolant jacket Input Parameters
electricDrive.MotorThermal.ChennelSection=[5,10];
electricDrive.MotorThermal.NoOfChennelTurns=5;

%Mass & Volume
electricDrive.MotorThermal.GrossToothMass=electricDrive.IronDensity*...
                                          electricDrive.MotorThermal.No_stator_slot*...
                                          electricDrive.MotorThermal.stator_tooth_width*...
                                          electricDrive.MotorThermal.slotDepth*...
                                          electricDrive.MotorThermal.stackLength*1e-9;
electricDrive.MotorThermal.StatorBackIronMass=electricDrive.IronDensity*...
                                              (pi/4)*((electricDrive.MotorThermal.stator_od^2)-...
                                              (electricDrive.MotorThermal.Statotor_Bore_id^2))*...
                                              electricDrive.MotorThermal.stackLength*1e-9;
electricDrive.MotorThermal.Bridgemass=electricDrive.IronDensity*...
                                      (pi)*(electricDrive.MotorThermal.rotor_od-...
                                      electricDrive.MotorThermal.BridgeThickness)*...
                                      electricDrive.MotorThermal.rotorStackLength*...
                                      electricDrive.MotorThermal.BridgeThickness*1e-9;
electricDrive.MotorThermal.RotorBackIronMass=electricDrive.MotorThermal.GrossRotorMass-...
                                             electricDrive.MotorThermal.Bridgemass;
electricDrive.MotorThermal.RotorBackIronId=(electricDrive.MotorThermal.rotor_od-...
                                           electricDrive.MotorThermal.BridgeThickness)*1e-3;
electricDrive.MotorThermal.StatorRootDia=(electricDrive.MotorThermal.Statotor_Bore_id+...
                                         electricDrive.MotorThermal.slotDepth)*1e-3;
electricDrive.MotorThermal.RotorAreaCyl=pi*electricDrive.MotorThermal.rotorStackLength*...
                                        electricDrive.MotorThermal.rotor_od*1e-6;
electricDrive.MotorThermal.RotorAreaER=(pi/2)*electricDrive.MotorThermal.rotor_od^2*1e-6;
electricDrive.MotorThermal.StatorWindingOhArea=2*pi*(electricDrive.MotorThermal.stackLength*...
                                               electricDrive.MotorThermal.WindingOverhang)*...
                                               (electricDrive.MotorThermal.Statotor_Bore_id+...
                                               electricDrive.MotorThermal.StatorRootDia*1e3)*1e-6;
electricDrive.MotorThermal.WindingMass=electricDrive.CopperDensity*...
                                       electricDrive.MotorThermal.SlotPackingFactor*...
                                       1e-9*((pi/4)*((electricDrive.MotorThermal.Statotor_Bore_id+...
                                       2*electricDrive.MotorThermal.slotDepth)^2-...
                                       electricDrive.MotorThermal.Statotor_Bore_id^2)-...
                                       electricDrive.MotorThermal.No_stator_slot*...
                                       electricDrive.MotorThermal.stator_tooth_width*...
                                       electricDrive.MotorThermal.slotDepth)*...
                                       (1+2*electricDrive.MotorThermal.WindingOverhang)*...
                                       electricDrive.MotorThermal.stackLength;
electricDrive.MotorThermal.IronLossMass=electricDrive.MotorThermal.Bridgemass+...
                                        electricDrive.MotorThermal.GrossToothMass;
electricDrive.MotorThermal.vFractBridge=electricDrive.MotorThermal.Bridgemass/...
                                        electricDrive.MotorThermal.IronLossMass;
electricDrive.MotorThermal.vFractTooth=1-electricDrive.MotorThermal.vFractBridge;
electricDrive.MotorThermal.PhaseWindingThMass=electricDrive.MotorThermal.WindingMass*...
                                              electricDrive.CopperSpHeat/3;
electricDrive.MotorThermal.RotorThMass=electricDrive.MotorThermal.GrossRotorMass*...
                                       electricDrive.IronSpHeat;

%Coolant Properties
electricDrive.MotorThermal.ChannelSection=electricDrive.MotorThermal.ChennelSection(1,1)*...
                                          electricDrive.MotorThermal.ChennelSection(1,2);
electricDrive.MotorThermal.Perimeter=2*(electricDrive.MotorThermal.ChennelSection(1,1)+...
                                     electricDrive.MotorThermal.ChennelSection(1,2));
electricDrive.MotorThermal.ChannelHydraulicdia=4*electricDrive.MotorThermal.ChannelSection/...
                                               electricDrive.MotorThermal.Perimeter;
electricDrive.MotorThermal.ChannelLength=pi*electricDrive.MotorThermal.NoOfChennelTurns*...
                                         (electricDrive.MotorThermal.stator_od+...
                                         electricDrive.MotorThermal.ChennelSection(1,1));
electricDrive.p=[10000 100000	5000000	10000000 15000000 20000000 25000000	30000000 35000000 40000000 45000000	50000000];
electricDrive.dt=1e-3;
