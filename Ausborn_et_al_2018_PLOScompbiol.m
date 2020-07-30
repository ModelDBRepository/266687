% light values can be changed in a loop for testing
% loopLightValues, ChRLight and time parameters have to be set by hand

% calls DF_ChR.m and outputFunction.m


% neuron names
%   neuron 1 - pre-I
%   neuron 2 - early-I 
%   neuron 3 - aug-E
%   neuron 4 - post-I 
%   neuron 5 - post-I-preBot


%% --- set parameters --------------------------------------------


for loopLightValues=1
   

clearvars -except loopLightValues    
    
% pre BotC stimulation
ChRLight=loopLightValues*[0;1;0;0;1];
figureCaption=strcat('preBotC-Stim=',num2str(loopLightValues));

% BotC stimulation
% ChRLight=loopLightValues*[0;0;1;1;0];
% figureCaption=strcat('BotC-Stim=',num2str(loopLightValues));
 
% Alsahafi stimulation
% ChRLight=loopLightValues*[1;1;0;0;1];
% figureCaption=strcat('Alsahafi-Stim=',num2str(loopLightValues));


plottingOrder=[1 2 5 4 3];
namesForPlotting=[  'pre-I/I       '; 
                    'early-I       '; 
                    'aug-E         '; 
                    'post-I        '; 
                    'post-I-preBötC'];
namesForPlotting=cellstr(namesForPlotting);



% --------time parameters--------------------

% -----single pulses----------

% Fig 9C (control, light:0)
plotTimeMin= 11000;
time_max=    23000;
stim_on=     30000;
stim_off=    30000;

% Fig 10A and E (pre BotC stimulation, light:1 and 2) (inspiration)
% plotTimeMin= 11500;
% time_max=    25500;
% stim_on=     17900;
% stim_off=    18200;

% Fig 10B (pre BotC stimulation, light:1) (insp to exp)
% plotTimeMin= 11000;
% time_max=    21000;
% stim_on=     15000;
% stim_off=    16000;

% Fig 10C and F (pre BotC stimulation, light:1 and 2) (exp)
% plotTimeMin= 11300;
% time_max=    21300;
% stim_on=     16300;
% stim_off=    16600;

% Fig 10D (pre BotC stimulation, light:1) (exp delay)
% plotTimeMin= 11000;
% time_max=    23000;
% stim_on=     17800;
% stim_off=    18100;

% Fig 11 (pre BotC stimulation) (sustained)
% plotTimeMin=10000;
% time_max=95000;
% stim_on=35000;
% stim_off=70000;

% Fig 12A (BotC stimulation, light:1) (insp short)
% plotTimeMin= 14000;
% time_max=    26000;
% stim_on=     17900;
% stim_off=    18200;

% Fig 12B (BotC stimulation, light:1) (exp short)
% plotTimeMin= 10500;
% time_max=    22500;
% stim_on=     16200;
% stim_off=    16500;

% Fig 12C (BotC stimulation, light:1) (insp long)
% plotTimeMin= 14000;
% time_max=    28000;
% stim_on=     17900;
% stim_off=    22900;

% Fig 12D (BotC stimulation, light:1) (exp long)
% plotTimeMin= 11800;
% time_max=    25800;
% stim_on=     16400;
% stim_off=    21400;

% Fig 13 (BotC stimulation) (sustained)
% plotTimeMin=10000;
% time_max=95000;
% stim_on=35000;
% stim_off=70000;

% Fig 14A (Alsahafi stimulation, light:0.18) (speed up)
% plotTimeMin= 30000;
% time_max=    75000;
% stim_on=     40000;
% stim_off=    60000;

% Fig 15B-1 (Alsahafi stimulation, light:0.2) (end insp, prolonged)
% plotTimeMin= 10600;
% time_max=    16600;
% stim_on=     12600;
% stim_off=    12900;

% Fig 15B-2 (Alsahafi stimulation, light:0.2) beginning exp, no effect)
% plotTimeMin= 10900;
% time_max=    16900;
% stim_on=     12900;
% stim_off=    13200;

