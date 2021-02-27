function [X,Y]=trajectory(leftLog, rightLog, k, b, CR, CL, dif)
    if dif==1
        aux1R=rightLog;
        aux1L=leftLog;
    end
    if dif == 0
        aux1R=diff(rightLog);
        aux1L=diff(leftLog);
    end
    
    aux2R=aux1R * k;
    aux2L=aux1L * k;
    
    deltaD = (aux2R * CR + aux2L * CL) / 2;
    deltaTheta = (aux1R*k - aux1L*k) / b;
    
    
    Theta =  zeros(numel(rightLog));   
    X = 0;
    Y = 0;
    
    for t=2:numel(deltaD)
        X(t)=X(t-1)+(deltaD(t))*cos(Theta(t-1)+(deltaTheta(t)/2));
        Y(t)=Y(t-1)+(deltaD(t))*sin(Theta(t-1)+(deltaTheta(t)/2));
        Theta(t) = Theta(t-1) + deltaTheta(t);
    end
end

