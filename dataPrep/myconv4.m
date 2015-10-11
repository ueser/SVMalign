function sc = myconv4(chp,chn,f,flen,ftype)
% under construction


%flen = length(f);
sparsity_cutoff = flen*0.5;
N=length(chn)-flen+1;
sc = zeros(1,N);
cp = zeros(1,N);
cn = zeros(1,N);

for i=1:N
    x = feat_transform(chp(i:i+flen-1),ftype);
    y= feat_transform(chn(i:i+flen-1),ftype);
    cp(i:i+flen-1) = x(1:end-1);
    cpp(i) = x(end);
    cn(i:i+flen-1) = y(1:end-1);
    cnn(i)= y(end);
    
    
%     if cpp(i)<=2 || sum(cp(i:i+flen-1)) < sparsity_cutoff
% %        sc(i)=0;
%        cp(i:i+flen-1) = 0;
%        cpp(i) =0;
%        cn(i:i+flen-1) = 0;
%        cnn(i) = 0;
%     end
end


scp1 = conv(cp,fliplr(f(1:flen-1))');
scp2 = conv(cn,fliplr(f(flen+1:end-1))');
scp0 = conv(cpp,fliplr(f(flen))');
scp00 = conv(cnn,fliplr(f(flen))');

sc = scp1(1:N)+scp2(1:N)+scp0+scp00;

