clc,clear,close all
warning off
format longG
% ��ʼ��ө�����㷨����
maxiter = 30;   % ��������
sizepop = 50;   % ��Ⱥ����
alpha=0.5;      % �������� 0--1֮��ĳ���
gamma=1e-3;     % ��ǿ����ϵ��Absorption Coefficient
delta=0.99;     % ��������ϵ��
% δ֪����ȡֵ��Χ
popmin1 = -1;  popmax1 = 1; % x1
popmin2 = -1;  popmax2 = 1; % x2
% ��ʼ��ө�����Ⱥλ��
for i=1:sizepop
    x1 = popmin1 + (popmax1-popmin1)*rand;
    x2 = popmin2 + (popmax2-popmin2)*rand;
    pop(i,1) = x1;
    pop(i,2) = x2;
    fitness(i) = fun([x1,x2]);  % ��Ӧ�Ⱥ���ֵ--Ŀ�꺯��ֵ--���ȫ�ֵļ���ֵ -- Light
end
clear x1 x2
% ��¼һ������ֵ
[bestfitness,bestindex]=max(fitness);  % ���ȫ�ֵļ���ֵ -- Light
zbest=pop(bestindex,:);   % ȫ�����
fitnesszbest=bestfitness; % ȫ�������Ӧ��ֵ
% main loop
% ����Ѱ��
for i=1:maxiter
    disp(['Iteration ' num2str(i)]);
   
    % �����µĸ����Լ���Ӧ����Ӧ��ֵ���������λ�ø��±Ƚ�
    for j=1:sizepop
        popnew(j,1) = unifrnd(popmin1,popmax1,1,1);    % ���ȷֲ���
        popnew(j,2) = unifrnd(popmin2,popmax2,1,1);    % ���ȷֲ���
        fitnessnew(j) = fun( popnew(j,:) );   % ������Ӧ��ֵ
    end
    % ����λ�ø���
    pop = firefly_move(pop,fitness,popnew,fitnessnew,alpha,gamma, [popmin1,popmin2], [popmax1,popmax2]);
   
    for j=1:sizepop
        % ������Ӧ��ֵ
        fitness(j) = fun( pop(j,:) );  % ��Ӧ�Ⱥ���ֵ--Ŀ�꺯��ֵ--���ȫ�ֵļ���ֵ -- Light
        
        if fitness(j)>bestfitness
            bestfitness = fitness(j);
            zbest =  pop(j,:);
        end
        
    end
   
    fitness_iter(i) = bestfitness;
   
    % ��������
    alpha = alpha*delta;
end