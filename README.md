# Facial Feature Detection using MATLAB

This project consists of MATLAB scripts for detecting facial features using a webcam. Each script detects a specific feature: eyes, nose, mouth, or ears.

## Features

- **Real-Time Detection**: Uses a webcam to detect features in real-time.
- **Annotations**: Displays rectangles around detected features.
- **Sound Alerts**: Plays a sound when a feature is detected.
- **Logging**: Records detections with timestamps in a log file.
- **Image Saving**: Saves images with detected features.

## Requirements

- MATLAB with the Computer Vision Toolbox
- Webcam
- Access to `handel.mat` for sound alerts

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/facial-feature-detection.git
   ```

2. Open MATLAB and navigate to the cloned directory.

3. Ensure your webcam is connected and accessible by MATLAB.

## Usage

### Eyes Detection

Run the `eyes_detection.m` script to detect eyes:

```matlab
run('eyes_detection.m')
```

### Nose Detection

Run the `nose_detection.m` script to detect the nose:

```matlab
run('nose_detection.m')
```

### Mouth Detection

Run the `mouth_detection.m` script to detect the mouth:

```matlab
run('mouth_detection.m')
```

### Ears Detection

Run the `ears_detection.m` script to detect ears:

```matlab
run('ears_detection.m')
```

## Logs

Each script generates a log file recording the timestamp of each detection:
- `eye_detections_log.txt`
- `nose_detections_log.txt`
- `mouth_detections_log.txt`
- `ear_detections_log.txt`
