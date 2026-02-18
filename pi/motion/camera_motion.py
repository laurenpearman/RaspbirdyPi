from picamera2 import Picamera2
import cv2
import numpy as np
import time

picam2 = Picamera2()
picam2.configure(picam2.create_preview_configuration(
    main={"size": (640, 480), "format": "RGB888"}
    ))
picam2.start()

prev = None

while True:
    frame = picam2.capture_array()
    gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
    gray = cv2.GaussianBlur(gray, (21, 21), 0)
    
    if prev is None:
        prev = gray
        continue
    
    diff = cv2.absdiff(prev, gray)
    thresh = cv2.threshold(diff, 25, 255, cv2.THRESH_BINARY)[1]
    motion_pixels = np.sum(thresh > 0)
    
    if motion_pixels > 8000:
        filename = f"motion_{int(time.time())}.jpg"
        picam2.capture_file(f"/home/lauren/RaspbirdyPi/data/images/{filename}")
        print("Motion detected:", filename)
        time.sleep(2)
        
    prev = gray
