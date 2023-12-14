import cv2
import os
from pydub import AudioSegment
from pydub.playback import play

# Function to play videos
def play_videos(video_folder):
    video_files = [f for f in os.listdir(video_folder) if f.endswith(".mp4")]

    total_videos = len(video_files)
    current_video_number = 0

    

    while current_video_number < total_videos:
        video_path = os.path.join(video_folder, video_files[current_video_number])

        audio = AudioSegment.from_file(video_path, format="mp4")

        # Display video information
        print(f"Playing Video {current_video_number + 1}/{total_videos}")
        print(f"Video Path: {video_path}")

        # Open the video file
        cap = cv2.VideoCapture(video_path)

        while True:
            ret, frame = cap.read()

            if not ret:
                break

            # Display video frame
            cv2.imshow("Video Player", frame)

            # Display video information (modify as needed)
            cv2.putText(frame, f"Time: {int(cap.get(cv2.CAP_PROP_POS_MSEC) / 1000)}s",
                        (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)
            cv2.putText(frame, f"Frame: {int(cap.get(cv2.CAP_PROP_POS_FRAMES))} out of {int(cap.get(cv2.CAP_PROP_FRAME_COUNT))}",
            (10, 60), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)

            cv2.putText(frame, f"Status: Playing",
                        (10, 90), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)
            
            cv2.putText(frame, f"Resolution: {int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))}x{int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))}",
            (10, 120), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 1)


            cv2.imshow("Video Player", frame)

            key = cv2.waitKey(30)

            if key == ord('\r'):  # Enter key
                current_video_number += 1
                cap.release()
                cv2.destroyAllWindows()
                break
            elif key == ord('d'):  # Delete key
                current_video_number += 1
                cap.release()
                cv2.destroyAllWindows()
                os.remove(video_path)
                
                break
            elif key == ord('a'):  # A key
                current_video_number -= 1 if current_video_number > 0 else 0
                cap.release()
                cv2.destroyAllWindows()
                break

        #play(audio)

# Specify the folder containing the videos
video_folder = r"D:\gchd\Takeout\Fotky Google\Photos from 2019"

# Call the function to play videos
play_videos(video_folder)
