#Create a VPC 10.20.0.0/16
aws ec2 create-vpc \
    --cidr-block 10.20.0.0/16 
    --tag-specifications ResourceType=vpc,Tags=[{Key=Name,Value=MyVpc}]

VPC: vpc-04cfa2d4ba4a23544

#Create an IGW and Attach the IGW to the VPC
IGW:
aws ec2 create-internet-gateway \
    --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=my-igw}]'
igw-0adbb590aa80e8fee


aws ec2 attach-internet-gateway \
    --internet-gateway-id igw-0adbb590aa80e8fee \
    --vpc-id vpc-04cfa2d4ba4a23544

#Create a Public RT and attach Route with 0.0.0.0/0, IGW
RouteTable:
aws ec2 create-route-table --vpc-id vpc-04cfa2d4ba4a23544

rtb-047e5ea45f78c96f9

aws ec2 create-route \
--route-table-id rtb-047e5ea45f78c96f9 \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id igw-0adbb590aa80e8fee

#create 2 Subnets
#Subnet1: CIDR: 10.20.1.0/24, AZ: ca-central-1a
#Subnet2: CIDR: 10.20.2.0/24, AZ: ca-central-1b


aws ec2 create-subnet \
    --vpc-id vpc-04cfa2d4ba4a23544 \
    --cidr-block 10.20.1.0/24 \
    --availability-zone ca-central-1a \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=PublicSubnet1}]'

aws ec2 create-subnet \
    --vpc-id vpc-04cfa2d4ba4a23544 \
    --cidr-block 10.20.2.0/24 \
    --availability-zone ca-central-1b \
    --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=mPublicSubnet2}]'

Subnet1ID:  subnet-0b8fd9bdb83af3cc0
Subnet2ID:  subnet-02e8f882ae0f1be0e

#Associate route table
aws ec2 associate-route-table --route-table-id rtb-047e5ea45f78c96f9 --subnet-id subnet-0b8fd9bdb83af3cc0
aws ec2 associate-route-table --route-table-id rtb-047e5ea45f78c96f9 --subnet-id subnet-02e8f882ae0f1be0e

aws ec2 modify-subnet-attribute --subnet-id subnet-0b8fd9bdb83af3cc0 --map-public-ip-on-launch

aws ec2 modify-subnet-attribute --subnet-id subnet-02e8f882ae0f1be0e --map-public-ip-on-launch

AssociationId": "rtbassoc-04f4f1984dc1cdf6a
AssociationId": "rtbassoc-0e44a52c61138166f

#Create a EC2-SG, with 80, 22 allow for 0.0.0.0/0
aws ec2 create-security-group \
    --group-name my-sg \
    --description "My security group" \
    --vpc-id vpc-04cfa2d4ba4a23544 \
    --tag-specifications 'ResourceType=security-group,Tags=[{Key=Name,Value=my-sg}]'
SG-ID: sg-0d51d56c885c4af7f


#Create an EC2 with Subnet1ID, SG-ID, AMI-ID:
aws ec2 run-instances \
    --image-id ami-0956b8dc6ddc445ec \
    --count 1 \
    --instance-type t2.micro \
    --key-name canadakpair \
    --security-group-ids sg-0d51d56c885c4af7f \
    --subnet-id subnet-0b8fd9bdb83af3cc0 \
    --region ca-central-1
    
    "ClientToken": "9c5d162b-a05c-46ac-881a-27e62600bcfd"
    For my reference later:
    "ReservationId": "r-0fbd6966d3abfe1c6",
    "OwnerId": "571600854327",
    "Groups": [],
    "Instances": [
        {
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "9c5d162b-a05c-46ac-881a-27e62600bcfd",
            "EbsOptimized": false,
            "EnaSupport": true,
        