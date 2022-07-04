variable AWS_REGION {}
variable PROJECT_NAME {}
variable DEEPLAB_BUCKETNAME {}

terraform {
    backend "s3" {
        key = "terraform.tfstate"
    }
}

provider "aws" {
    region = var.AWS_REGION
}

resource "aws_s3_bucket" "dataset_bucket" {
    bucket = var.DEEPLAB_BUCKETNAME
    tags = {
        ProjectName = var.PROJECT_NAME
    }
    lifecycle {
        prevent_destroy = true
    }
}
