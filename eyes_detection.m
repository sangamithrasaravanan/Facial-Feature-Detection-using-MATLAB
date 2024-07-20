% Initialize webcam
try
    web = webcam();
catch
    error('Webcam not detected.');
end

% Initialize detectors
eyeDetector = vision.CascadeObjectDetector('EyePairBig');

% Open log file
logFile = fopen('eye_detections_log.txt', 'a');

% Load sound
load handel.mat;

% Initialize counter for saving images
counter = 1;

figure;

while true
    % Capture image
    im = snapshot(web);
    imGray = rgb2gray(im);
    
    % Detect eyes
    eyeBbox = step(eyeDetector, imGray);
    
    % Annotate image
    im = insertObjectAnnotation(im, 'rectangle', eyeBbox, 'Eyes');
    
    % Play sound if eyes detected
    if ~isempty(eyeBbox)
        sound(y, Fs);
        fprintf(logFile, 'Eyes detected at %s\n', datestr(now, 'HH:MM:SS'));
        imwrite(im, sprintf('eyes_detected_%d.png', counter));
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
