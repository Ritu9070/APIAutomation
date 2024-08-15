*** Settings ***
Library    RequestsLibrary

*** Variables ***

${host}    https://reqres.in
${GetLRPath}    api/unknown

*** Test Cases ***
LRUserGet
    create session   hostsession    ${host}
    ${response}    get request    hostsession    ${GetLRPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    GetLRCodeValidation    ${response.status_code}
    run keyword and continue on failure    GetLRContentValidation    ${response.content}
*** Keywords ***
GetLRCodeValidation
    [Arguments]    ${code}
    log    ${code}
    run keyword and continue on failure    should be equal as integers    ${code}    200
GetLRContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['page']}    1
    run keyword and continue on failure    should be equal as integers    ${json['data'][0]['id']}    1
    run keyword and continue on failure    should match regexp    ${json['data'][1]['color']}  [#a-zA-Z0-9]
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['year']}    2001
