

pos_data = [];
pos_count = 0;
pos_str =[];
pos_i = [];
test_target = [];
test_data =[];
neg_data=[];
load('data/matchedAnnotation.mat')


for chrNo = 1:16
    
    dataW = index2seq('data/YJ168_totalNbStart_neg.wig',chrNo);
    dataC = index2seq('data/YJ168_totalNbStart_pos.wig',chrNo);
    dataPack = {dataW,dataC};
    annotPack = {StartTSS(Chromosome==chrNo),EndTSS(Chromosome==chrNo),StartCDS(Chromosome==chrNo),EndCDS(Chromosome==chrNo),Strand(Chromosome==chrNo)};
    clear dataW dataC %StartTSS EndTSS StartCDS EndCDS Chromosome Strand chrNo

    ngd = extract_rand_neg_data(dataPack,annotPack,K,feat_type,POS_MARGIN,neg_count);
    neg_data =[neg_data;ngd];
%     %% Extract training data

 
    [pD, pC, pS, pI] = extract_pos_dataSVM(dataPack,annotPack,K,feat_type);
    [tstDat, tstTar, test_count, test_str, test_i] = extract_pos_data(dataPack,annotPack,K,feat_type);
    test_data = [test_data; tstDat];
    test_target = [test_target;tstTar];
    
    pos_data = [pos_data;pD];
    pos_count = pC + pos_count;
    pos_str = [pos_str;pS];
    pos_i = [pos_i;pI];
    
    disp(['chromosome ' num2str(chrNo) ' is done...'])
end
clear pC pS pI pD ngd chrNor tst*
