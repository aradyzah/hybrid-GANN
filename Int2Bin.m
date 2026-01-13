function BilBiner = Int2Bin(BilInteger, JumBit)
    for ii=1:JumBit
        if mod(BilInteger,2) == 0
            BilBiner(JumBit+1-ii) = 0;
        else
            BilBiner(JumBit+1-ii) = 1;
        end
        BilInteger = fix(BilInteger/2);
    end
end