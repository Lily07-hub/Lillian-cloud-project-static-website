#!/bin/bash

# Configuration
BUCKET_NAME="my-cloud-project-$(date +%s)"
REGION="us-east-1"
WEBSITE_DIR="./Website"

# Validate website directory
if [ ! -d "$WEBSITE_DIR" ]; then
  echo "❌ ERROR: Website folder '$WEBSITE_DIR' not found!"
  echo "Current directory contents:"
  ls -la
  exit 1
fi

echo "🚀 Deploying static website to AWS S3..."
echo "Bucket: $BUCKET_NAME"

# 1. Create S3 bucket (us-east-1 requires no LocationConstraint)
aws s3api create-bucket --bucket "$BUCKET_NAME"

# 2. Disable Block Public Access settings programmatically
aws s3api put-public-access-block \
  --bucket "$BUCKET_NAME" \
  --public-access-block-configuration '{
    "BlockPublicAcls": true,
    "IgnorePublicAcls": true,
    "BlockPublicPolicy": false,
    "RestrictPublicBuckets": true
  }'

# 3. Enable static website hosting
aws s3 website "s3://$BUCKET_NAME" --index-document index.html

# 4. Upload website files (ACLs are blocked, so no --acl flag)
aws s3 sync "$WEBSITE_DIR" "s3://$BUCKET_NAME" --delete

# 5. Apply public-read bucket policy
cat > bucket-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::$BUCKET_NAME/*"
    }
  ]
}
EOF

aws s3api put-bucket-policy --bucket "$BUCKET_NAME" --policy file://bucket-policy.json

# 6. Clean up temporary file
rm -f bucket-policy.json

# 7. Output success message
echo ""
echo "✅ SUCCESS! Your website is LIVE:"
echo "🌐 http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
echo ""
echo "💡 Note: It may take 10–20 seconds for the website endpoint to activate."