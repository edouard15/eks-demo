data "aws_iam_policy_document" "developer" {
    statement {
      sid = "AllowDeveloper"
      effect = "Allow"
      actions = [
        "eks:DescribeNodegroup",
        "eks:ListNodegroups",
        "eks:DescribeCluster",
        "eks:ListCluster",
        "eks:AccessKubernetesApi",
        "ssm:GetParameter",
        "eks:ListUpdates",
        "eks:ListFargateProfile"
      ]
      resources = ["*"]
    }
  
}

data "aws_iam_policy_document" "master" {
    statement {
      sid       = "AllowAdmin"
      effect    = "Allow"
      actions   = ["*"]
      resources = ["*"]
    }

    statement {
        sid       = "AllowPassRole"
      effect    = "Allow"
      actions   = [
        "iam:PassRole"
      ]

      resources = ["*"]
      condition {
        test = "StringEquals"
        variable = "iam:PassedToService"
        values = ["eks.amazonaws.com"]
      } 
    } 
}

data "aws_iam_policy_document" "master_assume_role" {
    statement {
      sid = "AllowAccountAssumeRole"
      effect = "Allow"
      actions = [
        "sts:AssumeRole",
      ]
      principals {
        type = "AWS"
        identifiers = [data.aws_caller_identity.current.account_id]
      }
    }
}

data "aws_iam_policy_document" "master_role" {
    statement {
      sid = "AllowMasterAssumeRole"
      effect = "Allow"
      actions = [
        "sts:AssumeRole",
      ]
    
      resources =  ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Master-eks-Role"]
      }
    }
    


data "aws_caller_identity" "current" {
  
}