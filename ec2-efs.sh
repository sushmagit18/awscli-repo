$ aws ec2 create-security-group \
--region ca-central-1 \
--group-name efs-walkthrough1-ec2-sg \
--description "Amazon EFS walkthrough 1, SG for EC2 instance" \
--vpc-id vpc-06c367b0a8c4e9094

SG-1: {
"GroupId": "sg-02e461ddefeee0004"
 }

 $ aws ec2 authorize-security-group-ingress \
--group-id sg-02e461ddefeee0004 \
--protocol tcp \
--port 22 \
--cidr 0.0.0.0/0 \
--region ca-central-1

You can find the VPC ID using the following command.

$ aws  ec2 describe-vpcs

$ aws ec2 create-security-group \
--region ca-central-1 \
--group-name  efs-walkthrough1-mt-sg1 \
--description "Amazon EFS walkthrough 1, SG for mount target" \
--vpc-id vpc-06c367b0a8c4e9094

"GroupId": "sg-093ebe14b239213d7"

aws ec2 authorize-security-group-ingress \
--group-id sg-093ebe14b239213d7 \
--protocol tcp \
--port 2049 \
--source-group sg-02e461ddefeee0004 \
--region ca-central-1

$ aws ec2 run-instances \
--image-id ami-0956b8dc6ddc445ec \
--count 1 \
--instance-type t2.micro \
--associate-public-ip-address \
--key-name canadakpair \
--security-group-ids sg-02e461ddefeee0004 \
--subnet-id subnet-018ee9be5adc9d8d5 \
--region ca-central-1 \

i-03c08447eff6aa455

aws efs create-file-system \
--encrypted \
--creation-token FileSystemForWalkthrough1 \
--tags Key=Name,Value=SomeExampleNameValue \
--region ca-central-1 \

FileSystemId": "fs-0093ac5b4c22a2da5"

aws efs put-lifecycle-configuration \
--file-system-id fs-0093ac5b4c22a2da5 \
--lifecycle-policies TransitionToIA=AFTER_30_DAYS \
--region ca-central-1 \

 $ aws efs create-mount-target \
--file-system-id fs-0093ac5b4c22a2da5 \
--subnet-id subnet-018ee9be5adc9d8d5 \
--security-group sg-093ebe14b239213d7 \
--region ca-central-1 
      
ec2-35-182-206-132.ca-central-1.compute.amazonaws.com
fs-0093ac5b4c22a2da5.efs.ca-central-1.amazonaws.com

sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0093ac5b4c22a2da5.efs.ca-central-1.amazonaws.com:/   ~/efs-mount-point  