% Fig 15B-3 (Alsahafi stimulation, light:0.2)
% plotTimeMin= 11200;
% time_max=    17200;
% stim_on=     13200;
% stim_off=    13500;

% Fig 15B-4 (Alsahafi stimulation, light:0.2)
% plotTimeMin= 11900;
% time_max=    17900;
% stim_on=     13900;
% stim_off=    14200;

% Fig 15B-5 (Alsahafi stimulation, light:0.2)
% plotTimeMin= 12600;
% time_max=    18600;
% stim_on=     14600;
% stim_off=    14900;


% calculate for singe pulses
stim_duration=stim_off-stim_on;
stim_isi=stim_duration;
stim_number=1;
figureCaption=strcat(figureCaption,', duration=',num2str(stim_duration));


% ------ entrainment pulses ------------

% Fig 14B (Alsahafi stimulation, light:0.2)
% plotTimeMin=32000;
% time_max=62000;
% stim_on=35800;
% stim_off=58300;
% stim_duration=300;
% stim_isi=1500;
% stim_number=floor((stim_off-stim_on)/stim_isi);
% figureCaption=strcat(figureCaption,', entrainment:',num2str(stim_duration),'ms, ',num2str(1/(stim_isi/1000)),'Hz');



stepSize=0.05;

% -----------------------------------------


% ---------Network Parameters----------------

% general
P.numberOfNeurons=5;
P.C = 20; % capacitance
P.gL = 2.8; 
P.Eleak = -60; 
P.gsynE = 10; 
P.EsynE = 0; 
P.gsynI = 60; 
P.EsynI = -75;
P.EK = -85; 
P.ENa = 50;

% Parameters of NaP and Kdr currents
P.gKdr = 5; P.nV12 = -30; P.nk = -4; 
P.gNaP = 5; P.mV12 = -40; P.mk = -6;  
P.hV12 = -48; P.hk = 6; P.htau = 2000; P.hk2 = 2*P.hk;

% Parameters of adaptive neurons
P.gAD = 10; 
P.adT(2) = 2000; P.adK(2) = 0.9;  
P.adT(3) = 1500; P.adK(3) = 0.9;  
P.adT(4) = 1000; P.adK(4) = 1.3;
P.adT(5) = 500; P.adK(5) = 1.7;
P.adT = P.adT'; P.adK = P.adK';

% ChR conductances
P.gChR = [     8;          %n1(pre-I) 
               8;          %n2(early-I) 
               8;          %n3(aug-E)
               8;          %n4(post-I)
               8];        %n5(post-I-preBot)
         

% Parameters of output function
P.outV12(1) = -30; P.outK(1) = -8;
P.outV12(2:5) = -30; P.outK(2:5) = -4;
P.outV12 = P.outV12'; P.outK = P.outK';

%   Connections between neurons
%   n1(pre-I) is inhibited by n3(aug-E) and n4(post-I)
%   n2(early-I) is inhibited by n3(aug-E) and n4(post-I) and excited n1(pre_I) 
%   n3(aug-E) is inhibited by n2(early-I) and n4(post-I)
%   n4(post-I) is inhibited by n2(early-I) and n3(aug-E)
%   n5(post-I-preBot)

% Excitatory connections
P.a12 = 0.5; %from Pre-I to Early-I
P.a12 = P.gsynE*P.a12;  
 
% Inhibitory connections
% columns are source neurons
% rows are target neurons
% neurons    2     3     4     5
P.b =   [ 0      0.2   0.2    1.4;       %n1(pre-I) 
          0      0.5   0.1    0.7;      %n2(early-I) 
          0.37   0     0.39   0.65;      %n3(aug-E)
          0.26   0.1   0      0;         %n4(post-I)
          0.27   0.2   0      0];        %n5(post-I-preBot)
P.b = P.gsynI*P.b; 

 
% External drives
P.c =   [   0.21;          %n1(pre-I) 
            0.59;          %n2(early-I) 
            0.73;          %n3(aug-E)
            0.72;          %n4(post-I)
            0.3];          %n5(post-I-preBot)
        
