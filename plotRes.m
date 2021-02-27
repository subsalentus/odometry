function plotRes(xCC,yCC,xCCW,yCCW,texto)
    figure ('NumberTitle', 'off', 'Name', texto);
    subplot(1,2,1);
    plot(xCC,yCC);
    title('CLOCKWISE');
    daspect([1 1 1]);
    subplot(1,2,2);
    plot(xCCW,yCCW);
    title('COUNTER CLOCKWISE');
    daspect([1 1 1]);
end