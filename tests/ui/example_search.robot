*** Settings ***
Documentation     Web UI example using SeleniumLibrary.
...               Requires a real browser (Chrome or Firefox). Selenium Manager
...               fetches the matching driver automatically on first run.
...               Run just this suite with:  robot --include ui tests/

Library           SeleniumLibrary
Variables         environments.py

Suite Setup       Open Browser    https://example.com    ${BROWSER}
Suite Teardown    Close All Browsers

Test Tags         ui


*** Test Cases ***
Home Page Has Expected Title
    Title Should Be    Example Domain

Page Has A Top-Level Heading
    Element Text Should Be    css:h1    Example Domain

Body Mentions Documentation Examples
    Page Should Contain    documentation examples

Page Exposes An Outbound Link
    Page Should Contain Element    css:a[href]
