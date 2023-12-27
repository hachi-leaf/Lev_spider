clear ALL;clc;close ALL;

% 定义舵机角度 
% 约束：
% -pi/2 < thetaA < pi/2
% 0 < thetaB < pi/2
% -pi/2 < thetaB + thetaC < 0
theta_in = [-30 160 -90]*pi/180'; %使用角度制

% 各连杆参数，单位：cm
L1 = 54;  
L2 = 74;  
L3 = 164.89;   

% 偏置参数转化为matlab中的方向
thetaVal = [theta_in(1) -theta_in(2) -theta_in(3) 0]';
% 定义各个连杆以及关节类型，默认为转动关节  
F1=Link([      0     0        0          0],    'modified'); % [四个DH参数], options  
F2=Link([      0     0        L1     -pi/2],    'modified');  
F3=Link([      0     0        L2         0],    'modified');  
F4=Link([      0     0        L3         0],    'modified');  

% 将连杆组成机械臂  
robot=SerialLink([F1,F2,F3,F4]);   
robot.name='singleLeg';  
robot.offset=thetaVal;

% 显示
robot.display();
axis([-1 1 -1 1 -1 1]);

% 解决robot.teach()和plot的索引超出报错
robot.teach();

T = robot.fkine([0.0, 0.0, 0.0, 0.0]); % 正运动学
position = T.t; % 位置

% 定义坐标
xT = position(1);
yT = position(2);
zT = position(3);
%按照公式计算
theta1 = atan(yT/xT);
delta = ((sqrt(xT^2 + yT^2)-L1)^2 + zT^2 - (L2-L3)^2) * (-(sqrt(xT^2 + yT^2)-L1)^2 - zT^2 + (L2+L3)^2);
theta2 = 2*atan( ((2*L2*zT + sqrt(delta)) / ((sqrt(xT^2+yT^2)+L2-L1)^2 + zT^2 - L3^2)) );
theta3 = 2*atan( ((2*L3*zT - sqrt(delta)) / ((sqrt(xT^2+yT^2)+L3-L1)^2 + zT^2 - L2^2)) );


theta_out = [theta1,theta2,theta3-theta2];

position',theta_in,theta_out



