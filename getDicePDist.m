function outcomes = getDicePDist(dice)
%dice is a column vector of the dice you wish to use, where the value in
%each cell is the number of sides of the dice

outcomes = zeros(dice);
idxDivisors = cumprod(dice)/dice(end);
for idx = 1:numel(outcomes)
    remainder = idx;
    for j = numel(idxDivisors):-1:1
        outcomes(idx) = outcomes(idx) +1+ floor((remainder)/idxDivisors(j));
        remainder = mod(remainder, idxDivisors(j));
    end
end
end