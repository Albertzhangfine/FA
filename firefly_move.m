function pop = firefly_move(pop,fitness,popnew,fitnessnew,alpha,gamma, popmin, popmax)

popmin1 = popmin(1);  popmax1 = popmax(1); % x1
popmin2 = popmin(2);  popmax2 = popmax(2); % x2

for i=1:size(pop,1)
    % The attractiveness parameter beta=exp(-gamma*r)
    for j=1:size(popnew,1)
        r=sqrt( sum( (pop(i,1)-popnew(j,1) ).^2+(pop(i,2)-popnew(j,2)).^2 ) );
        if fitness(i) < fitnessnew(j), % 亮度低（适应度值小）的进行个体更新
            
            beta0=1e-2;   
            beta=beta0*exp(-gamma*r.^2);
            % 个体更新
            pop1=[];
            pop1(1,1) = pop(i,1) * (1-beta) + popnew(j,1) * beta+alpha.*(rand-0.5);
            pop1(1,2) = pop(i,2) * (1-beta) + popnew(j,2) * beta+alpha.*(rand-0.5);
            
            % x1  越界限制
            if pop1(1,1)>popmax1
                pop1(1,1)=popmax1;
            end
            if pop1(1,1)<popmin1
                pop1(1,1)=popmin1;
            end
            % x2  越界限制
            if pop1(1,2)>popmax2
                pop1(1,2)=popmax2;
            end
            if pop1(1,2)<popmin2
                pop1(1,2)=popmin2;
            end
            
            pop(i,:) = pop1;
            
        end
    end
end