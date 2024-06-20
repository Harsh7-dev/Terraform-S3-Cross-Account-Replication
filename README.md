# Terraform-S3-Cross-Account-Replication

This project sets up cross-account replication for S3 buckets using Terraform.

## Project Structure

The project is organized into the following structure:

```
terraform-project/
├── main.tf
├── variables.tf
├── provider.tf
├── output.tf

```

## Files

- **main.tf**: The main Terraform configuration file that sets up the S3 buckets, versioning, replication configuration, and IAM roles.
- **variables.tf**: Contains the variable definitions for the project.
- **provider.tf**: Configures the AWS providers for source and destination accounts.

## How to Use

1. **Install Terraform**: Make sure you have Terraform installed. You can download it from [Terraform's official website](https://www.terraform.io/downloads.html).

2. **Configure AWS Credentials**:
   - Ensure your AWS credentials are configured. You can do this by setting up the `~/.aws/credentials` and `~/.aws/config` files or by setting the `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and `AWS_DEFAULT_REGION` environment variables for both accounts.
   - Update the `provider.tf` file with the correct paths to your AWS credentials and config files.

3. **Initialize the Terraform Project**:
   - Navigate to the project directory and run:
     ```sh
     terraform init
     ```
     
4. **Provide value for input variable**

5. **Review the Execution Plan**:
   - Run the following command to see what changes Terraform will apply:
     ```sh
     terraform plan
     ```

6. **Apply the Configuration**:
   - To apply the changes and set up the resources, run:
     ```sh
     terraform apply
     ```
   - Confirm the prompt with `yes`.

7. **Clean Up**:
   - To destroy the resources created by this project, run:
     ```sh
     terraform destroy
     ```
   - Confirm the prompt with `yes`.

## Variables

The project includes the following variables defined in `variables.tf`:

- **region**: AWS region (default: "")
- **source_bucket_name**: Name of the source S3 bucket (default: "")
- **replication_role_name**: Name of the replication IAM role (default: "")
- **iam_replication_policy_name**: Name of the IAM replication policy (default: "")
- **destination_bucket_name**: Name of the destination S3 bucket (default: "")

## Outputs

The project outputs the following:

- **source_bucket.bucket_id**: ID of the source S3 bucket
- **source_bucket.bucket_arn**: ARN of the source S3 bucket
- **destination_bucket.bucket_id**: ID of the destination S3 bucket
- **destination_bucket.bucket_arn**: ARN of the destination S3 bucket

## Additional Notes

- Make sure you have the necessary permissions to create and configure the resources in both the source and destination AWS accounts.
- This project assumes that the necessary trust relationships and permissions are in place for cross-account replication.
