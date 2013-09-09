function [centers, groups, ctrPop, commutingPop, commutingCost, meanDst] = normalizeResults2(x, fval, data, pop, costs, names, ctrNames, md)

    if(length(x) < length(data))
        x(length(data),1) = 0;                  % Méretre igazítás
    end
    centers = ctrNames(logical(x == 1));    % Központok nevei
    data(:,~logical(x == 1)) = [];          % Felesleges oszlopok törlése
    costs(:,~logical(x == 1)) = [];
    groups = cell(length(centers), 1);      % Járások helyének létrehozása
    
    ctrPop = sum(pop(find(x)));
    commutingPop = sum(pop(find(~x)));
    commutingCost = 0;
    
    for i = 1:length(data)
        minValue = min(data(i,:));

        j = find(data(i,:) == minValue);        
        commutingCost = commutingCost + costs(i, j);
        groups(j) = strcat(groups{j}, ';', names(i));
    end
    
    groups = groups';
    meanDst = fval(4);
end