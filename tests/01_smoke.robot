*** Settings ***
Documentation    Smoke suite with no external dependencies.
...              Verifies the toolchain, resource files and custom library all load.

Resource         common.resource
Library          CustomLibrary

Suite Setup      Log Environment Banner

Test Tags        smoke


*** Test Cases ***
Framework Is Installed
    ${version}=    Evaluate    robot.version.VERSION    modules=robot
    Should Not Be Empty    ${version}
    Log    Running on Robot Framework ${version}

Shared Keyword Works
    Numbers Should Be Equal    2    2.0

Custom Library Keyword Works
    ${reversed}=    Reverse String    Robot
    Should Be Equal    ${reversed}    toboR

Palindrome Check
    Should Be Palindrome    A man, a plan, a canal: Panama
