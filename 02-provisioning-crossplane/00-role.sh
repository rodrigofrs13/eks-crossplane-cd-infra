# Create the role with the trust policy
# Executar na conta Control Plane
# Mudar o id da conta para a conta do Control Plane
# Mudar o OIDC do EKS

####  TODO-Automatizar para pegar o ID da conta AWS e o OIDC do EKS

export OIDC=xxx

#kubectl config use-context controlplane;

# Create the role with the trust policy
aws iam create-role --role-name control-plane-admin --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::xxx:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/xxx"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringLike": {
                    "oidc.eks.us-east-1.amazonaws.com/id/xxx:sub": "system:serviceaccount:crossplane-system:provider-aws-*"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com",
                    "eks.amazonaws.com",
                    "eks-nodegroup.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}'

# Mudar o id da conta para a conta do dataplane
# Attach the custom policy to the role
aws iam attach-role-policy --role-name control-plane-admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess