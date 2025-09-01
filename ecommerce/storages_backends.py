from storages.backends.s3boto3 import S3Boto3Storage
from django.conf import settings

class MediaStorage(S3Boto3Storage):
    location = "media"
    default_acl = None
    file_overwrite = False
    custom_domain = settings.CLOUDFRONT_DOMAIN   # <-- this makes Django return CloudFront URL
