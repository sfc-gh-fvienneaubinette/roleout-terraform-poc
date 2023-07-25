# roleout-terraform-poc

Follow the guide [here](https://quickstarts.snowflake.com/guide/terraforming_snowflake/index.html?index=..%2F..index#0)!

1. Hi!

2. Setup this repository

```
mkdir sfguide-terraform-sample && cd sfguide-terraform-sample
echo "# sfguide-terraform-sample" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:YOUR_GITHUB_USERNAME/sfguide-terraform-sample.git
git push -u origin main
```

3. Create service user for Terraform

Create an RSA key for authentication

```
cd ~/.ssh
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out snowflake_tf_snow_key.p8 -nocrypt
openssl rsa -in snowflake_tf_snow_key.p8 -pubout -out snowflake_tf_snow_key.pub
```

Create the user in Snowflake
```
use role accountadmin;

CREATE USER "tf-snow" RSA_PUBLIC_KEY='RSA_PUBLIC_KEY_HERE' DEFAULT_ROLE=PUBLIC MUST_CHANGE_PASSWORD=FALSE;

GRANT ROLE SYSADMIN TO USER "tf-snow";
GRANT ROLE SECURITYADMIN TO USER "tf-snow";
```

4. Add account information to environment
```
export SNOWFLAKE_USER="tf-snow"
export SNOWFLAKE_PRIVATE_KEY_PATH="~/.ssh/snowflake_tf_snow_key.p8"
export SNOWFLAKE_ACCOUNT="YOUR_ACCOUNT_LOCATOR"
export SNOWFLAKE_REGION="YOUR_REGION_HERE"
```

If you plan on working on this or other projects in multiple shells, it may be convenient to put this in a snow.env file that you can source or put it in your .bashrc or .zshrc file. For this lab, we expect you to run future Terraform commands in a shell with those set.

5. Declaring resources

Use the outputs from Roleout: `databases.tf`, `virtual_warehouse,tf`, `functional_roles.tf`, `rbac.tf`, `snowflake.tf`, `databases.tf`, and all the modules. 

6. Preparing project to run

Download dependencies needed to run Terraform

```
terraform init
```

Create a `.gitignore``

```
.DS_Strore
*.terraform*
*.tfstate
*.tfstate.*
```

7. Commit changes to source control

```
git checkout -b dbwh
git add main.tf
git add .gitignore
git commit -m "Add Database and Warehouse"
git push origin HEAD
```

 you can simulate the proposed CI/CD job and do a plan to see what Terraform wants to change.

 ```
 terraform plan
 ```

8. Running Terraform

```
terraform apply
```

