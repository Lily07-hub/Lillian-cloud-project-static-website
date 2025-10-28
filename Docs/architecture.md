# Architecture Overview

This project deploys a colorful static website to **AWS S3** using infrastructure-as-code principles and CI/CD automation.

## Components

### 1. **Static Website**
- Built with HTML, CSS, and responsive design
- Pages: `index.html`, `about.html`, `contact.html`
- Fully client-side — no backend required

### 2. **AWS S3 Bucket**
- Hosts the website files
- Configured for **static website hosting**
- Made publicly readable via a bucket policy allowing `s3:GetObject` for all users

### 3. **Bash Deployment Script (`scripts/deploy-aws.sh`)**
- Creates a globally unique S3 bucket (using timestamp)
- Enables static website hosting
- Applies public-read policy
- Uploads all website files with `aws s3 sync`

### 4. **GitHub Actions CI/CD Pipeline**
- Triggered on every `git push` to `main`
- Uses AWS credentials stored in **GitHub Secrets**
- Runs the same `deploy-aws.sh` script in a Ubuntu runner
- Deploys to a **new unique bucket** on every run (ensures no naming conflicts)

## Security
- AWS credentials are **never stored in code**
- Secrets are managed via **GitHub Actions Secrets**
- Bucket policy is minimal: only allows public read of objects
