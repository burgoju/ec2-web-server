# EC2 Web Server Deployment - Day 2

## 🚀 Project Overview
Automated deployment of an Apache web server on AWS EC2 using User Data scripts.

## 📋 What Was Deployed
- **Instance Type:** t2.micro (Free Tier)
- **AMI:** Ubuntu 22.04 LTS
- **Security Group:** Ports 22 (SSH) and 80 (HTTP)
- **Web Server:** Apache 2.4
- **Automation:** User Data script for zero-touch deployment

## 🔧 Technical Implementation

### User Data Script
The instance was launched with a bash script that:
1. Updates package lists
2. Installs Apache
3. Deploys a custom HTML page
4. Configures and starts the web server
5. Creates deployment metadata

### Security Configuration
- SSH access restricted to my IP only
- HTTP open to public for web access
- Key pair authentication for SSH

## 🌐 Access Information
- **Public IP:** [YOUR-EC2-PUBLIC-IP]
- **Website URL:** http://[YOUR-EC2-PUBLIC-IP]
- **SSH Command:** `ssh -i aws-learning-key.pem ubuntu@[IP]`

## 📈 Learning Outcomes
- Hands-on EC2 instance creation
- Security group configuration
- User Data automation
- Apache web server setup
- SSH key management

## 🛠️ Files in This Repository
- `user-data-script.sh` - Automation script
- `website/` - Static website files
- `documentation/` - Setup guide

## 🔗 Related Projects
- [Day 1: IAM Setup](https://github.com/burgoju/aws-iam-setup)
- [Day 3: Coming soon...]

---

**Date:** $(Get-Date -Format "yyyy-MM-dd")
**Status:** ✅ Live and accessible
