clc
clear all

% KONFIGURASI GA - 2
UkPop = 30;           % PopSize: 30
Psilang = 0.7;        % Pc: 0.7
Pmutasi = 0.02;       % Pm: 0.02
MaxG = 75;            % Generasi: 75
TournSize = 3;        % Ukuran turnamen 

% PARAMETER TETAP
JumMasukan = 3;
JPmasukan = 2^JumMasukan;
Nbit = 20;
JumGen = Nbit*(JumMasukan+1)^2;
Nvar = JumGen/Nbit;
Rb = -10;
Ra = 10;
MinDelta = 0.01;
Fthreshold = 1/MinDelta;
Bgraf = Fthreshold;

% PERSIAPAN GRAFIK 
hfig = figure;
hold on
title('Algoritma Genetika (Config 2) untuk pelatihan FFNN')
set(hfig, 'position', [50,50,600,400]);
set(hfig, 'DoubleBuffer', 'on');
axis([1 MaxG 0 Bgraf]);

hbestplot1 = plot(1:MaxG,zeros(1, MaxG));
hbestplot2 = plot(1:MaxG,zeros(1,MaxG));

htext1 = text(0.6*MaxG,0.25*Bgraf,sprintf('Fitness terbaik: %7.6f', 0.0));
htext2 = text(0.6*MaxG,0.20*Bgraf,sprintf('Fitness terbaik: %7.6f', 0.0));
htext3 = text(0.6*MaxG,0.15*Bgraf,sprintf('Ukuran populasi: %3.0f', UkPop));
htext4 = text(0.6*MaxG,0.10*Bgraf,sprintf('Prob. Pindah Silang: %4.3f', Psilang));
htext5 = text(0.6*MaxG,0.05*Bgraf,sprintf('Prob. Mutasi: %4.3f', Pmutasi));
xlabel('Generasi');
ylabel('Fitness');
hold off
drawnow;

% PROSES UTAMA 
[IM, TM] = BangMatrixIT(JumMasukan,JPmasukan); 

Populasi = inisialisasiPopulasi(UkPop,JumGen); 

for generasi=1:MaxG
    
    % Evaluasi Populasi
    for ii=1:UkPop
        FFNNstruk = dekodekanKromosom(Populasi(ii,:), Nvar, Nbit, Ra, Rb);
        Fitness(ii) = HitungFitness(FFNNstruk,JumMasukan, JPmasukan,IM,TM);
    end
    
    [MaxF, IndeksIndividuTerbaik] = max(Fitness);
    MinF = min(Fitness);
    FitnessRataRata = mean(Fitness);
    
    FFNNterbaik = dekodekanKromosom(Populasi(IndeksIndividuTerbaik,:), Nvar, Nbit, Ra, Rb);

    % UPDATE GRAFIK
    plotvector1 = get(hbestplot1,'YData');
    plotvector1(generasi) = MaxF;
    set(hbestplot1,'YData', plotvector1);
    
    plotvector2 = get(hbestplot2, 'YData');
    plotvector2(generasi) = FitnessRataRata;
    set(hbestplot2,'YData',plotvector2); 
    
    set(htext1,'String',sprintf('Fitness terbaik: %7.6f', MaxF));
    set(htext2,'String',sprintf('Fitness rata-rata: %7.6f', FitnessRataRata));
    drawnow;

    % Cek Stop Condition
    if MaxF > Fthreshold
        disp('Target Fitness Tercapai!');
        break;
    end

    % REPRODUKSI / EVOLUSI 
    TemPopulasi = Populasi;

    % 1. ELITISME (Mempertahankan individu terbaik)
    if mod(UkPop,2)==0
        IterasiMulai = 3; 
        TemPopulasi(1,:) = Populasi(IndeksIndividuTerbaik,:);
        TemPopulasi(2,:) = Populasi(IndeksIndividuTerbaik,:);
    else
        IterasiMulai = 2;
        TemPopulasi(1,:) = Populasi(IndeksIndividuTerbaik,:);
    end

    % 2. SELEKSI (TOURNAMENT)
    
    % 3. PINDAH SILANG (TWO-POINT CROSSOVER)
    for jj = IterasiMulai:2:UkPop
        % Seleksi Induk menggunakan Tournament
        IP1 = tournamentSelection(UkPop, Fitness, TournSize);
        IP2 = tournamentSelection(UkPop, Fitness, TournSize);
        
        if (rand < Psilang)
            % Menggunakan Two-Point Crossover
            Anak = pindahSilangTwoPoint(Populasi(IP1,:), Populasi(IP2,:), JumGen); 
            TemPopulasi(jj,:) = Anak(1,:);
            if (jj+1 <= UkPop)
                TemPopulasi(jj+1,:) = Anak(2,:);
            end
        else
            TemPopulasi(jj,:) = Populasi(IP1,:);
            if (jj+1 <= UkPop)
                TemPopulasi(jj+1,:) = Populasi(IP2,:);
            end
        end
    end

    % 4. MUTASI (FLIP BIT)
    for kk = IterasiMulai:UkPop
        TemPopulasi(kk,:) = mutasi(TemPopulasi(kk,:),JumGen, Pmutasi);
    end

    Populasi = TemPopulasi;
end

% Simpan hasil
disp('Pelatihan Selesai.');
save FFNNterbaik.mat FFNNterbaik;
disp('FFNNterbaik.mat berhasil disimpan.');