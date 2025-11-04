# Group 3 – Static Website on AWS  
Live Site:(http://my-cloud-project-1761568558.s3-website-us-east-1.amazonaws.com/index.html)

Demo Video: [Link to your video] 

Documentation: See /docs folder  

## Features  
- Fully automated deployment via AWS CLI + GitHub Actions  
- Beautiful, colorful, responsive design with gradient styling  
- Multi-page site (Home, About, Contact)  
- Hosted on AWS S3 with public static website hosting  
- Pure static site  

## Project Structure  
website/        – Static HTML/CSS files  
scripts/        – AWS deployment automation (deploy.sh)  
.github/workflows/ – GitHub Actions CI/CD (deploy.yml)  
docs/           – Architecture, deployment steps, screenshots  

## How to Deploy  
1. Run locally: `./scripts/deploy.sh`  
2. Or push to GitHub, deployment runs automatically via GitHub Actions  
3. Visit your live site at the URL printed in the terminal or Actions log  

## Built for  
Cloud Computing Final Project – October 2025
