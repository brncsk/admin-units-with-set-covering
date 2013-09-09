function [centers, groups, ctrPop, commutingPop, commutingCost, runtime, exitflag, output] = ...
    solveWeightedProblemWithConstraints(names, data, weightNames, weights, population, constraints, md)

    tic;

    [~,loc]     = ismember(names, weightNames);
    weights     = weights(loc);
    population  = population(loc);
    constraints = constraints(loc);
    costs       = data * diag(population);

    f           =  weights;
	Aineq       = (-(data <= md))';
    bineq       = -ones(length(Aineq(1,:)), 1);
    Aeq         = diag(constraints);
    beq         = constraints;

    [x, ~, exitflag, output] = solveProblem(f, Aineq, bineq, Aeq, beq);
    
    [centers, groups, ctrPop, commutingPop, commutingCost] = ...
        normalizeResults(x, data, population, costs, names, names, md);
    
    runtime = toc;
    
end