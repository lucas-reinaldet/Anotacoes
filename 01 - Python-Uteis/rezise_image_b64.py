import base64
from PIL import Image
import io

def resize_image_base64(self, image : str):
    
    img = Image.open(io.BytesIO(base64.b64decode(image)))
    img.thumbnail((800,600), Image.ANTIALIAS)
    buffered = io.BytesIO()
    img.save(buffered, format="JPEG")
    return base64.b64encode(buffered.getvalue()).decode('utf-8')