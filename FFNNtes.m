% File ini digunakan untuk mencoba hasil training (FFNNterbaik.mat)
clc
clear all
c = 1;
n = 3;
n2 = n^2;

load FFNNterbaik.mat

MT = 1;
while MT == 1
    disp('Pengujian FFNN (Konfigurasi GA-2)');
    disp('Masukkan tiga input biner (contoh: 1 0 1)');
    x1 = input('X1: ');
    x2 = input('X2: ');
    x3 = input('X3: ');

    IM = [x1 x2 x3];
    NNS = FFNNterbaik;

    Wtemp = NNS(1:n2);
    for ii=1:n
        Wih(ii,:) = Wtemp((ii-1)*n+1:ii*n);
    end

    bih = NNS(n2+1:n2+n);
    Who = NNS(n2+n+1:n2+2*n);
    bho = NNS((n+1)^2);

    for ii=1:n
        SumWlb = 0;
        for jj=1:n
            SumWlb = SumWlb + Wih(ii,jj)*IM(jj); 
        end
        SumWlb = SumWlb + bih(ii);
        Xih(ii) = 1/(1+exp(-c*SumWlb));
    end

    SumWXb = 0;
    for jj=1:n
        SumWXb = SumWXb + Who(jj)*Xih(jj); 
    end
    SumWXb = SumWXb + bho;
    Xho = 1/(1+exp(-c*SumWXb));

    if Xho <= 0.02
        HasilTes ='0';
    elseif Xho >= 0.98
        HasilTes = '1';
    else 
        HasilTes = 'Unidentified';
    end

    disp(['Output bilangan real: ', num2str(Xho)]);
    disp(['Output FFNN adalah: ', HasilTes]);
    
    MT = input('Tekan 1 untuk tes lagi, dan tekan 0 untuk keluar: ');
end