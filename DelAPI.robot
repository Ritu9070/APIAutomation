*** Settings ***
Library    RequestsLibrary


*** Variables ***
${host}    https://reqres.in
${path}    /api/users/2

*** Test Cases ***
UserRetrive
    create session    ritusession    ${host}
    ${response}=    delete request    ritusession    ${path}
    log     ${response.status_code}
    run keyword and continue on failure    StatusCode_Validation    ${response.status_code}
#    log    ${response.content}
#    run keyword and continue on failure    Content_Validation    ${response.content}

*** Keywords ***
StatusCode_Validation
    [Arguments]    ${statuscode}
    run keyword and continue on failure    should be equal as integers    ${statuscode}    204

Content_Validation
    [Arguments]    ${rawdata}
    log    ${rawdata}
    ${json}=    evaluate    json.loads('''${rawdata}''')
    log    ${json}
#    run keyword and continue on failure    should be equal as integers    ${json['data']['id']}    2
#    run keyword and continue on failure    should be equal as strings    ${json['data']['first_name']}    Janet
#    run keyword and continue on failure    should be equal as strings    ${json['data']['email']}    janet.weaver@reqres.in
#    run keyword and continue on failure    should be equal as strings    ${json['data']['last_name']}    Weaver
#    run keyword and continue on failure    should be equal as strings    ${json['support']['text']}    To keep ReqRes free, contributions towards server costs are appreciated!
