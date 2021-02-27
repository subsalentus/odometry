close all
format long;
clear;
clc;
addpath('datasets');



disp('Opções:')
disp('  1 - Exemplo robo 1');
disp('  2 - Exemplo robo 2 (log 1)');
disp('  3 - Exemplo robo 2 (log 2)');
disp('  5 - DYI');

prompt = '\n\n Escolha -     ';

sel = input(prompt);


X_cg_cw_aux = 0;
Y_cg_cw_aux = 0;
X_cg_ccw_aux = 0;
Y_cg_ccw_aux = 0;
dif = 0;           


switch sel
    case 1
        %ROBOT1
        N=2048;
        g=5.9;
        d=10/100;
        r=d/2;
        b=0.4;
        L=2.99;
        k = (d*pi)/(g*N);
        colE=2;
        colD=3;
        numLogs = 4;
        stringCW = 'datasets/Robot1/log_quadrado%d.txt';     
        stringCCW = 'datasets/Robot1/log_quadrado_inv%d.txt';
        
        for j = 1:numLogs
            logCW=sprintf(stringCW,j);
            logCCW=sprintf(stringCCW,j);
            
            [leftCW,rightCW,leftCCW,rightCCW]=dadosF(logCW,logCCW,colE,colD);
            [xCW,yCW]=trajectory(leftCW,rightCW,k,b,1,1,dif);
            [xCCW,yCCW]=trajectory(leftCCW,rightCCW,k,b,1,1,dif); 
            
            plotRes(xCW,yCW,xCCW,yCCW,'SEM CALIBRAÇÃO');
                
            X_cg_cw_aux = X_cg_cw_aux + xCW(end);
            Y_cg_cw_aux = Y_cg_cw_aux + yCW(end);
            X_cg_ccw_aux = X_cg_ccw_aux + xCCW(end);
            Y_cg_ccw_aux = Y_cg_ccw_aux + yCCW(end);
        end

        %centro gravidade
        Xcgcw = X_cg_cw_aux / numLogs;
        Ycgcw = Y_cg_cw_aux / numLogs;
        Xcgccw = X_cg_ccw_aux / numLogs;
        Ycgccw = Y_cg_ccw_aux / numLogs;
       
        [CR,CL,bAtual]=hodo(Xcgcw,Xcgccw,L,b);
        
        [xCWH,yCWH]=trajectory(leftCW,rightCW,k,bAtual,CR,CL,dif);          %trajetoria corrigida (CR e CL)
        [xCCWH,yCCWH]=trajectory(leftCCW,rightCCW,k,bAtual,CR,CL,dif);      %trajetoria corrigida (CR e CL)
        
        plotRes(xCWH,yCWH,xCCWH,yCCWH,'COM CALIBRAÇÃO');

               
