clc,clear,close all
warning off
format longG
% 初始化萤火虫的算法参数
maxiter = 30;   % 迭代次数
sizepop = 50;   % 种群数量
alpha=0.5;      % 步长因子 0--1之间的常数
gamma=1e-3;     % 光强吸收系数Absorption Coefficient
delta=0.99;     % 步长调整系数
% 未知量的取值范围
popmin1 = -1;  popmax1 = 1; % x1
popmin2 = -1;  popmax2 = 1; % x2
% 初始化萤火虫种群位置
for i=1:sizepop
    x1 = popmin1 + (popmax1-popmin1)*rand;
    x2 = popmin2 + (popmax2-popmin2)*rand;
    pop(i,1) = x1;
    pop(i,2) = x2;
    fitness(i) = fun([x1,x2]);  % 适应度函数值--目标函数值--求解全局的极大值 -- Light
end
clear x1 x2
% 记录一组最优值
[bestfitness,bestindex]=max(fitness);  % 求解全局的极大值 -- Light
zbest=pop(bestindex,:);   % 全局最佳
fitnesszbest=bestfitness; % 全局最佳适应度值
% main loop
% 迭代寻优
for i=1:maxiter
    disp(['Iteration ' num2str(i)]);
   
    % 产生新的个体以及对应的适应度值，参与个体位置更新比较
    for j=1:sizepop
        popnew(j,1) = unifrnd(popmin1,popmax1,1,1);    % 均匀分布解
        popnew(j,2) = unifrnd(popmin2,popmax2,1,1);    % 均匀分布解
        fitnessnew(j) = fun( popnew(j,:) );   % 计算适应度值
    end
    % 个体位置更新
    pop = firefly_move(pop,fitness,popnew,fitnessnew,alpha,gamma, [popmin1,popmin2], [popmax1,popmax2]);
   
    for j=1:sizepop
        % 计算适应度值
        fitness(j) = fun( pop(j,:) );  % 适应度函数值--目标函数值--求解全局的极大值 -- Light
        
        if fitness(j)>bestfitness
            bestfitness = fitness(j);
            zbest =  pop(j,:);
        end
        
    end
   
    fitness_iter(i) = bestfitness;
   
    % 调整步长
    alpha = alpha*delta;
end