
# Project Title
The main project idea is simple python application that takes json as input and parse it according to specific needs then upload to s3 bucket.

The project divides into 2 parts - application and infrastructure:
the application is simple python application that parse given JSON object and upload it to s3.
while the infrastructure part goal is to set up private s3 bucket on given aws account with cloudfront by using terraform and terragrunt and make sure that the bucket will be accessible only fron cloudfront. 
and wrap it all with github action pipeline.


## Usage/Examples

1. create aws account
2. before running make sure to add AWS_ACCESS_KEY_ID , AWS_REGION       AWS_SECRET_ACCESS_KEY into secrets and variables >> actions
3. go to Actions , select deploy app and infra and click on run workflow

