resource "aws_cloudfront_origin_access_identity" "website" {
  comment = local.origin_access_name
}
