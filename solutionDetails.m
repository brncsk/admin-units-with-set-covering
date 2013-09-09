function [details] =  solutionDetails(solution, data, pop, costs, names, md)

% 1. Check if the solution is sane

    solution(length(data),1) = 0;
    data(:, ~logical(solution == 1)) = [];

    disp(' ');disp(' ');disp('**********');
    
    ctrs = cell2mat(strcat(names(find(solution)), { ', ' })');
    ctrs = ctrs(1:end-2);
    disp(ctrs);
    
    disp('**********');disp(' ');

    if sum(min(data,[],2) > md)
        error('A kapott megoldás hibás.')
    else
        disp('A kapott megoldás helyes a távolságparaméteren belül.');
    end
    
    disp(' ');

    ctrPop = sum(pop(find(solution)));
    commutingPop = sum(pop(find(~solution)));
    commutingCost = 0;

    for i=1:length(data)
        j = find(data(i,:) == min(data(i,:)));
        commutingCost = commutingCost + costs(i, j);
    end

    
    disp(['Járások száma:                         ' num2str(sum(solution))]);
    disp(['Járásközpontok népességének száma:     ' num2str(ctrPop)]);
    disp(['Ingázásra kényszerülő népesség száma:  ' num2str(commutingPop)]);
    disp(['Ingázási költség Σ(népesség*távolság): ' num2str(commutingCost)]);
    disp(' ');disp(' ');disp(' ');
    
    details = { ctrs, sum(solution), ctrPop, commutingPop, commutingCost };
end