
# The Project
The project idea is to demonstrate my skills by creating simple app with infrastructure and wrap it with github actions deployment process.

## The App
The main app idea is simple python application that takes json as input and parse it according to specific needs then upload to s3 bucket.
The project divides into 2 parts - application and infrastructure:
the application is simple python application that parse given JSON object and upload it to s3.
while the infrastructure part goal is to set up private s3 bucket on given aws account with cloudfront by using terraform and terragrunt and make sure that the bucket will be accessible only fron cloudfront. 
and its all wrapped with github actions pipeline.

## Getting Started

### Dependencies
* aws account
* before running make sure to add your aws account credentials (AWS_ACCESS_KEY_ID , AWS_SECRET_ACCESS_KEY, AWS_REGION to actions secrets


## Usage/Examples
to execute the process simply go to Actions , select deploy app and infra and click on run workflow.
please note that the process currently supports only manual deployment


## Help
Any advise for common problems or issues.

## Authors
@me
