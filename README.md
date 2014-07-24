# AWS SDK for Ruby Sample Project

A simple Ruby application illustrating usage of the AWS SDK for Ruby ([aws-sdk gem](http://rubygems.org/gems/aws-sdk)).

## Requirements

The only requirement of this application is [Bundler](http://bundler.io). All other dependencies can be installed with:

    bundle install

You can also install the SDK directly with:

    gem install aws-sdk

## Basic Configuration

You need to set up your AWS security credentials before the sample code is able
to connect to AWS. You can do this by creating a file named "credentials" at ~/.aws/ 
(C:\Users\USER_NAME\.aws\ for Windows users) and saving the following lines in the file:

    [default]
    aws_access_key_id = <your access key id>
    aws_secret_access_key = <your secret key>

See the [Security Credentials](http://aws.amazon.com/security-credentials) page
for more information on getting your keys.

## Running the S3 sample

This sample application connects to Amazon's [Simple Storage Service (S3)](http://aws.amazon.com/s3),
creates a bucket, and uploads a file to that bucket. The `s3_sample.rb` script
will generate a unique bucket name for you as well as an object to upload. All
you need to do is run it:

    ruby s3_sample.rb

The S3 documentation has a good overview of the [restrictions for bucket names](http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html)
for when you start making your own buckets.

## License

This sample application is distributed under the
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

