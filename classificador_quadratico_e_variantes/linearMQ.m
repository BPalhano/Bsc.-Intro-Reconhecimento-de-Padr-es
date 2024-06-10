function [STATS TX_OK W]=linearMQ(data,Nr,Ptrain)
%
% Euclidean distance to the centroid (mean) of each class
%
% INPUTS: * data (matrix): dataset matrix (N x (p+1))
%	  	OBS1: feature vectors along the rows of data matrix
%	  	OBS2: last column must contain numerical class labels
%	  * Nr (scalar): Number of runs (Nr>=1)
%	  * Ptrain (scalar): Percentage of training data (0 < Ptrain < 100)
%
% OUTPUTS: X (struct) - the data samples separated per class
%          m (struct) - the classes centroids
%          STATS (vector) - Statistics of test data (mean, median, min/max, sd)
%
% Author: Guilherme Barreto
% Date: 21/10/2018

[N p]=size(data);  % Get dataset size (N)

Ntrn=round(Ptrain*N/100);  % Number of training samples
Ntst=N-Ntrn; % Number of testing samples

K=max(data(:,end)); % Get the number of classes
ZZ=sprintf('The problem has %d classes',K);
disp(ZZ);

for r=1:Nr,  % Loop of independent runs

  I=randperm(N);
  data=data(I,:); % Shuffle rows of the data matrix

  % Separate into training and testing subsets
  Dtrn=data(1:Ntrn,:);  % Training data
  Dtst=data(Ntrn+1:N,:); % Testing data

  % Partition of training data into K subsets
  Xtrn=Dtrn(:,1:end-1); % Input data matrix
  Ytrn=Dtrn(:,end); % Target (numerical labels) data vector
  
  % Routine to convert numerical labels into binary (1-out-of-K) labels
  Ltrn=zeros(Ntrn,K);  % initialization of label matrix
  Labels=eye(K);
  for k=1:K,
    Ik=find(Ytrn==k);
    nk=length(Ik);
    Ltrn(Ik,:)=repmat(Labels(k,:),nk,1);
  end

  W=pinv(Xtrn)*Ltrn;  % Compute the weight matrix
  
  % Testing phase
  correct=0;  % number correct classifications
  for i=1:Ntst,
    Xtst=Dtst(i,1:end-1);   % test sample to be classified
    Actual_Label_Xtst=Dtst(i,end);   % Actual label of the test sample
    
    Ypred=Xtst*W;   % Predict the output label (binary)
    
    [dummy Predicted_label_Xtst] = max(Ypred); % Find numerical label
        
    %[Predicted_label_Xtst Actual_Label_Xtst]
    if Predicted_label_Xtst == Actual_Label_Xtst,
        correct=correct+1;
    end
  end
  
  TX_OK(r)=100*correct/Ntst;   % Recognition rate of r-th run
end

STATS=[mean(TX_OK) min(TX_OK) max(TX_OK) median(TX_OK) std(TX_OK)];
