# pip install aspose-words

import aspose.words as aw

doc = aw.Document()
builder = aw.DocumentBuilder(doc)

path_ = r"arquivo"

builder.insert_image(f"{path_}.jpg")

doc.save(f"{path_}.pdf")
