% Initialize webcam
try
    web = webcam();
catch
    error('Webcam not detected.');
end

% Initialize detectors
earDetector = vision.CascadeObjectDetector('LeftEar');

% Open log file
logFile = fopen('ear_detections_log.txt', 'a');

% Load sound
load handel.mat;

% Initialize counter for saving images
counter = 1;

figure;

while true
    % Capture image
    im = snapshot(web);
    imGray = rgb2gray(im);
    
    % Detect ears
    earBbox = step(earDetector, imGray);
    
    % Annotate image
    im = insertObjectAnnotation(im, 'rectangle', earBbox, 'Ear');
    
    % Play sound if ear detected
    if ~isempty(earBbox)
        sound(y, Fs);
        fprintf(logFile, 'Ear detected at %s\n', datestr(now, 'HH:MM:SS'));
        imwrite(im, sprintf('ear_detected_%d.png', counter));
        counter = counter + 1;
    end
    
    % Display image
    imshow(im);
    
    % Exit on key press
    if ~isempty(get(gcf, 'CurrentCharacter'))
        break;
    end
    pause(0.1);
end

% Clean up
fclose(logFile);
clear web;
