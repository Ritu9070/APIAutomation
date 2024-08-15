*** Settings ***
Library    RequestsLibrary

*** Variables ***

${host}    https://reqres.in
${GetListPath}    api/users?page=2

*** Test Cases ***
ListUserGet
    create session   hostsession    ${host}
    ${response}    get request    hostsession    ${GetListPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    GetLCodeValidation    ${response.status_code}
    run keyword and continue on failure    GetLContentValidation    ${response.content}
*** Keywords ***
GetLCodeValidation
    [Arguments]    ${code}
    log    ${code}
    run keyword and continue on failure    should be equal as integers    ${code}    200
GetLContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['page']}    2
    run keyword and continue on failure    should be equal as integers    ${json['data'][0]['id']}    7
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['email']}    michael.lawson@reqres.in
