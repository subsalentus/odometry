function [leftCW,rightCW,leftCCW,rightCCW] = dadosF(logCW,logCCW,colE,colD)
    CW=importdata(logCW);
    CCW=importdata(logCCW);
    
    NR_LEITURAS_CW=length(CW);
    NR_LEITURAS_CCW=length(CCW);
    
    leftCW = overflowsCorrection(NR_LEITURAS_CW,CW(:,colE));
    rightCW = overflowsCorrection(NR_LEITURAS_CW,CW(:,colD));
    leftCCW = overflowsCorrection(NR_LEITURAS_CCW,CCW(:,colE));
    rightCCW = overflowsCorrection(NR_LEITURAS_CCW,CCW(:,colD));
    
    
    %% PLOTS
    figure ('NumberTitle', 'off', 'Name', 'CORREÇÃO OVERFLOW');
    
    subplot(2,4,1);plot(CW(:,2));title('C/ OVERFLOW ESQ CW');
    subplot(2,4,2);plot(leftCW);title('S/ OVERFLOW ESQ CW');
    subplot(2,4,3);plot(CW(:,3));title('C/ OVERFLOW DIR CW');
    subplot(2,4,4);plot(rightCW);title('S/ OVERFLOW DIR CW');
    
    subplot(2,4,5);plot(CCW(:,2));title('C/ OVERFLOW ESQ CCW');
    subplot(2,4,6);plot(leftCCW);title('S/ OVERFLOW ESQ CCW');
    subplot(2,4,7);plot(CCW(:,3));title('C/ OVERFLOW DIR CCW');
    subplot(2,4,8);plot(rightCCW);title('S/ OVERFLOW DIR CCW');
end


function data = overflowsCorrection(numL, data)
    for i=1:numL
        j=i+1;
        if j==numL+1
            j=numL;
        end
        
        if (data(j)-data(i))>2^15
            for q=1:i
                data(q)=data(q)+2^16;
            end
        end
        if (data(j)-data(i))<-2^15
            for q=1:i
                data(q)=data(q)-2^16;
            end
        end
    end
end

