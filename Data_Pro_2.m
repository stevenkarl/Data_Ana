%Steven Karl 
%MEID 959-489
%Problem 2
%----------------------------------------

%Given 
n = 2; 
m = 1;
k = 0.65;
g = 9.81;
V_o = 50.0;
theta_15 = 15;
theta_39 = 39.9;
sig_v = 5;
sig_theta_15 = 1.5;
sig_theta_39 = 3.99;

%error in Vo
V_u = V_o + sig_v;
V_l = V_o - sig_v;

%Error in theta = 15 
theta_15_u = theta_15 + sig_theta_15;
theta_15_l = theta_15 - sig_theta_15;

%Error in theta = 39.9 
theta_39_u = theta_39 + sig_theta_39;
theta_39_l = theta_39 - sig_theta_39;

%Calculation for time traveled 

%case 1: vo + uncertainty for 15 
S_y1 = @(t) (m/k) * (V_u*sin(theta_15) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_15_vo_u = fzero(S_y1,4);

%case 1a: vo + uncertainty for 39 
S_y2 = @(t) (m/k) * (V_u*sin(theta_39) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_39_vo_u = fzero(S_y2,4);

%case 2: vo - uncertainty for 15
S_y3 = @(t) (m/k) * (V_l*sin(theta_15) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_15_vo_l = fzero(S_y3,4);

%case 2a: vo - uncertainty for 39 
S_y4 = @(t) (m/k) * (V_l*sin(theta_39) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_39_vo_l = fzero(S_y4,4);

%case 3: theta15 + uncertainty
S_y5 = @(t) (m/k) * (V_o*sin(theta_15_u) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_theta15_u = fzero(S_y5,5);

%case 4: theta15 - uncertainty
S_y6 = @(t) (m/k) * (V_o*sin(theta_15_l) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_theta15_l = fzero(S_y6,4);

%case 5: theta39 + uncertainty
S_y7 = @(t) (m/k) * (V_o*sin(theta_39_u) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_theta39_u = fzero(S_y7,2);

%cast 6: theta39 - uncertainty
S_y8 = @(t) (m/k) * (V_o*sin(theta_39_l) + ((m*g)/(k))) * (1 - exp(-(k/m)*t)) - ((m*g)/(k))*t;
time_theta39_l = fzero(S_y8,1);


%equations for upper and lower error

%sx_vu for theta is 15 
sx_Vu15 = ((V_u*m)/(k))*cos(theta_15)*(1 - exp(-(k/m)*time_15_vo_u));
sx_Vl15 = ((V_l*m)/(k))*cos(theta_15)*(1 - exp(-(k/m)*time_15_vo_l));

%sx_vu for theta is 15 
sx_Vu39 = ((V_u*m)/(k))*cos(theta_39)*(1 - exp(-(k/m)*time_39_vo_u));
sx_Vl39 = ((V_l*m)/(k))*cos(theta_39)*(1 - exp(-(k/m)*time_39_vo_l));

sx_theta15u = ((V_o*m)/(k))*cos(theta_15_u)*(1 - exp(-(k/m)*time_theta15_u));
sx_theta15l = ((V_o*m)/(k))*cos(theta_15_l)*(1 - exp(-(k/m)*time_theta15_l));

sx_theta39u = ((V_o*m)/(k))*cos(theta_39_u)*(1 - exp(-(k/m)*time_theta39_u));
sx_theta39l = ((V_o*m)/(k))*cos(theta_39_l)*(1 - exp(-(k/m)*time_theta39_l));

%upper and lower error vectors
upper_error_15 = [sx_Vu15, sx_theta15u];
lower_error_15 = [sx_Vl15, sx_theta15l];

upper_error_39 = [sx_Vu39, sx_theta39u];
lower_error_39 = [sx_Vl39, sx_theta39l];

%Loop that calculate the uncertainty in sx based on the angle = 15
sum1 = 0; 
for i = 1:n 
    sum1 = sum1 + ((upper_error_15(i) - lower_error_15(i))/2)^2;
end
sig_u_15 = sqrt(sum1); 
fprintf('The uncertainty in the horizontal launch distance for theta of 15 degrees = %i.\n\n',sig_u_15);

%%Loop that calculate the uncertainty in sx based on the angle = 39
sum2 = 0;
for i = 1:n 
    sum2 = sum2 + ((upper_error_39(i) - lower_error_39(i))/2)^2;
end
sig_u_39 = sqrt(sum2); 
fprintf('The uncertainty in the horizontal launch distance for theta of 39 degrees = %i.\n\n',sig_u_39);
