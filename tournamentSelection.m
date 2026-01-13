% Seleksi: Tournament

function pindex = tournamentSelection(UkPop, fitness, tournSize)

    % Pilih k individu secara acak (k = tournSize)
    candidates = randperm(UkPop, tournSize);
    
    % Cari kandidat dengan fitness tertinggi di antara yang terpilih
    bestIdx = candidates(1);
    maxVal = fitness(candidates(1));
    
    for i = 2:tournSize
        idx = candidates(i);
        if fitness(idx) > maxVal
            maxVal = fitness(idx);
            bestIdx = idx;
        end
    end
    
    pindex = bestIdx;
end