%% for power flows: std = 0.008
mu_pf = 0;
std_pf = 0.008;
a = readmatrix('Real_Power_From_case18_with_DG.csv'); % a is the original matrix
S_base = 10;
a_pu = a/S_base; % S_bas = 10MVA (for case18) and the Ps and Qs are given in MW and MVAR
b = a_pu + a_pu.*normrnd(mu_pf,std_pf,size(a_pu)); % b = a + gaussian (normal) noise
writematrix(b, 'Real_Power_From_case18_with_Noise_with_DG.csv');

z = readmatrix('Reactive_Power_From_case18_with_DG.csv');
z_pu = z/S_base;
t = z_pu + z_pu.*normrnd(mu_pf,std_pf,size(z_pu));
writematrix(t, 'Reactive_Power_From_case18_with_Noise_with_DG.csv');

%% for power injection: std = 0.01
mu_pi = 0;
std_pi = 0.01;
c = readmatrix('Generator_Real_P_Injections_case18_with_DG.csv');
c_pu = c/S_base;
d = c_pu + c_pu.*normrnd(mu_pi,std_pi,size(c_pu)); 
writematrix(d, 'Generator_Real_P_Injections_case18_with_Noise_with_DG.csv');

v = readmatrix('Generator_Reactive_P_Injections_case18_with_DG.csv');
v_pu = v/S_base;
u = v_pu + v_pu.*normrnd(mu_pi,std_pi,size(v_pu)); 
writematrix(u, 'Generator_Reactive_P_Injections_case18_with_Noise_with_DG.csv');

%% for voltages: std = 0.004
mu_vm = 0;
std_vm = 0.004;
e = readmatrix('V50.csv');
f = e + e.*normrnd(mu_vm,std_vm,size(e));
writematrix(f, 'V50_with_Noise_with_DG.csv');

%% Get  the Sine of the Angles
w = readmatrix('Voltage_Angles_case18_with_DG.csv');
g = deg2rad(w);
m = sin(g);
writematrix(m,'Sine_of_Angles_case18_with_DG.csv');