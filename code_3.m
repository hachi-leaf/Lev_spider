clear ALL;clc;close ALL;
startup_rvc;
figure;
% �����˲�������λ��cm
L1 = 54;  
L2 = 74;  
L3 = 164.89;   

% ƫ�ò���ת��Ϊmatlab�еķ���
thetaVal = [0 -pi/4 125*pi/180 0]';
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

% X,Y�ķ�Χ
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

hold on; % ���ֵ�ǰͼ��


mesh(X1, Y1, real(Z11));
mesh(X1, Y1, real(Z12));
mesh(X2, Y2, real(Z21));
mesh(X2, Y2, real(Z22));




