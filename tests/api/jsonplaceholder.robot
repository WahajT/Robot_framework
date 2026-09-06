*** Settings ***
Documentation    REST API example using RequestsLibrary against a public test API.
...              Requires network access. Run just this suite with:  robot --include api tests/

Library          Collections
Library          RequestsLibrary
Variables        environments.py

Suite Setup      Create Session    api    ${BASE_URL}    verify=${True}

Test Tags        api


*** Test Cases ***
Get A Single Post
    ${response}=    GET On Session    api    /posts/1
    Status Should Be    200    ${response}
    Should Be Equal As Integers    ${response.json()}[id]    1

List Posts Returns A Collection
    ${response}=    GET On Session    api    /posts
    Status Should Be    200    ${response}
    Length Should Be    ${response.json()}    100

Create A Post
    ${payload}=    Create Dictionary    title=hello    body=world    userId=${1}
    ${response}=    POST On Session    api    /posts    json=${payload}
    Status Should Be    201    ${response}
    Should Be Equal    ${response.json()}[title]    hello
