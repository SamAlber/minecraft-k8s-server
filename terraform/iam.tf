# Adding IAM access worked only through the cluster Access,
# that way kubectl finally worked, remember iamadmin already has administrator access over everything! 
/*
arn:aws:iam::794897446857:role/AmazonEKSClusterInsightsViewOnlyRole
Standard
arn:aws:sts::794897446857:assumed-role/AmazonEKSClusterInsightsViewOnlyRole/{{SessionName}}
-
AmazonEKSClusterInsightsViewPolicy
arn:aws:iam::761018880324:role/spot-eks-node-group-20250123213344079400000003
EC2 Linux
system:node:{{EC2PrivateDNSName}}
system:nodes
-
arn:aws:iam::761018880324:role/on_demand-eks-node-group-20250123213344078400000002
EC2 Linux
system:node:{{EC2PrivateDNSName}}
system:nodes
-
arn:aws:iam::761018880324:user/iamadmin
Standard
arn:aws:iam::761018880324:user/iamadmin
-
AmazonEKSAdminPolicy, AmazonEKSClusterAdminPolicy, AmazonEKSNetworkingPolicy
*/ 
