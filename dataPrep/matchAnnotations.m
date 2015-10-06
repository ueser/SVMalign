%
% Read the annotation from file
%
filename = 'data/CDSannot.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%s%f%f%s%s%[^\n\r]';

fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);

dataArray([2, 4, 5]) = cellfun(@(x) num2cell(x), dataArray([2, 4, 5]), 'UniformOutput', false);

CDSannot = [dataArray{1:end-1}];

filename = 'data/TSSannot.csv';
formatSpec = '%f%q%f%f%q%q%q%q%q%q%[^\n\r]';

fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);

dataArray([1, 3, 4]) = cellfun(@(x) num2cell(x), dataArray([1, 3, 4]), 'UniformOutput', false);
TSSannot = [dataArray{1:end-1}];



%
% Match the annotation files for CDS and TSS from two different sources
%

    ii=0;
    clear *TSS *CDS

    for i = 1:size(CDSannot,1)
        gene = CDSannot{i,6};
        idx = strmatch(gene, TSSannot(:,6), 'exact');

        if ~isempty(idx) && (TSSannot{idx(1),3}<=CDSannot{i,3})
            ii=ii+1;
            StartTSS(ii) = TSSannot{idx(1),3}; % if the idx has multiple elements, then the gene has probably multiple exons.
            StartCDS(ii) = CDSannot{i,3};

            EndTSS(ii) = TSSannot{idx(end),4};
            EndCDS(ii) = CDSannot{i,4};

            Strand(ii) = TSSannot{idx(1),2};
            Chromosome(ii) = TSSannot{idx(1),1};

        end
    end
    disp(['Total number of genes matched: ',num2str(ii)])

    clear i ii idx gene TSSannot CDSannot filename formatSpec dataArray delimiter startRow fileID
    