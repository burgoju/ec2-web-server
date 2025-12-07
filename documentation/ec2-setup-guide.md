# EC2 Setup Guide - Step by Step

## 1. Prerequisites
- AWS Free Tier account
- IAM user with EC2 permissions
- Basic understanding of SSH

## 2. Launching the Instance
### Via AWS Console:
1. Navigate to EC2 Dashboard
2. Click "Launch Instance"
3. Configure:
   - Name: `web-server-day2`
   - AMI: Ubuntu Server 22.04 LTS
   - Instance Type: t2.micro
   - Key Pair: Create new
   - Security Group: Allow SSH (22) and HTTP (80)
   - User Data: Paste the script from `user-data-script.sh`

### Via AWS CLI:
```bash
aws ec2 run-instances \
    --image-id ami-0c55b159cbfafe1f0 \
    --instance-type t2.micro \
    --key-name aws-learning-key \
    --security-group-ids sg-xxxxxx \
    --user-data file://user-data-script.sh
