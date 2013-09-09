function [centers, groups, ctrPop, commutingPop, commutingCost, runtime, exitflag, output] = ...
    solveWeightedProblem(names, data, weightNames, weights, population, md)
    
    tic;

    [~,loc]     = ismember(names, weightNames);
    weights     = weights(loc);
    population  = population(loc);
    costs       = data * diag(population);

    f           =  weights;
	A           = (-(data <= md))';
    b           = -ones(length(A(1,:)), 1);

    [x, ~, exitflag, output] = solveProblem(md, f, A, b, [], []);
    
    [centers, groups, ctrPop, commutingPop, commutingCost] = ...
        normalizeResults(x, data, population, costs, names, names, md);
    
    runtime  = toc;
    
end