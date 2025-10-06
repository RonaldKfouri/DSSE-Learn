% 18-bus distribution system
% Elapsed time is 605.135477 seconds = 10.0856 minutes
clear
clc
startup
define_constants;
voltage_magnitudes = zeros(18);
voltage_angles = zeros(18);
generator_real_p_injections = zeros(2);
generator_reactive_p_injections = zeros(2);
real_power_from = zeros(17);
real_power_to = zeros(17);
reactive_power_from = zeros(17);
reactive_power_to = zeros(17);
mpc = loadcase('Case18_with_DG.m');
a = 0;
mpopt = mpoption('pf.nr.max_it',100,'verbose',0,'out.all',0);

tic
for PD2_Value = 1:1:3 % 3 values
    mpc.bus(2, PD) = PD2_Value;
    mpc.bus(2, QD) = 0.6*PD2_Value; % QD changes with respect to PD changes

    for PD4_Value = -0.5:-0.5:-1.5 % 3 values
        mpc.bus(4, PD) = PD4_Value; % QD unchanged

        for PD5_Value = 0:2:4 % 3 values
            mpc.bus(5, PD) = PD5_Value;
            mpc.bus(5, QD) = 0.625*PD5_Value;

            for PD6_Value = 4:2:8 % 3 values
                mpc.bus(6, PD) = PD6_Value;
                mpc.bus(6, QD) = 0.625*PD6_Value;

                for PD7_Value = 0.2:0.1:0.4 % 3 values
                    mpc.bus(7, PD) = PD7_Value;
                    mpc.bus(7, QD) = 0.6*PD7_Value;

                    for PD9_Value = -3:-1.5:-6 % 3 values
                        mpc.bus(9, PD) = PD9_Value; % QD unchanged

                        for PD11_Value = 3:1.5:6 % 3 values
                            mpc.bus(11, PD) = PD11_Value; % QD unchanged

                            for PD12_Value = 0.1:0.1:0.3 % 3 values
                                mpc.bus(12, PD) = PD12_Value; % QD unchanged

                                for PD14_Value = 2:1.5:5 % 3 values
                                    mpc.bus(14, PD) = PD14_Value;

                                    for PD16_Value = 2:1.5:5 % 3 values
                                        mpc.bus(16, PD) = PD16_Value;
                                        mpc.bus(16, QD) = 0.6*PD16_Value;

                                        for PD17_Value = 0.5:0.5:1.5 % 3 values
                                            a = a + 1;
                                            mpc.bus(17, PD) = PD17_Value;
                                            results = runpf(mpc, mpopt);

                                            if results.success==1
                                                voltage_magnitudes(:,a) = results.bus(:,VM);
                                                voltage_angles(:,a) = results.bus(:,VA);
                                                generator_real_p_injections(:,a) = results.gen(:,PG);
                                                generator_reactive_p_injections(:,a) = results.gen(:,QG);
                                                real_power_from(:,a) = results.branch(:,PF);
                                                real_power_to(:,a) = results.branch(:,PT);
                                                reactive_power_from(:,a) = results.branch(:,QF);
                                                reactive_power_to(:,a) = results.branch(:,QT); % a total of 3^11 = 177,147 values
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
toc

Voltage_Magnitudes_case18 = voltage_magnitudes';
writematrix(Voltage_Magnitudes_case18, 'Voltage_Magnitudes_case18_with_DG.csv');

Voltage_Angles_case18 = voltage_angles';
writematrix(Voltage_Angles_case18, 'Voltage_Angles_case18_with_DG.csv');

Generator_Real_P_Injections_case18 = generator_real_p_injections';
writematrix(Generator_Real_P_Injections_case18, 'Generator_Real_P_Injections_case18_with_DG.csv');

Generator_Reactive_P_Injections_case18 = generator_reactive_p_injections';
writematrix(Generator_Reactive_P_Injections_case18, 'Generator_Reactive_P_Injections_case18_with_DG.csv');

Real_Power_From_case18 = real_power_from';
writematrix(Real_Power_From_case18, 'Real_Power_From_case18_with_DG.csv');

Real_Power_To_case18 = real_power_to';
writematrix(Real_Power_To_case18, 'Real_Power_To_case18_with_DG.csv');

Reactive_Power_From_case18 = reactive_power_from';
writematrix(Reactive_Power_From_case18, 'Reactive_Power_From_case18_with_DG.csv');

Reactive_Power_To_case18 = reactive_power_to';
writematrix(Reactive_Power_To_case18, 'Reactive_Power_To_case18_with_DG.csv');




