function [dieVals, counts, probability] =  getDiceStatistics(dice)
%dice is a column vector of the dice you wish to use, where the value in
%each cell is the number of sides of the dice

outcomes = getDicePDist(dice);
minVal = size(dice,2);
maxVal = sum(dice);
range = maxVal-minVal+1;

counts = zeros(range,1);
dieVals = zeros(range,1);
probability = zeros(range,1);
totOutcomes = numel(outcomes);

for i=1:range
    currDieValue = i+minVal-1;
    dieVals(i) = currDieValue;
    tmp = find(outcomes==currDieValue);
    counts(i) = size(tmp,1);
    probability(i) = counts(i)/totOutcomes;
end
end