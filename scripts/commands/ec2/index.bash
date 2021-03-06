SECURITY_GROUPS="join(',',NetworkInterfaces[].Groups[].GroupId)"

FILTER=$(auto_filter "$TAG_NAME" InstanceId InstanceType State.Name Placement.AvailabilityZone "$SECURITY_GROUPS" -- $@)

awscli ec2 describe-instances --output table --query "Reservations[].Instances[$FILTER][].{\"1.Name\":$TAG_NAME,\"2.InstanceId\":InstanceId,\"3.Type\":InstanceType,\"4.State\":State.Name,\"5.SecurityGroups\":$SECURITY_GROUPS,\"6.LaunchTime\":LaunchTime,\"7.AZ\":Placement.AvailabilityZone,\"8.PublicDNS\":PublicDnsName}"