%         log = 'C:/Users/marce/OneDrive/Desktop/ROMOV_FINAL/datasets/Robot1/log_recta.txt';
%         [leftCW,rightCW,leftCCW,rightCCW]=dadosF(log,log,colE,colD);
%         [xR,yR]=trajectory(leftCW,rightCW,k,b,1,1,dif);
%         [xRH,yRH]=trajectory(leftCW,rightCW,k,b,CR,CL,dif);
%         plotRes(xR,yR,xRH,yRH,'Reta')
    case 2   
        %ROBOT 2 LOG 1
        N=10000;
        g=1;
        d=12.5/100;
        r=d/2;
        b=0.42;
        L=2;
        k = (d*pi)/(g*N);
        colE=2;
        colD=3;
        
        myFolder = 'datasets\Robot2\logs1';
        stringCW = 'datasets/Robot2/logs1/log_%d_CW.txt';
        stringCCW = 'datasets/Robot2/logs1/log_%d_CCW.txt';
        numLogs=4;
        for j = 1:numLogs
            logCW=sprintf(stringCW,j);
            logCCW=sprintf(stringCCW,j);
            
            [leftCW,rightCW,leftCCW,rightCCW]=dadosF(logCW,logCCW,colE,colD);
            [xCW,yCW]=trajectory(leftCW,rightCW,k,b,1,1,dif);
            [xCCW,yCCW]=trajectory(leftCCW,rightCCW,k,b,1,1,dif); 
                figure ('NumberTitle', 'off', 'Name', 'SEM CALIBRAÇÃO');
                subplot(1,2,1);
                plot(xCW,yCW);
                title('CLOCKWISE');
                daspect([1 1 1]);
                subplot(1,2,2);
                plot(xCCW,yCCW);
                title('COUNTER CLOCKWISE');
                daspect([1 1 1]);
            X_cg_cw_aux = X_cg_cw_aux + xCW(end);
            Y_cg_cw_aux = Y_cg_cw_aux + yCW(end);
            X_cg_ccw_aux = X_cg_ccw_aux + xCCW(end);
            Y_cg_ccw_aux = Y_cg_ccw_aux + yCCW(end);
        end

        %centro gravidade
        Xcgcw = X_cg_cw_aux / numLogs;
        Ycgcw = Y_cg_cw_aux / numLogs;
        Xcgccw = X_cg_ccw_aux / numLogs;
        Ycgccw = Y_cg_ccw_aux / numLogs;
       
        [CR,CL,bAtual]=hodo(Xcgcw,Xcgccw,L,b);
        
        [xCWH,yCWH]=trajectory(leftCW,rightCW,k,bAtual,CR,CL,dif);          %trajetoria corrigida (CR e CL)
        [xCCWH,yCCWH]=trajectory(leftCCW,rightCCW,k,bAtual,CR,CL,dif);      %trajetoria corrigida (CR e CL)
        
        figure ('NumberTitle', 'off', 'Name', 'COM CALIBRAÇÃO');
        subplot(1,2,1);
        plot(xCWH,yCWH);
        title('CLOCKWISE');
        daspect([1 1 1]);
        subplot(1,2,2);
        plot(xCCWH,yCCWH);
        title('COUNTER CLOCKWISE');
        daspect([1 1 1]);
    case 3
        %ROBOT 2 LOG 1
        N=10000;
        g=1;
        d=12.5/100;
        r=d/2;
        b=0.42;
        L=2;
        k = (d*pi)/(g*N);
        colE=1;
        colD=2;
        
        myFolder = 'datasets\Robot2\logs2';
        stringCW = 'datasets/Robot2/logs2/log%d_cw.txt';
        stringCCW = 'datasets/Robot2/logs2/log%d_ccw.txt';
        numLogs=3;
        for j = 1:numLogs
            logCW=sprintf(stringCW,j);
            logCCW=sprintf(stringCCW,j);
            
            [leftCW,rightCW,leftCCW,rightCCW]=dadosF(logCW,logCCW,colE,colD);
            [xCW,yCW]=trajectory(leftCW,rightCW,k,b,1,1,dif);
            [xCCW,yCCW]=trajectory(leftCCW,rightCCW,k,b,1,1,dif);
            
            plotRes(xCW,yCW,xCCW,yCCW,'SEM CALIBRAÇÃO');

            X_cg_cw_aux = X_cg_cw_aux + xCW(end);
            Y_cg_cw_aux = Y_cg_cw_aux + yCW(end);
            X_cg_ccw_aux = X_cg_ccw_aux + xCCW(end);
            Y_cg_ccw_aux = Y_cg_ccw_aux + yCCW(end);
        end

        %centro gravidade
        Xcgcw = X_cg_cw_aux / numLogs;
        Ycgcw = Y_cg_cw_aux / numLogs;
        Xcgccw = X_cg_ccw_aux / numLogs;
        Ycgccw = Y_cg_ccw_aux / numLogs;
       
        [CR,CL,bAtual]=hodo(Xcgcw,Xcgccw,L,b);
        
        [xCWH,yCWH]=trajectory(leftCW,rightCW,k,bAtual,CR,CL,dif);          %trajetoria corrigida (CR e CL)
        [xCCWH,yCCWH]=trajectory(leftCCW,rightCCW,k,bAtual,CR,CL,dif);      %trajetoria corrigida (CR e CL)
        
         plotRes(xCWH,yCWH,xCCWH,yCCWH,'COM CALIBRAÇÃO');
        
        
    case 5
        clc;
        N=input('\nNumber of ticks - ');
        g=input('\nGear - ');
        d=input('\nWheel Diameter (m) - ');
        b=input('\nDistance between wheels (m) - ');
        L=input('\nSquare side (m) - ');
        
        k = (d*pi)/(g*N);

%         logCW=input('\nPath dos logs CW - ');
%         logCCW=input('\nPath dos logs CCW - ');
        folderPath=input('\nIndique a path do folder com os logs\nATENÇÃO ficheiros dos logs devem ter o nome no seguinte formato (log_X_CW.txt/log_X_CW.txt)\n','s');        
        numLogs=input('\nQuantos logs de cada - ');
        
        stringCW = strrep(strcat(folderPath,'/log_%d_CW.txt'),'\','/');
        stringCCW = strrep(strcat(folderPath,'/log_%d_CCW.txt'),'\','/');
        
        colE=input('\nColuna dados roda esquerda - ');
        colD=input('\nColuna dados roda direita - ');
        dif=input('\nDiferencial? (0-Não / 1-Sim) - ');
        
        
        
        for j = 1:numLogs
            logCW=sprintf(stringCW,j);
            logCCW=sprintf(stringCCW,j);
            
            [leftCW,rightCW,leftCCW,rightCCW]=dadosF(logCW,logCCW,colE,colD);
            [xCW,yCW]=trajectory(leftCW,rightCW,k,b,1,1,dif);
            [xCCW,yCCW]=trajectory(leftCCW,rightCCW,k,b,1,1,dif);
            
            plotRes(xCW,yCW,xCCW,yCCW,'SEM CALIBRAÇÃO');

            X_cg_cw_aux = X_cg_cw_aux + xCW(end);
            Y_cg_cw_aux = Y_cg_cw_aux + yCW(end);
            X_cg_ccw_aux = X_cg_ccw_aux + xCCW(end);
            Y_cg_ccw_aux = Y_cg_ccw_aux + yCCW(end);
        end

        %centro gravidade
        Xcgcw = X_cg_cw_aux / numLogs;
        Ycgcw = Y_cg_cw_aux / numLogs;
        Xcgccw = X_cg_ccw_aux / numLogs;
        Ycgccw = Y_cg_ccw_aux / numLogs;
       
        [CR,CL,bAtual]=hodo(Xcgcw,Xcgccw,L,b);
        
        [xCWH,yCWH]=trajectory(leftCW,rightCW,k,bAtual,CR,CL,dif);          %trajetoria corrigida (CR e CL)
        [xCCWH,yCCWH]=trajectory(leftCCW,rightCCW,k,bAtual,CR,CL,dif);      %trajetoria corrigida (CR e CL)
        
         plotRes(xCWH,yCWH,xCCWH,yCCWH,'COM CALIBRAÇÃO');
        
    otherwise
        disp('Invalido')
end

