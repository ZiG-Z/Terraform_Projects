resource "aws_s3_bucket" "mybkt" {
  bucket = "aws.my.bkt"
  acl    = "public-read"
  provider = aws.sg 
  policy = file(var.policy)
  tags = {
    "Name"        = "My Bucket"
    "Environment" = "Dev"
  }
  force_destroy = true
  versioning {
    enabled = true
  }
  website {
    index_document = "index.html"
    error_document = "error.html"
    routing_rules  = <<EOF
    [{
      "Condition": {
        "KeyPrefixEquals": "docs/"
      },
      "Redirect": {
        "ReplaceKeyPrefixWith":"documents/"
      }
    }]
    EOF
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  replication_configuration {
    role = aws_iam_role.replication.arn
    rules {
      id       = "aws.my.bkt-replicate"
      priority = 0
      status   = "Enabled"
      destination {
        bucket        = aws_s3_bucket.destination.arn
        storage_class = "STANDARD"
      }
    }
  }
}

#Destination Replicated S3 Bucket

resource "aws_s3_bucket" "destination" {
  bucket = "aws.my.bkt-replicate"
  acl    = "private"
  tags = {
    "Name" = "aws.my.bkt-replicate"
  }
  force_destroy = true
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}




