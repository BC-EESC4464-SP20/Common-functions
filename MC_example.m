%%Example of a Monte Carlo error analysis

% Use this program to determine the error in any expression using a Monte Carlo method
% The example here is for calculating the error in calculating air-sea CO2 flux, where
% CO2flux = k*solubility*(CO2ocean - CO2atm)
% In this example, and error values are given for k, CO2ocean, and CO2atm.


%randn picks a random number between -3 and +3 weighted by a normal distribution 
clear; randn('state',sum(100*clock));
% enter the number of solutions to calculate
counter = 10000;
%Mean mean value for each term in expression
k=6; %units = m/day
CO2atm = 400; %units = uatm
CO2ocean = 350; %units = uatm
CO2sat=33.2/1000; % mmol m-3 uatm-1

%Equation and calculation without any error
CO2flux_noerr = k*CO2sat*(CO2atm - CO2ocean); %units = mmol m-2 d-1

%Mean standard deviation for each term in expression
ksd= k*0.15;
CO2atmsd = 0.5;
CO2oceansd = 2;

% loop to calculate solutions, where CO2flux is the array containing solution population
for i = 1:counter
    CO2flux(i)= (k+randn*ksd)*[(CO2atm+randn*CO2atmsd) - (CO2ocean+randn*CO2oceansd)]*CO2sat;
end

%plots histogram of solutions using 40 bins (vary the bin number to spread out the histogram) 
hist(CO2flux,40)
title(['Distribution of calculated values in ' num2str(counter) ' iterations of Monte Carlo analysis'])

%calculate statistics of solution population
CO2flux_med= median(CO2flux)
CO2flux_avg= mean(CO2flux)
CO2flux_std= std(CO2flux)



