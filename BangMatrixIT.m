function [IM, TM] = BangMatrixIT(JumMasukan, JPmasukan)
    for ii=1:JPmasukan
        IM(ii,:) = Int2Bin(ii-1, JumMasukan);
        if mod(sum(IM(ii,:)), 2) == 1
            TM(ii) = 1;
        else
            TM(ii) = 0;
        end
    end
end