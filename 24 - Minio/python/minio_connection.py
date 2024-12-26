
# pip install minio

from minio import Minio

def client():
    return Minio(
        "localhost:9000",
        access_key="python",
        secret_key="Y8X4WGRcAA4FppjsYuDHOIBlgjs8nAen",
        secure=False
    )
