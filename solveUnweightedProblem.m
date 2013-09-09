function [centers, groups, ctrPop, commutingPop, commutingCost, runtime, exitflag, output] = ...
    solveUnweightedProblem(names, data, popNames, population, md)

    tic;
    
    [~,loc]     = ismember(names, popNames);
    population  = population(loc);
    costs       = data * diag(population);

    f     =  ones(length(data), 1);
	A     = (-(data <= md))';
    b     = -ones(length(A(1,:)), 1);

    [x, ~, exitflag, output] = solveProblem(md, f, A, b, [], []);
    
    [centers, groups, ctrPop, commutingPop, commutingCost] = ...
        normalizeResults(x, data, population, costs, names, names, md);
    
    runtime = toc;
    
end