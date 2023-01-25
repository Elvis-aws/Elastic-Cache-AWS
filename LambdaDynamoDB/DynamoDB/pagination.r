


******************************
Paginating table query results
******************************
    DynamoDB paginates the results from Query operations. With pagination, the Query results are divided into "pages" 
    of data that are 1 MB in size (or less). An application can process the first page of results, then the second 
    page, and so on.
"""
aws dynamodb query --table-name Movies \
    --projection-expression "title" \
    --key-condition-expression "#y = :yyyy" \
    --expression-attribute-names '{"#y":"year"}' \
    --expression-attribute-values '{":yyyy":{"N":"1993"}}' \
    --page-size 5 \
    --debug
"""
    # --no-paginate parameter
    # The --no-paginate option disables following pagination tokens on the client side.
    # if you run aws s3api list-objects on an Amazon S3 bucket that contains 3,500 objects, the AWS CLI only makes
    # the first call to Amazon S3, returning only the first 1,000 objects in the final output.
"""
aws s3api list-objects \
    --bucket my-bucket \
    --no-paginate
"""
    # --page-size parameter
    # If you see issues when running list commands on a large number of resources, the default page size might be too
    # high. This can cause calls to AWS services to exceed the maximum allowed time and generate a "timed out" error.
    # You can use the --page-size option to specify that the AWS CLI request a smaller number of items from each call
    # to the AWS service. The AWS CLI still retrieves the full list, but performs a larger number of service API calls
    # in the background and retrieves a smaller number of items with each call. This gives the individual calls a better
    # chance of succeeding without a timeout. Changing the page size doesn't affect the output; it affects only the
    # number of API calls that need to be made to generate the output.
"""
aws s3api list-objects \
    --bucket my-bucket \
    --page-size 100
"""
    # --max-items parameter
    # To include fewer items at a time in the AWS CLI output, use the --max-items option. The AWS CLI still handles
       pagination with the service as described previously, but prints out only the number of items at a time that
       you specify.
"""
aws s3api list-objects \
    --bucket my-bucket \
    --max-items 100
"""
    # --starting-token parameter
    # If the number of items output (--max-items) is fewer than the total number of items returned by the underlying
      API calls, the output includes a NextToken that you can pass to a subsequent command to retrieve the next
      set of items.
"""
aws s3api list-objects \
    --bucket my-bucket \
    --max-items 100 \
    --starting-token eyJNYXJrZXIiOiBudWxsLCAiYm90b190cnVuY2F0ZV9hbW91bnQiOiAxfQ==
"""