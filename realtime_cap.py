import cv2
import argparse
from threading import Thread

class ThreadedCamera(object):
    def __init__(self, source = 0):

        self.capture = cv2.VideoCapture(source)

        self.thread = Thread(target = self.update, args = ())
        self.thread.daemon = True
        self.thread.start()

        self.status = False
        self.frame  = None

    def update(self):
        while True:
            if self.capture.isOpened():
                (self.status, self.frame) = self.capture.read()

    def grab_frame(self):
        if self.status:
            return self.frame
        return None  
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Realtime capture")
    parser.add_argument('--left_source', type=str, required=True)
    parser.add_argument('--right_source', type=str, required=True)
    parser.add_argument('--left_prefix', type=str, required=True)
    parser.add_argument('--right_prefix', type=str, required=True)
    parser.add_argument('--image_dir', type=str, required=True)
    parser.add_argument('--image_format', type=str, required=True)

    args = parser.parse_args()
    i_both = 0
    stream_link = args.left_source #"http://165.194.27.184:10001"
    stream_link_wide = args.right_source #"http://165.194.27.184:10002"
    streamer = ThreadedCamera(stream_link)
    streamer_wide = ThreadedCamera(stream_link_wide)

    while True :
        frame = streamer.grab_frame()
        frame_wide = streamer_wide.grab_frame()
        if frame is not None and frame_wide is not None:
            cv2.imshow("Context", frame)
            cv2.imshow("Context2", frame_wide)

            if cv2.waitKey(10) > 0:
                cv2.imwrite(args.image_dir + "/both/" + args.left_prefix + str(i_both) + "." + args.image_format, frame)
                cv2.imwrite(args.image_dir + "/both/" + args.right_prefix + str(i_both) + "." + args.image_format, frame_wide)
                i_both = i_both+1
                if i_both > 30:
                    cv2.destroyAllWindows()
                    break