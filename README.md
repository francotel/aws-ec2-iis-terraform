# 🌐 AWS and Terraform in Action: Build Your First IIS Web Server on EC2

![AWS](https://img.shields.io/badge/AWS-EC2-orange) ![Terraform](https://img.shields.io/badge/Terraform-IaC-blue) ![IIS](https://img.shields.io/badge/IIS-Windows_Server-green)

## 📋 **Project Overview**

This project demonstrates how to deploy a Windows IIS web server on an AWS EC2 instance using Terraform. The infrastructure is fully automated with Terraform and enhanced with a Makefile to streamline the deployment process. It’s perfect for showcasing your DevOps skills and understanding of AWS infrastructure.

## 🚀 **Features**

- Creation of a VPC with a public subnet.
- Deployment of a Windows Server EC2 instance.
- Automatic installation of IIS through a PowerShell script in the user data.
- Easy automation of Terraform commands using a Makefile.

## 🛠️ **Getting Started**

### **Prerequisites**

- AWS account
- Terraform installed on your local machine
- AWS CLI configured with your credentials

### **How to Run the Project**

1. Clone the repository:

   ```bash
   git clone https://github.com/francotel/aws-ec2-iis-terraform.git
   cd aws-ec2-iis-terraform
   ````

## 📑 **Makefile Overview**

The Makefile helps automate Terraform commands, making it easy to manage the deployment:

Replace this Variables globales in Makefile
AWS_PROFILE ?= SET-AWS-PROFILE
AWS_REGION ?= SET-AWS-REGION

- **`tf-init`**: Initializes Terraform and validates the configuration.
- **`tf-plan`**: Creates a plan to show what Terraform will do.
- **`tf-apply`**: Applies the Terraform plan to deploy resources.
- **`tf-destroy`**: Destroys all the created resources.

For full Makefile details, refer to the [Makefile](Makefile) in the repository.

