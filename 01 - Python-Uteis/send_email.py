import smtplib

import smtplib
from email.message import EmailMessage
import imghdr
import ssl

body = """
this is first mail by using python
Thank you! python
"""
EMAIL_ADDRESS = 'xyz@gmail.com'
EMAIL_PASSWORD = 'xyz'
smtp_server = "smtp.gmail.com"
message = EmailMessage()
message['Subject'] = 'This is my first Python email'
message['From'] = EMAIL_ADDRESS
message['To'] = ["abc@gmail.com", "user_name@company_name.com"]
message.set_content(body, 'plain')
with open("path_to_image.png", 'rb') as img:
    img_data = img.read()
    img_type = imghdr.what(img.name)

message.add_attachment(img_data, maintype='image', subtype=img_type, filename='filename')
default_context = ssl.create_default_context()
print("sending...")
with smtplib.SMTP_SSL(smtp_server, port=465, context=default_context) as server:
    server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
    server.send_message(message)

print("success!!!")