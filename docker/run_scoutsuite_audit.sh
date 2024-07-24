#!/bin/bash

# Define AWS account profiles
aws_profiles=("management" "corporate-applications" "public-sites" "tii-data-lake")

# Define the base S3 bucket and path for saving results
s3_bucket="AWSScoutSuiteConfigurationAuditReports"
s3_base_path="ScoutSuiteAudits"

# Path to ScoutSuite executable
scout_executable="scout.py"

# Get the current date
current_datetime=$(date '+%Y-%m-%d_%H-%M-%S')

# Iterate through each AWS profile and run ScoutSuite
for profile in "${aws_profiles[@]}"; do
    # Create a local directory for the current profile and date
    local_profile_directory="./${profile}"
    local_datetime_directory="${local_profile_directory}/${current_datetime}"
    mkdir -p "$local_datetime_directory"

    # Run ScoutSuite for the current profile
    echo "Running ScoutSuite for profile: $profile"
    scout_suite_command="python $scout_executable aws --profile $profile --report-dir $local_datetime_directory"
    eval $scout_suite_command

    # Upload the results to S3
    s3_path="s3://${s3_bucket}/${s3_base_path}/${profile}/${current_datetime}/"
    aws s3 cp --recursive "$local_datetime_directory" "$s3_path"
    
    # Optional: Clean up local directories
    rm -rf "$local_profile_directory"
done

echo "ScoutSuite audit completed for all profiles and results uploaded to S3."
