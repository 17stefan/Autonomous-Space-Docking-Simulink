% Simscape(TM) Multibody(TM) version: 25.2

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(1).translation = [0.0 0.0 0.0];
smiData.RigidTransform(1).angle = 0.0;
smiData.RigidTransform(1).axis = [0.0 0.0 0.0];
smiData.RigidTransform(1).ID = "";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [655.01643200197668 -1318.8268331659633 1274.6642908053245];  % mm
smiData.RigidTransform(1).angle = 0;  % rad
smiData.RigidTransform(1).axis = [0 0 0];
smiData.RigidTransform(1).ID = "RootGround[Part5-1]";


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(1).mass = 0.0;
smiData.Solid(1).CoM = [0.0 0.0 0.0];
smiData.Solid(1).MoI = [0.0 0.0 0.0];
smiData.Solid(1).PoI = [0.0 0.0 0.0];
smiData.Solid(1).color = [0.0 0.0 0.0];
smiData.Solid(1).opacity = 0.0;
smiData.Solid(1).ID = "";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 24665.737013682483;  % kg
smiData.Solid(1).CoM = [0.0013871040651768462 1654.451953534847 0.001640169561433805];  % mm
smiData.Solid(1).MoI = [38883877116.574181 28424024605.138363 39440451867.326057];  % kg*mm^2
smiData.Solid(1).PoI = [12570.475898515382 208316.38710977766 9404.491489422393];  % kg*mm^2
smiData.Solid(1).color = [0.792156862745098 0.81960784313725488 0.93333333333333335];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "Part5*:*Default";

