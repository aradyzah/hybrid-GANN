% Konfigurasi GA - 2 meminta Mutasi: Flip bit
% 0 = 1, dan 1 = 0

function mutKrom = mutasi(kromosom, JumGen, pmutasi)

mutKrom = kromosom;
for ii=1:JumGen
    if (rand < pmutasi)
        if kromosom(ii)==0
            mutKrom(ii) = 1;
        else
            mutKrom(ii) = 0;
        end
    end
end
end