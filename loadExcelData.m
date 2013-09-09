function [data, names, weights, weightNames] = loadExcelData(filename, sheet, weightField)
    [data, names] = xlsread(filename, sheet);
    names =  names(2:end,1);
    weightRange = [char(64 + weightField)  '1:' char(64 + weightField) '3153'];
    [~, weightNames] = xlsread(filename, 'S', 'A2:A3153');
    weights = xlsread(filename, 'S',  weightRange);
end