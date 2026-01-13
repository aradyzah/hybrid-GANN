function fitness = HitungFitness(FFNNstruk, JumMasukan, JPmasukan, IM, TM)

    c = 1.0;
    n2 = JumMasukan^2;

    Wtemp = FFNNstruk(1:n2);
    
    % Membentuk bobot input-hidden
    for ii=1:JumMasukan
        Wih(ii,:) = Wtemp((ii-1)*JumMasukan+1:ii*JumMasukan);
    end

    bih = FFNNstruk(n2+1:n2+JumMasukan);
    Who = FFNNstruk(n2+JumMasukan+1:n2+2*JumMasukan);
    bho = FFNNstruk((JumMasukan+1)^2);

    RMSE = 0;

    % Evaluasi untuk setiap pola masukan
    for evaluasi=1:JPmasukan
        
        % Hitung Output Hidden Layer
        for ii=1:JumMasukan
            SumWlb = 0; 
            for jj=1:JumMasukan 
                SumWlb = SumWlb + (Wih(ii,jj)*IM(evaluasi,jj));
            end
            SumWlb = SumWlb + bih(ii);
            Xih(ii) = 1/(1+exp(-c*SumWlb));
        end

        % Hitung Output Output Layer
        SumWXb = 0;
        for jj=1:JumMasukan
            SumWXb = SumWXb + (Who(jj)*Xih(jj));
        end
        SumWXb = SumWXb + bho;
        
        Xho = 1/(1+exp(-c*SumWXb));
        
        RMSE = RMSE + (TM(evaluasi)-Xho)^2;
    end

    Delta = sqrt(1/JPmasukan*RMSE);
    
    if Delta < 1e-10
        Delta = 1e-10;
    end
    
    fitness = 1/Delta;
end