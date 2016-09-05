%=================================================================
% Title: ISE-416 Dynamic Programming
%           Homework 1
% Auther: Yuheng Huang (Jerry)
% Sept 2, 2016 at 18:00 EST
% Platform: Window 7
% IDE: Matlab R2015b
%=================================================================


% initial mean value of the offers is the initial threshold
threshold = 100; 

% Set horizon
days = 30; 

% Expected value of the last day is exactly the initial threshold
meanDayValue = 0; 

% backfold from the last day to the first day
for i = days:-1:1 
    % generate 100000 simulation data
    sim = normrnd(100,20,100000,1); 
    
    % Action (binary)
    action = sim>=threshold; 
    
    % evaluate the action;
    actionValue = max(sim,threshold); 
    
    % update the threshold
    threshold = mean(actionValue); 
    
    % Store the expected reward at the beginning of day_i in a vector;
    meanDayValue = [threshold,meanDayValue]; 
end

% Artist painting behind the screen
hold on;
plot(meanDayValue);
title(['Expected reward at day 1: ',num2str(meanDayValue(1))]);
xlabel('Day');ylabel('Threshold');axis([1,31,0,meanDayValue(1)+20]);
clc;
disp(['Expected reward at day 1: ',num2str(meanDayValue(1)),' dollars']);