P.dr = P.gsynE*P.c;
     



%% --- solve and plot control without stim--------------------------------

% Solve from DF_ChR.m -------------------------------------

% ICs
%        membrane potentials     slow variables
x0 = [-60  -60  -60  -60  -60.  0.35  0  0  0  0];
P.ChR=P.gChR*0;
time = 0:stepSize:time_max;
[t,x] = ode15s(@(t,x) DF_ChR(t,x,P), time, x0);


%Output Function
z = zeros(size(t,1),P.numberOfNeurons); 
for i=1:P.numberOfNeurons
    z(:,i) = outputFunction(x(:,i),P.outV12(i),P.outK(i));
end

time_s=t./1000;



%% Plot ------------------------------------------------

% plot control slow variables
% figureSlowVariables=figure('units','normalized','outerposition',[0 0 1 1]);
% for i=1:P.numberOfNeurons
%     ax(i)=subplot(P.numberOfNeurons,1,i);plot(time_s,x(:,plottingOrder(i)+P.numberOfNeurons),'Color',[0.9 0.9 0.9],'LineWidth',2);ylabel(namesForPlotting{plottingOrder(i)},'fontsize',12.5);grid on;axis([plotTimeMin/1000 time_max/1000 0 1]);
%     hold on;
% end


% plot control membrane potentials
% figureMembranePotentials=figure('units','normalized','outerposition',[0 0 1 1]);
% for i=1:P.numberOfNeurons
%     axx(i)=subplot(P.numberOfNeurons,1,i);plot(time_s,x(:,plottingOrder(i)),'Color',[0.9 0.9 0.9],'LineWidth',2);ylabel(namesForPlotting{plottingOrder(i)},'fontsize',12.5);grid on;axis([plotTimeMin/1000 time_max/1000 -100 0]);
%     hold on;
% end

% plot control output functions
figureOutputFunctions=figure('units','normalized','outerposition',[0 0 1 1]);
% for i=1:P.numberOfNeurons
%     axxx(i)=subplot(P.numberOfNeurons,1,i);plot(time_s-plotTimeMin/1000,z(:,plottingOrder(i)),'Color',[0.9 0.9 0.9],'LineWidth',2);ylabel(namesForPlotting{plottingOrder(i)},'fontsize',12.5);grid on;axis([0 time_max/1000-plotTimeMin/1000 0 1]);
%     hold on;
% end






%% --- solve and plot ChR --------------------------------------------

% Solve from DF_ChR.m -----------------------------------

% ICs
%        membrane potentials     slow variables
x0 = [-60  -60  -60  -60  -60.  0.35  0  0  0  0];
 
     
% break down in three time intervals for piecewise integration 
% (before, during and after stimulations)
% loop through the "during" time interval for repetitive stimulations 
% (e.g. entrainment)
% see> http://stackoverflow.com/questions/28289109/ode-15s-with-time-dependent-input-parameters


% before stim
P.ChR=P.gChR*0;
time = 0:stepSize:stim_on-stepSize;
[tTemp,xTemp] = ode15s(@(t,x) DF_ChR(t,x,P), time, x0);
t=tTemp;
x=xTemp;

% during stim
temp_stim_on=stim_on;
for iStim=1:stim_number  
    % during stim
    P.ChR=P.gChR.*ChRLight;
    x0 = xTemp(end, :);
    time = temp_stim_on-stepSize:stepSize:temp_stim_on+stim_duration;
    [tTemp,xTemp] = ode15s(@(t,x) DF_ChR(t,x,P), time, x0);
    t=cat(1, t, tTemp);
    x=cat(1, x, xTemp);
    
    % inbetween stims
    if stim_number > 1   % there is only an interval if there is more than one pulse
        P.ChR=P.gChR*0;
        x0 = xTemp(end, :);
        time = temp_stim_on+stim_duration-stepSize:stepSize:temp_stim_on+stim_isi;
        [tTemp,xTemp] = ode15s(@(t,x) DF_ChR(t,x,P), time, x0);
        t=cat(1, t, tTemp);
        x=cat(1, x, xTemp);
    end;
    
    temp_stim_on=temp_stim_on+stim_isi;
