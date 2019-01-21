% SpringRank
% CODE  ->  https://github.com/cdebacco/SpringRank
% PAPER ->  http://danlarremore.com/pdf/SpringRank_2017_PrePrint.pdf
% Code by Daniel Larremore
% University of Colorado at Boulder
% BioFrontiers Institute & Dept of Computer Science
% daniel.larremore@colorado.edu
% http://danlarremore.com
%
% [sig_a,sig_L] = crossValidation(A,folds,reps)
%
%   INPUTS:
% A is a NxN matrix representing a directed network
%   A can be weighted (integer or non-integer)
%   A(i,j) = # of dominance interactions by i toward j. 
%   A(i,j) = # of times that j endorsed i.
% folds is the number of folks k in a k-fold cross validation
% reps is the number of random repetitions desired over the k-folds. For
%   example, folds=5 and reps=7 would divide the data into 5 folds,
%   performing tests, and repeating those tests 7 times independently.
%
%   OUTPUTS:
% sig_a is the local accuracy (\sigma_a in the paper)
% sig_L is the global accuracy (\sigma_L in the paper)

function [sig_a,sig_L] = crossValidation(A,folds,reps)

% convert to sparse for improved performance
if ~issparse(A)
    A = sparse(A);
end

% NOTE: We perform cross validation over *interacting pairs* so we're not
% dividing the edges of the network into k groups, but dividing the
% interactions into k groups. Here is an example that clarifies the
% difference. If there is a pair of nodes (i,j) with A(i,j) = 1 and 
% A(j,i)=3, this would count as ONE interacting pair, not four. There are
% other interpretations of how to split edges into a training and a test
% set, and these may be application dependent. All this writing here is
% just to clarify *exactly* how this code works.

% Find interacting pairs
[r,c,v] = find(triu(A+transpose(A))); 
% Number of interacting pairs
M = length(v); 
% Size of each fold
foldSize = floor(M/folds);

% preallocate; note that DIM2 should be increased if you are testing more
% than one method.
sig_a = zeros(reps*folds,1);
sig_L = zeros(reps*folds,1);

% iterate over reps
for rep = 1:reps
    
    % shuffle interactions
    idx = shuffle(1:M);
    % build K-1 folds of equal size
    for f = 1:folds-1
        fold{f} = idx( (f-1)*foldSize+1 : f*foldSize);
    end
    % then put the remainder in the final Kth fold
    fold{folds} = idx( (folds-1)*foldSize+1 : end);
    
    % iterate over folds
    for f = 1:folds
        % Print
        fprintf('Cross validation progress: Rep %i/%i, Fold %i/%i.\n',...
            rep,reps,f,folds);
        % bookkeeping
        foldrep = f+(rep-1)*folds;
        % build the testset of indices
        test_i = r(fold{f});
        test_j = c(fold{f});
        test = sub2ind(size(A),test_i,test_j);
        testpose = sub2ind(size(A),test_j,test_i);
        % build the training set by setting testset interactions to zero.
        TRAIN = A;
        TRAIN(test) = 0;
        TRAIN(testpose) = 0;
        % Build the TEST set.
        TEST = A-TRAIN;
        numTestEdges = sum(sum(TEST));
        
        % train springRank on the TRAINset
        s0 = springRank(TRAIN);
        bloc0 = betaLocal(TRAIN,s0);
        bglob0 = betaGlobal(TRAIN,s0);
        % springRank accuracies on TEST set
        sig_a(foldrep,1) = localAccuracy(TEST,s0,bloc0);
        sig_L(foldrep,1) = -globalAccuracy(TEST,s0,bglob0)/numTestEdges;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NOTE THAT IF YOU WANT TO COMPARE OTHER METHODS TO SPRINGRANK,
        % THIS IS THE PLACE THAT THEY SHOULD BE INCLUDED. 
        % Commented out, below, you can see the call to springRank with the 
        % regularization, as well as the call to BTL and its separate 
        % accuracy. 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % % train regularized springRank on the TRAINset
        % s2 = springRankFull(TRAIN,2);
        % bloc2 = betaLocal2(TRAIN,s2);
        % bglob2 = betaGlobal(TRAIN,s2);
        % % regularized springRank accuracies on TEST set
        % sig_a(foldrep,2) = localAccuracy(TEST,s2,bloc2);
        % sig_L(foldrep,2) = -globalAccuracy(TEST,s2,bglob2)/numTestEdges;
        
        % % train BTL on the TRAINset
        % bt = btl(TRAIN,1e-3);
        % % BTL accuracies on TEST set
        % sig_a(foldrep,3) = localAccuracy_BTL(TEST,bt);
        % sig_L(foldrep,3) = -globalAccuracy_BTL(TEST,bt)/numTestEdges;
    end
end