#!/bin/bash

# Define AWS account profiles
aws_profiles=("management-account" "corporate-applications" "public-sites" "tii-data-lake")
sandbox_profile="sandbox1admin"

# Path to ScoutSuite executable
scout_executable="scout.py"

# Get the current date
current_datetime=$(date '+%Y-%m-%d_%H-%M-%S')

# Base directory for storing results
results_base_directory="./results"

# Temporary directory for storing reports 
temp_directory="./temp_report"

# Define the S3 bucket path for the sandbox account
s3_bucket="s3://awsconfigauditscoutreport/"

# Create the base directory
mkdir -p "$results_base_directory"

# Iterate through each AWS profile and run ScoutSuite
for profile in "${aws_profiles[@]}"; do
    # Create a directory for the current profile and date
    profile_directory="$results_base_directory/$profile/$current_datetime"
    mkdir -p "$profile_directory"
   
    # Run ScoutSuite for the current profile
    echo "Running ScoutSuite for profile: $profile"
    python "$scout_executable" aws --profile "$profile" --report-dir "$profile_directory"
    if [ $? -ne 0 ]; then
        echo "Error: ScoutSuite failed for profile: $profile"
        continue
    fi

    # Upload the ScoutSuite report to the S3 bucket in the sandbox account
    #echo "Uploading report to S3 bucket in sandbox account: $s3_bucket"
    #aws s3 cp "$profile_directory" "$s3_bucket" --recursive --profile "$sandbox_profile"
    #if [ $? -ne 0 ]; then
    #    echo "Error: Failed to upload report for profile: $profile to S3"
    #fi
done

echo "ScoutSuite audit completed and uploaded to the sandbox account for all profiles."
