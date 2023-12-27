clc;clear;
syms theta2 theta3 zt rt_L1 L2 L3;

f = [
    rt_L1 == L2*cos(theta2) + L3*cos(theta3)  
    zt == L2*sin(theta2) + L3*sin(theta3) 
    ];

sol = solve(f,[theta2,theta3]);

theta2 = simplify(sol.theta2);
theta3 = simplify(sol.theta3);

pretty(theta2)
pretty(theta3)

