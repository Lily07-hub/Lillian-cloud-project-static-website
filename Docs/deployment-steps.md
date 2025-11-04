Deployment Steps
Followed these steps to deploy the static website on AWS.

Step 1: Set Up Local Environment
Installed AWS CLI, Git, and VS Code
Configured AWS credentials: `aws configure`
Created GitHub repo: `cloud-project-static-website`

Step 2: Build Unique Website
Created `website/index.html`, `about.html`, and `contact.html`
Added custom content with personal name and project info
Styled with `style.css` using colorful gradients and responsive layout

Step 3: Write Deployment Script
Created `scripts/deploy.sh`
Configured to:
- Generate unique S3 bucket name: `my-cloud-site-$(date +%s)`
- Create bucket in `us-east-1`
- Enable static website hosting (`index.html` as default)
- Apply public-read bucket policy
- Sync all files from `website/` with `aws s3 sync`

Step 4: Automate with GitHub Actions
Created `.github/workflows/deploy.yml`
Configured to:
- Trigger on every `push` to `main`
- Use AWS credentials from GitHub Secrets
- Run ./scripts/deploy.sh`
Added secrets: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`
Ensured Personal Access Token had `repo` and `workflow` scopes

Step 5: Deploy
Ran locally to test: `./scripts/deploy.sh`
Verified live site at printed URL: `http://<bucket>.s3-website-us-east-1.amazonaws.com`
Pushed all files to GitHub:
  git add .
  git commit -m "Complete project"
  git push --force origin main   safe for empty repo
Confirmed GitHub Actions ran successfully and deployed new site

Step 6: Document & Submit
Took screenshots of:
- Live website
- GitHub Actions success log
- S3 bucket policy fix
Wrote `README.md`, `architecture.md`, and this `deployment-steps.md`
Organized all files in clear folder structure
Pushed final documentation to GitHub

 Challenges Faced
Invalid AWS key: Regenerated IAM access key and updated CLI config
GitHub push failed: Added `workflow` scope to Personal Access Token
Bucket not public: Added explicit S3 bucket policy allowing `s3:GetObject`
Merge conflict on empty repo: Used `git push --force` to reset cleanly

 Success Criteria Met
Website accessible at `http://<bucket>.s3-website-us-east-1.amazonaws.com` (port 80 only)
 No manual AWS Console steps — all via CLI/script
 All code, scripts, and docs in GitHub with version control
 Screenshots, documentation, and automation included
