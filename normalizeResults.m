function [centers, groups, ctrPop, commutingPop, commutingCost] = normalizeResults(x, data, pop, costs, names, ctrNames, md)
    
    if(length(x) < length(data))
        x(length(data),1) = 0;                  % Méretre igazítás
    end
    centers = ctrNames(logical(x == 1));    % Központok nevei
    data(:,~logical(x == 1)) = [];          % Felesleges oszlopok törlése
    groups = cell(length(centers), 1);      % Járások helyének létrehozása

    ctrPop = sum(pop(find(x)));
    commutingPop = sum(pop(find(~x)));
    commutingCost = 0;
    
    for i = 1:length(data)
        minValue = min(data(i,:));

        j = find(data(i,:) == min(data(i,:)));
        commutingCost = commutingCost + costs(i, j);
        
        if (minValue >= md)
            minValue, md, centers, names(i)
            error('A kapott megoldás nem elégíti ki a megadott távolságparamétert.');
        end
        
        minCol = find(data(i,:) == minValue);
        groups(minCol) = strcat(groups{minCol}, ';', names(i));
    end
    
    groups = groups';
end