end;

% after stim 
if stim_off<time_max
    P.ChR=P.gChR*0;
    x0 = xTemp(end, :);
    time = temp_stim_on-stepSize:stepSize:time_max;
    [tTemp,xTemp] = ode15s(@(t,x) DF_ChR(t,x,P), time, x0);
    t=cat(1, t, tTemp);
    x=cat(1, x, xTemp);
end;


% Output Function
z = zeros(size(t,1),P.numberOfNeurons); 
for i=1:P.numberOfNeurons
    z(:,i) = outputFunction(x(:,i),P.outV12(i),P.outK(i));
end
time_s=t./1000;



%Plot ----------------------------------------------------------

% plot stimulation slow variables
% figure(figureSlowVariables);
% for i=1:P.numberOfNeurons
%     ax(i)=subplot(P.numberOfNeurons,1,i);plot(time_s,x(:,plottingOrder(i)+P.numberOfNeurons),'Color','Black','LineWidth',2);ylabel(namesForPlotting{plottingOrder(i)},'fontsize',12.5);grid on;axis([plotTimeMin/1000 time_max/1000 0 1]);
%     hold on;
%     % plot stim
%     temp_stim_on=stim_on;
%     for iStim=1:stim_number
%         plot([temp_stim_on/1000, temp_stim_on/1000],[0, 1],'r--');
%         plot([(temp_stim_on+stim_duration)/1000, (temp_stim_on+stim_duration)/1000],[0, 1],'r--');
%         temp_stim_on=temp_stim_on+stim_isi;
%     end;
% end;
% set(gcf,'name',strcat(num2str(figureCaption), ',  (slow variables)'),'numbertitle','off');
% linkaxes(ax);


% plot stimulation membrane potentials
% figure(figureMembranePotentials);
% for i=1:P.numberOfNeurons
%     axx(i)=subplot(P.numberOfNeurons,1,i);plot(time_s,x(:,plottingOrder(i)),'Color','Black','LineWidth',2);ylabel(namesForPlotting{plottingOrder(i)},'fontsize',12.5);grid on;axis([plotTimeMin/1000 time_max/1000 -100 0]);
%     hold on;
%     % plot stim
%     temp_stim_on=stim_on;
%     for iStim=1:stim_number
%         plot([temp_stim_on/1000, temp_stim_on/1000],[-100, 0],'r--');
%         plot([(temp_stim_on+stim_duration)/1000, (temp_stim_on+stim_duration)/1000],[-100, 0],'r--');
%         temp_stim_on=temp_stim_on+stim_isi;
%     end;
% end;
% set(gcf,'name',strcat(num2str(figureCaption), ',  (membrane potentials)'),'numbertitle','off');

% linkaxes(axx);


% plot stimulation output funtions
figure(figureOutputFunctions);
for i=1:P.numberOfNeurons
    axxx(i)=subplot(P.numberOfNeurons,1,i);plot(time_s-plotTimeMin/1000,z(:,plottingOrder(i)),'Color','Black','LineWidth',1);ylabel(namesForPlotting{plottingOrder(i)},'fontsize',12.5);grid on;axis([0 time_max/1000-plotTimeMin/1000 0 1]);
    hold on;
    %plot stim
    %temp_stim_on=stim_on;
    temp_stim_on=stim_on-plotTimeMin;
    for iStim=1:stim_number
        plot([temp_stim_on/1000, temp_stim_on/1000],[0, 100],'r--');
        plot([(temp_stim_on+stim_duration)/1000, (temp_stim_on+stim_duration)/1000],[0, 100],'r--');
        temp_stim_on=temp_stim_on+stim_isi;
    end;
end;
set(gcf,'name',strcat(num2str(figureCaption),'  (output functions)'),'numbertitle','off');

for i=1:P.numberOfNeurons-1
    set(axxx(i),'XTickLabel',[]);
end;

ylabel(axxx(3),{'post-I';'pre-BötC'});

linkaxes(axxx);





end;






