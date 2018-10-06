
clc; close all; clear all;
dice = [6,6,6];%8d6
DRMax = sum(dice);
yMax = DRMax;
F(DRMax) = struct('cdata',[],'colormap',[]);
outputs = zeros(DRMax, 4);
[dieVals, counts, probabilities] = getDiceStatistics(dice);

for frame = 1:DRMax
    DR = frame;
    
    x = dieVals;
    penProb = 0;
    for i=1:size(dieVals,1)
        if(dieVals(i) <= DR)
            dieVals(i) = 0;
        else
            dieVals(i) = dieVals(i) - DR;
            penProb = penProb + probabilities(i);
        end
    end
    
    dmgDist = dieVals.*probabilities;
    figure();
    subplot(2,1,1);
    plot(x, probabilities);
    hold on;
    plot(x, dmgDist);
    plot(x, penProb*ones(size(x)));
    
    
    avgDmg = sum(dmgDist)
    dmgHeurist = size(dice,2)*3.5-DR
    penProb
    outputs(frame,:) = [frame, avgDmg, dmgHeurist, penProb];
    ylim([0 2.2]);
    legend('Dmg Probabilities', 'Dmg Through DR * probability', "penetration Probability");
    
    subplot(2,1,2);
    plot(x, frame*ones(size(x)));
    hold on;
    plot(x, avgDmg*ones(size(x)));
    plot(x, dieVals);
    ylim([0 yMax]);
    legend('DR','average Damage', 'Damage Values');
    
    
    % figure(2);
    % plot(x, dieVals);
    % legend('Dmg Through DR');
    
    
    F(frame) = getframe(gcf);
end

movie(F,2);

v = VideoWriter('dmgDistMov','MPEG-4');
v.FrameRate = 15;
open(v);
writeVideo(v,F);
v.close;
close all;
