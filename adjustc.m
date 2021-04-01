%this function adjusts the C1(t) explicit solution provided a D0 value
%this function serves as a helper function to the script that simulates
%treatment dosages (allows one to simulate adminster a Dose differnt
%than the standard 20mg)
function Ct = adjustc(DOSE)
% Declare symbolic variables
syms s t F D0 Ka Vd Ke K12 K21 C1(t) C2(t) C1new C2new V1 V2 
% Write the two equations as symbolic expressions by moving all terms to
% RHS and assign them to f1 and f2
f1 = -diff(C1(t),t) + F*D0*Ka*exp(-Ka*t)/V1-Ke*C1(t)-K12*C1(t)+K21*(V2/V1)*C2(t);
f2 = -diff(C2(t),t) + K12*(V1/V2)*C1(t)-K21*C2(t);
% Compute laplace transforms
f1=laplace(f1,t,s);
f2=laplace(f2,t,s);
% substitute C1new and C2new for the laplace transform of C1 and C2 in f1
% and f2
f1=subs(f1,laplace(C1(t),t,s),C1new);
f1=subs(f1,laplace(C2(t),t,s),C2new);
f2=subs(f2,laplace(C1(t),t,s),C1new);
f2=subs(f2,laplace(C2(t),t,s),C2new);
% Substitute initial conditions in the laplace transformed expressions
f1=subs(f1,C1(0),0);
f2=subs(f2,C2(0),0);
% Solve for C1new and C2new
sol=solve([f1==0,f2==0],[C1new,C2new]);
C1new(s)=sol.C1new;
C2new(s)=sol.C2new;
% Take inverse laplace transform to convert into time domain
C1(t)=ilaplace(C1new(s),s,t);
C2(t)=ilaplace(C2new(s),s,t);

% Substitute Ke, and solve for Ka, K12, K21 using three equations
% 1) Substitute Cmax at tmax in C1(t)
% 2) Differentiate C1(t) with t and equate it to zero
% 3) Integrate C1(t) with respect to t upto 48h and add C1(48)/Ke, and
% equate this to AUCinf

Cmax=21.2; %ng/ml
tmax=0.8; %h
AUCinf=96; %ng-h/ml
tlast=48; %h
D0val=DOSE*1e+6; %ng
Fval=0.21;
Vdval=5000;%9464*1000*Fval; %ml
V1val=5000; %ml
V2val=37000; %ml
thalf=30.7; %h

Keval = 8.7500; %1/h
Kaval = 0.3822;
K12val = 7.6239;
K21val = 1.6299;

C1(t)=subs(C1(t),F,Fval);
C1(t)=subs(C1(t),D0,D0val);
C1(t)=subs(C1(t),V1,V1val);
C1(t)=subs(C1(t),Ka,Kaval);
C1(t)=subs(C1(t),K12,K12val);
C1(t)=subs(C1(t),K21,K21val);
C1(t)=subs(C1(t),Ke,Keval);
eq1 = matlabFunction(C1(t),'Vars',{t});
Ct = eq1;
end