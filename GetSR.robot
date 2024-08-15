*** Settings ***
Library    RequestsLibrary

*** Variables ***

${host}    https://reqres.in
${GetSRPath}    api/unknown/2

*** Test Cases ***
SRUserGet
    create session   hostsession    ${host}
    ${response}    get request    hostsession    ${GetSRPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    GetSRCodeValidation    ${response.status_code}
    run keyword and continue on failure    GetSRContentValidation    ${response.content}
*** Keywords ***
GetSRCodeValidation
    [Arguments]    ${code}
    log    ${code}
    run keyword and continue on failure    should be equal as integers    ${code}    200
GetSRContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['data']['id']}    2
    run keyword and continue on failure    should be equal as strings    ${json['data']['name']}    fuchsia rose
    run keyword and continue on failure    should match regexp    ${json['data']['pantone_value']}    [0-9]

