function [CR,CL,bAtual] = hodo(xCW,xCCW,L,b)
    alpha=(xCW+xCCW)/(-4*L);      %ERRO TIPO A
    beta=(xCW-xCCW)/(-4*L);       %ERRO TIPO B
    R=(L/2)/(sin(beta/2));        %RAIO DA CURVATURA

    Eb = (pi/2)/((pi/2)-alpha);
    bAtual=Eb*b;

    Ed=(R+(b/2))/(R-(b/2));

    CL=2/(Ed+1);
    CR=2/((1/Ed)+1);
end