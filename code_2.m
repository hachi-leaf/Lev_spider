clear ALL;clc;close ALL;

% �������Ƕ� 
% Լ����
% -pi/2 < thetaA < pi/2
% 0 < thetaB < pi/2
% -pi/2 < thetaB + thetaC < 0
theta_in = [-30 160 -90]*pi/180'; %ʹ�ýǶ���

% �����˲�������λ��cm
L1 = 54;  
L2 = 74;  
L3 = 164.89;   

% ƫ�ò���ת��Ϊmatlab�еķ���
thetaVal = [theta_in(1) -theta_in(2) -theta_in(3) 0]';
% ������������Լ��ؽ����ͣ�Ĭ��Ϊת���ؽ�  
F1=Link([      0     0        0          0],    'modified'); % [�ĸ�DH����], options  
F2=Link([      0     0        L1     -pi/2],    'modified');  
F3=Link([      0     0        L2         0],    'modified');  
F4=Link([      0     0        L3         0],    'modified');  

% ��������ɻ�е��  
robot=SerialLink([F1,F2,F3,F4]);   
robot.name='singleLeg';  
robot.offset=thetaVal;

% ��ʾ
robot.display();
axis([-1 1 -1 1 -1 1]);

% ���robot.teach()��plot��������������
robot.teach();

T = robot.fkine([0.0, 0.0, 0.0, 0.0]); % ���˶�ѧ
position = T.t; % λ��

% ��������
xT = position(1);
yT = position(2);
zT = position(3);
%���չ�ʽ����
theta1 = atan(yT/xT);
delta = ((sqrt(xT^2 + yT^2)-L1)^2 + zT^2 - (L2-L3)^2) * (-(sqrt(xT^2 + yT^2)-L1)^2 - zT^2 + (L2+L3)^2);
theta2 = 2*atan( ((2*L2*zT + sqrt(delta)) / ((sqrt(xT^2+yT^2)+L2-L1)^2 + zT^2 - L3^2)) );
theta3 = 2*atan( ((2*L3*zT - sqrt(delta)) / ((sqrt(xT^2+yT^2)+L3-L1)^2 + zT^2 - L2^2)) );


theta_out = [theta1,theta2,theta3-theta2];

position',theta_in,theta_out



