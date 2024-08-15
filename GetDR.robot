*** Settings ***
Library    RequestsLibrary

*** Variables ***

${host}    https://reqres.in
${GetDRPath}  api/users?delay=3

*** Test Cases ***
DRUserGet
    create session   hostsession    ${host}
    ${response}    get request    hostsession    ${GetDRPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    GetDRCodeValidation    ${response.status_code}
    run keyword and continue on failure    GetDRContentValidation    ${response.content}
*** Keywords ***
GetDRCodeValidation
    [Arguments]    ${code}
    log    ${code}
    run keyword and continue on failure    should be equal as integers    ${code}    200
GetDRContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['page']}    1
    run keyword and continue on failure    should be equal as integers    ${json['data'][0]['id']}    1
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['email']}    george.bluth@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['avatar']}    https://reqres.in/img/faces/2-image.jpg

