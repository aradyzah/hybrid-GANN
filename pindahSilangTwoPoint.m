% Crossover: Two-point

function anak = pindahSilangTwoPoint(bapak, ibu, JumGen)

    % Membangkitkan 2 titik potong acak
    points = sort(randperm(JumGen-1, 2));
    TP1 = points(1);
    TP2 = points(2);

    % Anak 1: Bagian tengah (TP1 s/d TP2) diambil dari Ibu, sisanya Bapak
    anak(1,:) = bapak; 
    anak(1, TP1+1:TP2) = ibu(TP1+1:TP2);

    % Anak 2: Bagian tengah (TP1 s/d TP2) diambil dari Bapak, sisanya Ibu
    anak(2,:) = ibu;
    anak(2, TP1+1:TP2) = bapak(TP1+1:TP2);
end

% input
% bapak, ibu = kromosom (1xJumGen)
% JumGen = jumlah gen

% output 
% anak = matriks 2xJumGen berisi 2 anak