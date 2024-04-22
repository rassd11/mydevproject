# Welcome to the Project!

Hey there! If you're checking out this project, you're in for a treat. This is my playground to showcase some cool skills, all bundled up into a simple yet effective application.

## What's the App All About?

Imagine a Python app that's like a helpful genie for JSON files. You feed it some JSON, and it works its magic, parsing it just the way you need. But that's not all—it then whisks that parsed data off to an AWS S3 bucket. Handy, right?

This project has two sides to it:

### 1. The Application

This is where the magic happens. The Python app does its JSON parsing and S3 uploading dance. It's straightforward yet powerful.

### 2. The Infrastructure

Now, this part is the backbone. We're talking about setting up a private S3 bucket in your AWS account, with CloudFront sprinkled on top for some extra magic. We're using Terraform and Terragrunt to weave this infrastructure together. And oh, we make sure that bucket is accessible only through CloudFront.

And guess what? We've got it all wrapped up in a neat little bow with GitHub Actions. Deployments made easy!

## Ready to Dive In?

### Dependencies

All you need is an AWS account and a bit of enthusiasm!

Before you dive in, make sure to add your AWS account credentials (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION) to your GitHub Actions secrets. Safety first!

### Usage

Ready to rock? Head over to Actions, find the "Deploy App and Infra" workflow, and hit that "Run Workflow" button. Simple as that! Just a heads-up, for now, it's manual deployments only, but hey, we're working on it!

## What's Next?

We've got big dreams for this project. Here's what's on our to-do list:

- Swap out AWS authentication to something snazzier, like role-based access.
- Sprinkle in more tools and technologies. The sky's the limit!

## Need a Hand?

Got questions? Ran into a snag? Or maybe you have some awesome advice? Reach out anytime. We're all ears!

### About the Author

Hey there! I'm @me. Nice to meet you!
