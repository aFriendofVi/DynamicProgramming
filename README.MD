# ISE416 Dynamic Programming
### Homework 1
_Author: Yuheng Huang_
_Sep-1-2016_

## 1  Code

```matlab
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

```

## 2 Approximations
The code generates 100000 random numbers distributed as N(100,20^2) in each loop. Store these numbers in a 100000*1 vector _sim_
Then use _mean(max(sim,threshold))_ to compute the expected value of the state.

## 3 Numerical values of the 31 days threshold

  _Columns 1 through 14_

  136.2016  135.9103  135.6182  135.3019  134.9741  134.6327  134.2804  133.9236  133.5356  133.1281  132.7030  132.2645  131.7974  131.2797

  _Columns 15 through 28_

  130.7442  130.1624  129.5385  128.8648  128.1586  127.3738  126.4999  125.5473  124.4531  123.2456  121.8472  120.2299  118.2677  115.8233

  _Columns 29 through 31_

  112.5873  107.9505         0




## 4 Plotting
![Price threshold curve] (\Thresholds.jpg)

 