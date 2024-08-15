*** Settings ***
Library    RequestsLibrary
*** Variables ***
${host}    https://reqres.in
${RUserNotFound}    api/unknown/23

*** Test Cases ***
RUserNotFound
    create session   hostsession    ${host}
    ${response}    get request    hostsession    ${RUserNotFound}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    RUserNotFoundCodeValidation    ${response.status_code}
*** Keywords ***
RUserNotFoundCodeValidation
    [Arguments]    ${code}
    log    ${code}
    run keyword and continue on failure    should be equal as integers    ${code}    404