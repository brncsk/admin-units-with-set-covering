function [x, fval, exitflag, output] = solveProblem(md, f, Aineq, bineq, Aeq, beq)
%{
    X_TOL_MIN    = 1.0e-100;
    X_TOL_MAX    = 1.0e-10;
    X_TOL_STEP   = 1.0e-10;

    RLP_TOL_MIN  = 1.0e-009;
    RLP_TOL_MAX  = 1.0e-005;
    RLP_TOL_STEP = 1.0e-001;
%}
    
    X_TOL_VALUES = [1.0e-100 1.0e-50 1.0e-20 1.0e-10];
    RLP_TOL_VALUES = [1.0e-009 1.0e-008 1.0e-007 1.0e-005];

 
%    for i=1:length(X_TOL_VALUES)
        x_tol = X_TOL_VALUES(1);
        
%        for j=1:length(RLP_TOL_VALUES)
            rlp_tol = RLP_TOL_VALUES(1);
            cont = false;

            options = optimset(                     ...
                'NodeDisplayInterval', 1,           ...
                'Display',             'iter',      ...
                'TolXInteger',         x_tol,       ...
                'TolRLPFun',           rlp_tol,     ...
                'UseParallel',         'always',    ...
                'MaxTime',             Inf      ... % big fucking value
            );

            try
                problem = struct(                      ...
                    'f',                   f,          ...
                    'Aineq',               Aineq,      ...
                    'bineq',               bineq,      ...
                    'Aeq',                 Aeq,        ...
                    'beq',                 beq,        ...
                    'x0',                  [],         ...
                    'options',             options,    ...
                    'solver',              'bintprog'  ...
                );

%                [x, fval, exitflag, output] = bintprog(problem)
                [x, fval, exitflag, output, result] = bintprog(f, Aineq, bineq, Aeq, beq, [], options)
%            catch E
%                cont = true;
%            end
            
            if(cont)
%                continue;
            else
                fprintf('md = %d, fval=%d, sum(x==1)=%s, exitflag=%d, x_tol = %e, rlp_tol = %e\n', md, fval, num2str(sum(x==1)), exitflag, x_tol, rlp_tol)
%+                break;
            end % if
            
%        end     % while (rlp_tol)
        
%        if(cont)
%            continue;
%        else
%            break;
%        end
%    end         % while (x_tol)
end             % function