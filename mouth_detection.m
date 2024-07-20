% Initialize webcam
try
    web = webcam();
catch
    error('Webcam not detected.');
end

% Initialize detectors
faceDetector = vision.CascadeObjectDetector('FrontalFaceCART');
mouthDetector = vision.CascadeObjectDetector('Mouth', 'MergeThreshold', 16);

% Open log file
logFile = fopen('detections_log.txt', 'a');

% Load sound
load handel.mat;

% Initialize counter for saving images
counter = 1;

figure;

while true
    % Capture image
    im = snapshot(web);
    imGray = rgb2gray(im);
    
    % Detect faces
    faceBbox = step(faceDetector, imGray);
    
    for i = 1:size(faceBbox, 1)
        % Crop face region
        face = imcrop(imGray, faceBbox(i, :));
        
        % Detect mouths in face region
        mouthBbox = step(mouthDetector, face);
        
        for j = 1:size(mouthBbox, 1)
            mouthBbox(j, 1:2) = mouthBbox(j, 1:2) + faceBbox(i, 1:2);
        end
        
        % Annotate image
        im = insertObjectAnnotation(im, 'rectangle', mouthBbox, 'Mouth');
        
        % Play sound if mouth detected
        if ~isempty(mouthBbox)
            sound(y, Fs);
            fprintf(logFile, 'Mouth detected at %s\n', datestr(now, 'HH:MM:SS'));
            imwrite(im, sprintf('detected_%d.png', counter));
            counter = counter + 1;
        end
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
