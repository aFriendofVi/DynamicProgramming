threshold = 100; % initial mean value of the offers
days = 30; % horizon
meanDayValue = 0; % policy value of the last day is exactly the initial threshold
for i = days:-1:1 % backfold from the last day to the first day
    sim = normrnd(100,20,100000,1); % generate simulation data
    policy = sim>=threshold; % policy function (binary)
    actionValue = max(sim,threshold); % evaluate the action;
    threshold = mean(actionValue); % update the threshold
    meanDayValue = [threshold,meanDayValue]; % expected reward at the beginning of day_i;
end
hold on;
plot(meanDayValue);
title(['Expected reward at day 1: ',num2str(meanDayValue(1))]);
xlabel('Day');ylabel('Threshold');axis([1,31,0,meanDayValue(1)+20]);