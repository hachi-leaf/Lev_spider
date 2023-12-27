clear ALL;clc;close ALL;
startup_rvc;
figure;
% 各连杆参数，单位：cm
L1 = 54;  
L2 = 74;  
L3 = 164.89;   

% 偏置参数转化为matlab中的方向
thetaVal = [0 -pi/4 125*pi/180 0]';
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

% X,Y的范围
T = (-90:5:90)*pi/180;

R1 = max(0,L1-L2-L3):5:L1+L2+L3;
R1 = [R1 L1+L2+L3];
R1 = R1';
X1 = R1.*cos(T);
Y1 = R1.*sin(T);

R2 = max(0,L1-abs(L2-L3)):5:L1+abs(L2-L3);
R2 = [R2 L1+abs(L2-L3)];
R2 = R2';
X2 = R2.*cos(T);
Y2 = R2.*sin(T);




Z11 =  ( -((X1.^2 + Y1.^2).^0.5-L1).^2 + (L2+L3)^2).^0.5;
Z12 = -( -((X1.^2 + Y1.^2).^0.5-L1).^2 + (L2+L3)^2).^0.5;
Z21 =  ( -((X2.^2 + Y2.^2).^0.5-L1).^2 + (L2-L3)^2).^0.5;
Z22 = -( -((X2.^2 + Y2.^2).^0.5-L1).^2 + (L2-L3)^2).^0.5;

hold on; % 保持当前图形


mesh(X1, Y1, real(Z11));
mesh(X1, Y1, real(Z12));
mesh(X2, Y2, real(Z21));
mesh(X2, Y2, real(Z22));




