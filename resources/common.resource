*** Settings ***
Documentation    Shared keywords and imports used across test suites.
...              Import this file from a suite with:  Resource    common.resource

Library          Collections
Library          OperatingSystem
Library          String


*** Variables ***
${DEFAULT_TIMEOUT}    10 seconds


*** Keywords ***
Log Environment Banner
    [Documentation]    Prints basic run context. Handy in a suite setup.
    Log To Console    \nRobot Framework project - starting suite
    ${python}=    Evaluate    sys.version    modules=sys
    Log    Python: ${python}

Numbers Should Be Equal
    [Documentation]    Assert two values are numerically equal regardless of type.
    [Arguments]    ${actual}    ${expected}
    ${a}=    Convert To Number    ${actual}
    ${e}=    Convert To Number    ${expected}
    Should Be Equal As Numbers    ${a}    ${e}
