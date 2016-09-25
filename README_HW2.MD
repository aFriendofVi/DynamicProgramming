# ISE416 Dynamic Programming
### Homework 2
_Author: Yuheng Huang_
_Sep-25-2016_

## 0 Code
```matlab


P(1,:,:) = [0.8 0.2 0; 0.2 0.6 0.2; 0.2 0 0.8];
P(2,:,:) = [0.5 0.5 0; 0.3 0.4 0.3; 0.7 0 0.3];
R(1,:,:) = [2 -1 1; -3 2 0; 4 0 -1];
R(2,:,:) =[ 1 0 2; -2 1 1; 1 -2 1];
gamma = 0.95;
prob = zeros(8,3,3);
reward = zeros(8,3,3);
policy = zeros(8,3);
omega = zeros(8,3);
totalReward = zeros(1,8);
count = 0;
ite = 200;

clc;
disp('=================================================================================');
% Generate 8 possible policies
for i = 1:2
    for j = 1:2
        for k = 1:2
            count = count+1;
            policy(count,:) = [i,j,k];
            prob(count,:,:) = [P(i,1,:);P(j,2,:);P(k,3,:)];
            reward(count,:,:) = [R(i,1,:);R(j,2,:);R(k,3,:)];
        end
    end
end

% grid search with brute force for the optimal policy
for m = 1:8
    pp = squeeze(prob(m,:,:));
    rr = squeeze(reward(m,:,:));
    
    % omega is a stationary distribution
      [V,D]=eig(pp+eye(3)*0.00000001);
      omega(m,:) = V(:,abs(sum(D)-1)<1e-5)';

      % one can varify, initial state doesn't matter
%     omega(m,:) = [0 0 0];
%     omega(m,1) = 1;
    
%     omega(m,:) = omega(m,:)*pp^2000;
    
    omega(m,:) = omega(m,:)./sum(omega(m,:),2);
    
    if min(omega(m,:))<0
        error('Oh Sanp!');
    end
    
    tmp = 0;
    for n = 1:ite
        % be aware that this is wrong:
        %(gamma^n)*omega(m,:)*sum(pp^n.*rr,2);
        % The weighted average of reward condition on s_t is pp.*rr
        % not pp^n.*rr
        % s_t is represented by omega*pp^(n-1)
        tmp = tmp+(gamma^n)*omega(m,:)*pp^(n-1)*sum(pp.*rr,2);
    end
    totalReward(m)=tmp;
    tmp = 0;
end
% disp(totalReward);
L=find(totalReward == max(totalReward));

count =0;
for i = 1:2
    for j = 1:2
        for k = 1:2
            count = count+1;
            if count==L
                optPolicy = [i,j,k];
            end
        end
    end
end
disp('Problem 1');
disp('----------');
disp(['Optimal policy is:',num2str(L)]);
disp(['Action|State = 1: Action ',num2str(optPolicy(1))]);
disp(['Action|State = 2: Action ',num2str(optPolicy(2))]);
disp(['Action|State = 3: Action ',num2str(optPolicy(3))]);


stateReward = [0 0 0];

% set transition matrix and reward matrix with optimal policy
pp = squeeze(prob(L,:,:));
rr = squeeze(reward(L,:,:));

% compute the expected reward for 3 different initial states
for l = 1:3
    s0 = [0 0 0];
    s0(l)=1;
    S = zeros(1,ite);
    for n = 1:ite
        
        S(n) = (gamma^n)*s0*pp^(n-1)*sum(pp.*rr,2);
        
    end
    
    %plot the expected rewards at time t for every t:1...N
    hold on;
    subplot(1,3,l);
    plot(S);
    stateReward(l) = sum(S);
end
disp(['E(Reward|initial State = 1): ',num2str(stateReward(1))]);
disp(['E(Reward|initial State = 2): ',num2str(stateReward(2))]);
disp(['E(Reward|initial State = 3): ',num2str(stateReward(3))]);

disp('=================================================================================');
disp('Problem 2');
disp('----------');

%set initial state
s0 = [1 0 0];

%recursively display the probability
for t = 1:5
    disp(s0*pp^t);
end
disp('=================================================================================');
```

## Problem 1
Decision rule:
	\pi(S_t = 1) = Action 1
	\pi(S_t = 2) = Action 1
	\pi(S_t = 3) = Action 2
	E(Reward|initial State = 1): 21.7197
	E(Reward|initial State = 2): 20.4355
	E(Reward|initial State = 3): 21.5294
	
![Expected Reward] (\hw2_graph.jpg)
	
## Problem 2

t=1: 0.8                       0.2                         0
t=2: 0.68                      0.28                      0.04
t=3: 0.628                     0.304                     0.068
t=4: 0.6108                     0.308                    0.0812
t=5: 0.60708                   0.30696                   0.08596


 