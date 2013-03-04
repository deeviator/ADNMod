// V8SC2011 Suspension
//
// This file controls all vehicles
//////////////////////////////////////////////////////////////////////////
//
// Conventions:
//
// +x = left
// +z = rear
// +y = up
// +pitch = nose up
// +yaw = nose right
// +roll = right
//
// [BODY]  - a rigid mass with mass and inertial properties
// [JOINT] - a ball joint constraining an offset of one body to an
//           offset of another body (eliminates 3 DOF)
// [HINGE] - a constraint restricting the relative rotations of two
//           bodies to be around a single axis (eliminates 2 DOF).
// [BAR]   - a constraint holding an offset of one body from an offset of
//           another body at a fixed distance (eliminates 1 DOF).
// [JOINT&HINGE] - both the joint and hinge constraints, forming the
//           conventional definition of a hinge (eliminates 5 DOF).
//
//////////////////////////////////////////////////////////////////////////


[BODY]
name=body mass=(980.0) inertia=(1.0,1.0,1.0)
pos=(0.0,0.0,0.0) ori=(0.0,0.0,0.0)

// Front spindles
[BODY]
name=fl_spindle mass=(15.0) inertia=(0.0330,0.0312,0.0295)
pos=(0.75,0.0,-1.65) ori=(0.0,0.0,0.0)

[BODY]
name=fr_spindle mass=(15.0) inertia=(0.0330,0.0312,0.0295)
pos=(-0.75,0.0,-1.65) ori=(0.0,0.0,0.0)

// Front wheels
[BODY]
name=fl_wheel mass=(16.55) inertia=(0.925,0.670,0.670)
pos=(0.76,0.0,-1.65) ori=(0.0,0.0,0.0)

[BODY]
name=fr_wheel mass=(16.55) inertia=(0.925,0.670,0.670)
pos=(-0.76,0.0,-1.65) ori=(0.0,0.0,0.0)


// Live rear axle
[BODY]
name=rear_axle mass=(30.00) inertia=(1.0,3.70,3.70)
pos=(0.0,0.0,1.35) ori=(0.0,0.0,0.0)

// Rear wheels (includes half of rear-axle)
[BODY]
name=rl_wheel mass=(16.55) inertia=(0.096,0.786,0.786)
pos=(0.76,0.0,1.35) ori=(0.0,0.0,0.0)

[BODY]
name=rr_wheel mass=(16.55) inertia=(0.096,0.786,0.786)
pos=(-0.76,0.0,1.35) ori=(0.0,0.0,0.0)


// Fuel in tank is not rigidly attached - it is attached with springs and
// dampers to simulate movement.  Properties are defined in the HDV file.
[BODY]
name=fuel_tank mass=(1.0) inertia=(1.0,1.0,1.0)
pos=(0.0,0.0,0.0) ori=(0.0,0.0,0.0)

// Driver's head is not rigidly attached, and it does NOT affect the vehicle
// physics.  Position is from the eyepoint defined in the VEH file, while
// other properties are defined in the head physics file.
[BODY]
name=driver_head mass=(5.0) inertia=(0.02,0.02,0.02)
pos=(0.0,0.0,0.0) ori=(0.0,0.0,0.0)

//////////////////////////////////////////////////////////////////////////
//
// Constraints
//
//////////////////////////////////////////////////////////////////////////

// Front wheel and spindle connections
[JOINT&HINGE]
posbody=fl_wheel negbody=fl_spindle pos=fl_wheel axis=(0.76,0.0,0.0)

[JOINT&HINGE]
posbody=fr_wheel negbody=fr_spindle pos=fr_wheel axis=(-0.76,0.0,0.0)

// Front left suspension (2 A-arms + 1 steering arm = 5 links)
[BAR] // forward upper arm
name=fl_fore_upper posbody=body negbody=fl_spindle pos=(0.412,0.141,-1.668) neg=(0.650,0.163,-1.648)

[BAR] // rearward upper arm
posbody=body negbody=fl_spindle pos=(0.412,0.141,-1.485) neg=(0.650,0.163,-1.648)

[BAR] // forward lower arm
name=fl_fore_lower posbody=body negbody=fl_spindle pos=(0.322,-0.105,-1.75) neg=(0.695,-0.110,-1.66)

[BAR] // rearward lower arm
posbody=body negbody=fl_spindle pos=(0.322,-0.105,-1.445) neg=(0.695,-0.110,-1.66)

[BAR] // steering arm (must be named for identification)
name=fl_steering posbody=body negbody=fl_spindle pos=(0.325,-0.07,-1.45) neg=(0.652,-0.070,-1.450)

// Front right suspension (2 A-arms + 1 steering arm = 5 links)
[BAR] // forward upper arm (used in steering lock calculation)
name=fr_fore_upper posbody=body negbody=fr_spindle pos=(-0.412,0.141,-1.668) neg=(-0.650,0.163,-1.648)

[BAR] // rearward upper arm
posbody=body negbody=fr_spindle pos=(-0.412,0.141,-1.485) neg=(-0.650,0.163,-1.648)

[BAR] // forward lower arm
name=fr_fore_lower posbody=body negbody=fr_spindle pos=(-0.322,-0.105,-1.75) neg=(-0.695,-0.110,-1.66)

[BAR] // rearward lower arm
posbody=body negbody=fr_spindle pos=(-0.322,-0.105,-1.445) neg=(-0.695,-0.110,-1.66)

[BAR] // steering arm (must be named for identification)
name=fr_steering posbody=body negbody=fr_spindle pos=(-0.325,-0.07,-1.45) neg=(-0.652,-0.070,-1.450)

// Live Axle rear suspension geometry:
// 3 links + Trackbar
[BAR]
posbody=body negbody=rear_axle pos=(0.0,0.137,0.940) neg=(0.0,0.165,1.22)

[BAR]
posbody=body negbody=rear_axle pos=(0.52,-0.078,0.850) neg=(0.52,-0.078,1.32)

[BAR]
posbody=body negbody=rear_axle pos=(-0.52,-0.078,0.850) neg=(-0.52,-0.078,1.32)

// Track bar (heights will be changed with track bar adjustments)
[BAR]
name=track_bar posbody=body negbody=rear_axle pos=(0.60, -0.10, 1.50) neg=(-0.60, -0.10, 1.50)

// Rear spindle and wheel connections (axis will be changed with rear camber adjustments)
[JOINT&HINGE]
posbody=rl_wheel negbody=rear_axle pos=rl_wheel axis=(-1.0,0.0,0.0)

[JOINT&HINGE]
posbody=rr_wheel negbody=rear_axle pos=rr_wheel axis=(1.0,0.0,0.0)
