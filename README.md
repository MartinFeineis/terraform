# terraform
Play Repository for terraform

For the s3-backend terraform remote state to work
the 
```
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```
Environment Variables have to be setup in the CircleCI Context

To see module outputs in the root module you have to reference the module

Run with 
```
terraform plan -var-file=varsfile.tfvars
```
To retrieve the credentials of the developer account use
```
terraform output dev_account
```