%% DEFINITIONS
USE_RANDOM = 0;
PERCEPTRONS_INPUT = 13;
PERCEPTRONS_HIDDEN = 3;
PERCEPTRONS_OUTPUT = 3;
FILE_NAME = 'table.txt';
U_SIZE = 5;
L_SIZE = 4;

%% LOAD MATRICES
if USE_RANDOM == 0 % Load Matlab generated weights
    load net
    hiddenWeights = net.IW{1};
    outputWeights = net.LW{2};
    hiddenBias = net.b{1};
    outputBias = net.b{2};
else % Use random values
    hiddenWeights = 100*rand(3,13);
    outputWeights = 100*rand(3,3);
    hiddenBias = 100*rand(3,1);
    outputBias = 100*rand(3,1);
end

load wine_dataset.mat

% Normalized inputs
normalized=zeros(size(wineInputs));
limit=size(wineInputs,1);
for i = 1:limit
    normalized(i,:)=wineInputs(i,:)/max(wineInputs(i,:));
end
normalized = [normalized' wineTargets'];

% Open file
fileID = fopen(FILE_NAME,'w+');

fprintf('Writing to file %s... ', FILE_NAME);

% INPUT MATRIX
[m,n] = size(normalized);
fprintf(fileID, '\t\t\tconstant INPUT_LOOKUP_TABLE : ARRAY_OF_SFIXED (0 to (PERCEPTRONS_INPUT-1+3)) := (');
for i = 1:m
    fprintf(fileID, '\n\t\t\t\t(');
    for j = 1:(n - 1)
        fprintf(fileID, 'to_sfixed(%5.4f,U_SIZE,L_SIZE), ', normalized(i, j));
    end
    fprintf(fileID, 'to_sfixed(%5.4f,U_SIZE,L_SIZE))', normalized(i, n));
    if i ~= m
        fprintf(fileID, ',');
    end  
end
fprintf(fileID, '\n\t\t\t);'); 
fprintf(fileID, '\n'); 

% INPUT LAYER
fprintf(fileID, '\n\t\t\tconstant INPUT_LAYER : INPUT_LAYER_WEIGHTS := (');
for i = 1:PERCEPTRONS_INPUT
    fprintf(fileID, '\n\t\t\t\t(');
    for j = 1:PERCEPTRONS_INPUT
        if j == i
            fprintf(fileID,'to_sfixed(1,U_SIZE,L_SIZE), ');
        else
            fprintf(fileID,'to_sfixed(0,U_SIZE,L_SIZE), ');
        end
    end
    fprintf(fileID, 'to_sfixed(0,U_SIZE,L_SIZE))');
    if i ~= PERCEPTRONS_INPUT
        fprintf(fileID, ',');
    end  
end
fprintf(fileID, '\n\t\t\t);'); 
fprintf(fileID, '\n'); 

% HIDDEN LAYER
fprintf(fileID, '\n\t\t\tconstant HIDDEN_LAYER : HIDDEN_LAYER_WEIGHTS := (');
for i = 1:PERCEPTRONS_HIDDEN
    fprintf(fileID, '\n\t\t\t\t(');
    for j = 1:PERCEPTRONS_INPUT
        fprintf(fileID, 'to_sfixed(%5.4f,U_SIZE,L_SIZE), ', hiddenWeights(i, j));
    end
    fprintf(fileID, 'to_sfixed(%5.4f,U_SIZE,L_SIZE))', hiddenBias(i));
    if i ~= PERCEPTRONS_HIDDEN
        fprintf(fileID, ',');
    end  
end
fprintf(fileID, '\n\t\t\t);'); 
fprintf(fileID, '\n'); 

% OUTPUT LAYER
fprintf(fileID, '\n\t\t\tconstant OUTPUT_LAYER : OUTPUT_LAYER_WEIGHTS := (');
for i = 1:PERCEPTRONS_OUTPUT
    fprintf(fileID, '\n\t\t\t\t(');
    for j = 1:PERCEPTRONS_HIDDEN
        fprintf(fileID, 'to_sfixed(%5.4f,U_SIZE,L_SIZE), ', outputWeights(i, j));
    end
    fprintf(fileID, 'to_sfixed(%5.4f,U_SIZE,L_SIZE))', outputBias(i));
    if i ~= PERCEPTRONS_OUTPUT
        fprintf(fileID, ',');
    end  
end
fprintf(fileID, '\n\t\t\t);'); 

% Close file
fclose(fileID);

fprintf('\nDone!\n');