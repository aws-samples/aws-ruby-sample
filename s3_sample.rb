#!/usr/bin/env ruby

# Copyright 2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

require 'rubygems'
require 'bundler/setup'
require 'aws-sdk'
require 'uuid'

# Instantiate a new client for Amazon Simple Storage Service (S3). With no
# parameters or configuration, the AWS SDK for Ruby will look for access keys
# and region in these environment variables:
#
#    AWS_ACCESS_KEY_ID='...'
#    AWS_SECRET_ACCESS_KEY='...'
#    AWS_REGION='...'
#
# For more information about this interface to Amazon S3, see:
# http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Resource.html
s3 = Aws::S3::Resource.new(region: 'us-west-2')

# Everything uploaded to Amazon S3 must belong to a bucket. These buckets are
# in the global namespace, and must have a unique name.
#
# For more information about bucket name restrictions, see:
# http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html
uuid = UUID.new
bucket_name = "ruby-sdk-sample-#{uuid.generate}"
bucket = s3.bucket(bucket_name)
bucket.create

# Files in Amazon S3 are called "objects" and are stored in buckets. A specific
# object is referred to by its key (i.e., name) and holds data. Here, we construct
# a reference to a new object with the key "ruby_sample_key.txt" and then
# "put" the object with the body "Hello World!".
#
# For more information on object.put, see:
# http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Object.html#put-instance_method 
object = bucket.object('ruby_sample_key.txt')
object.put(body: "Hello World!")

# Aws::S3::Object#public_url generates an un-authenticated URL for the object.
# 
# See: http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Object.html#public_url-instance_method
puts "Created an object in S3 at:"
puts object.public_url

# Generate a URL for downloading this object without using credentials or
# modifying the object's permissions. This is called a presigned URL.
# 
# See: http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Object.html#presigned_url-instance_method 
puts "\nUse this URL to download the file:"
puts object.presigned_url(:get)

puts "(press any key to delete both the bucket and the object)"
$stdin.getc

# Aws::S3::Bucket#delete! will delete all objects within the bucket and then
# delete the bucket itself. It is equivalent to a #clear! followed by a #delete.
#
# See: http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Bucket.html#delete%21-instance_method 
puts "Deleting bucket #{bucket_name}"
bucket.delete!
