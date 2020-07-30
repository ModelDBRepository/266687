%ODEs

function dx = DF_ChR(t,x,P)


dx = 0*x;

%Neuron outputs
v = x(1:P.numberOfNeurons);
y=zeros(P.numberOfNeurons,1);
for j=1:P.numberOfNeurons
    y(j) = outputFunction(v(j),P.outV12(j),P.outK(j));
end


%Kdr
n_inf = (1+exp((v(1)-P.nV12)/P.nk))^(-1);

%NaP - for Pre-I (n1)
mp_inf = (1+exp((v(1)-P.mV12)/P.mk))^(-1);
hp_inf = (1+exp((v(1)-P.hV12)/P.hk))^(-1);
tau_inf = P.htau*(cosh((v(1)-P.hV12)/P.hk2))^(-1);
dx(6) = (hp_inf-x(6))/tau_inf;


%Adaptation variables (n2-n5)
dx(7:10) = (-x(7:10)+P.adK(2:5).*y(2:5))./P.adT(2:5);

%Currents
q(1) = P.gNaP*mp_inf*x(6)*(v(1)-P.ENa)+P.gKdr*n_inf^4*(v(1)-P.EK);
q(2:5) = P.gAD*x(7:10).*(v(2:5)-P.EK);
q(2) = q(2)+P.a12*y(1)*(v(2)-P.EsynE);
q(3) = q(3);
yi = y(2:5);

%Membrane potentials
dx(1:P.numberOfNeurons) = -(q'+P.gL*(v-P.Eleak)+P.dr.*(v-P.EsynE)+P.b*yi.*(v-P.EsynI)+P.ChR.*(v-P.EsynE))/P.C;




