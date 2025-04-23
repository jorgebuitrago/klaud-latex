import boto3
import subprocess
import os

s3 = boto3.client("s3")

def lambda_handler(event, context):
    bucket = event["bucket"]
    tex_key = event["tex_key"]
    output_key = event.get("output_key", "output.pdf")

    local_tex = "/tmp/input.tex"
    local_pdf = "/tmp/input.pdf"

    # Download .tex from S3
    s3.download_file(bucket, tex_key, local_tex)

    # Compile with pdflatex
    result = subprocess.run(["pdflatex", "-output-directory", "/tmp", local_tex], capture_output=True)

    if result.returncode != 0:
        return {
            "statusCode": 500,
            "body": result.stderr.decode()
        }

    # Upload resulting PDF to S3
    s3.upload_file(local_pdf, bucket, output_key)

    return {
        "statusCode": 200,
        "body": f"Compiled PDF uploaded to s3://{bucket}/{output_key}"
    }
