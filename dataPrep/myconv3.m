function [sc1,sc2,t1,t2] = myconv3(chp,chn,f,flen,ftype)

%flen = length(f);
sparsity_cutoff = flen*0.5;
N=length(chn)-flen+1;
sc1 = zeros(1,N);
sc2 = zeros(1,N);

for i=1:N
    cp = chp(i:i+flen-1);
    cn = chn(i:i+flen-1);
    c  = [feat_transform(cp,ftype) feat_transform(cn,ftype)];
    if c(flen+1)<=2 || c(2*(flen+1))<=2 || sum(cp) < sparsity_cutoff 
        % the second norm threshold c(2*(flen+1))<=2  is unnecessary and indeed we don't want.
       sc(i)=0;
    else
         tic 
            sc1(i) = f*c';
         t1(i) = toc;
        tic
         sc2(i) = corr(f',c');
         t2(i) = toc;
    end
end

end