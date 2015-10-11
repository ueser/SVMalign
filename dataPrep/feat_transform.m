function result = feat_transform(data,ftype)

result = [];

if (strcmp(ftype,'l2norm_lognorm'))    
    n = log(norm(data+eps));
    data = data/(norm(data)+eps); 
    result = [data,n];
end

if (strcmp(ftype,'logl2norm_lognorm'))    
    data = log(1+data);
    n = norm(data);
    data = data/(norm(data)+eps); 
    result = [data,n];
end


if (strcmp(ftype,'l2norm_norm'))
    n = norm(data+eps);
    data = data/(norm(data)+eps); 
    result = [data,n];
end


if (strcmp(ftype,'l2norm'))
    data = data/(norm(data)+eps); 
    result = [data];
end


% % Polynomial kernel
% data = data'*data;
% 
% result = [diag(data,0);diag(data,1);diag(data,2);diag(data,3);diag(data,4);diag(data,5)]';

end