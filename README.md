# Docker container for load testing websites
This will run a load test with env variables of url(https://www.example.com), users(5), and length(60s).  Results are available in a /testResults/loadResults folder.

# Pass/Fail criteria:
average response time under load of under 10s for 10s
any 400 error codes
any 500 error codes
100% success responses


# Step 1 : pull/start container
docker run -e env={APIURL} -e users=5 -e length=1m -e token={APITOKEN} -v $(pwd)/testResults/loadResults:/results --rm -it aptoadmin/load:latest

