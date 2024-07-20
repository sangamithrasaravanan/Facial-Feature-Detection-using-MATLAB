% Initialize webcam
try
    web = webcam();
catch
    error('Webcam not detected.');
end

% Initialize detectors
noseDetector = vision.CascadeObjectDetector('Nose');

% Open log file
logFile = fopen('nose_detections_log.txt', 'a');

% Load sound
load handel.mat;

% Initialize counter for saving images
counter = 1;

figure;

while true
    % Capture image
    im = snapshot(web);
    imGray = rgb2gray(im);
    
    % Detect nose
    noseBbox = step(noseDetector, imGray);
    
    % Annotate image
    im = insertObjectAnnotation(im, 'rectangle', noseBbox, 'Nose');
    
    % Play sound if nose detected
    if ~isempty(noseBbox)
        sound(y, Fs);
        fprintf(logFile, 'Nose detected at %s\n', datestr(now, 'HH:MM:SS'));
        imwrite(im, sprintf('nose_detected_%d.png', counter));
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
