function x = dekodekanKromosom(kromosom, nvar, nbit, ra, rb)
    for ii=1:nvar
        x(ii) = 0;
        for jj=1:nbit
            x(ii) = x(ii) + kromosom((ii-1)*nbit + jj)*2^(-jj);
        end
        x(ii) = rb + (ra-rb)*x(ii);
    end
end