import inspect


from solid2 import *
from solid2.extensions.bosl2 import *

set_global_fn(100)


def get_name():
    # Use the inspect module to get the calling frame
    frame = inspect.stack()[1]  # [0] is the current frame, [1] is the caller
    caller_filename = frame.filename  # Get the filename of the caller
    return caller_filename.split("/")[-1].split(".")[0]  # Extract just the file name
