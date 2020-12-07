# salesforce-api-tests
Salesforce API tests

[![Build Status](https://travis-ci.com/AT-12/salesforce-api-tests.svg?branch=develop)](https://travis-ci.com/AT-12/salesforce-api-tests) 

[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=AT-12_salesforce-api-tests&metric=alert_status)](https://sonarcloud.io/dashboard/index/AT-12_salesforce-api-tests)

# Description
This is the AT-12's project, it was made on API Testing subject. 
The proposal of this project is to implement Web API testing applying BDD with Gherkin.  
# Environment setup
Create an account on https://www.salesforce.com and set the following variables on gradle.properties.
- set baseUrl = /services/data/v49.0/sobjects/
- set baseLoginUrl = https://login.salesforce.com/
- set clientId = (your client ID)
- set clientSecret = (your client ClientSecret)
- set grantType = (your Grand type)
- set username = (your username)
- set password = (your password)
- set schemasPath = src/test/resources/schemas/
- set filterTags = 
- set cucumberThreadCount = (the number of threads)

# Execute tests
In order to execute the tests there are the followings commands:

- gradle check
- gradle checkstyleMain
- gradle test
- gradle executeBDDTests
- gradle reExecuteBDDTests
# Endpoints tested
The endpoints tested are:
- GET /Account/{id}
- POST /Account
- DELETE /Account/{id} 
- PATCH /Account/{id}
- GET /Campaign/{id}
- POST /Campaign
- DELETE /Campaign/{id} 
- PATCH /Campaign/{id}