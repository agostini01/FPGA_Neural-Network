filename = 'string.txt';
fileID = fopen(filename, 'w+');

fprintf(fileID, '\t\tcase sample_count is');
for i = 0:178
    fprintf(fileID, '\n\t\t\twhen %d => sample_str := "%03d";', i, i);
end
fprintf(fileID, '\n\t\tend case;');
fprintf(fileID, '\n'); 

fprintf(fileID, '\n\t\tcase error_count is');
for i = 0:178
    fprintf(fileID, '\n\t\t\twhen %d => error_str := "%03d";', i, i);
end
fprintf(fileID, '\n\t\tend case;');
fprintf(fileID, '\n'); 

fclose(fileID);