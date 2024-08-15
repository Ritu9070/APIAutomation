*** Settings ***
Library    RequestsLibrary
Suite Setup    hostsession
Suite Teardown    Custom_Teardown
*** Variables ***
${host/server}    https://reqres.in
${GetSinglePath}     api/users/2
${GetListPath}    api/users?page=2
${UserNotFound}    api/users/23
${GetSRPath}    api/unknown/2
${GetLRPath}    api/unknown
${RUserNotFound}    api/unknown/23
${GetDRPath}  api/users?delay=3
${DeletePath}    api/users/2
${PostCreate}    api/users
${PostRS}    api/register
${PostRU}    api/register
${PostLS}    api/login
${PostLU}    api/login
${PutPath}    api/users/2
${PatchPath}    api/users/2

*** Test Cases ***
SingleUserGet
#    create session   hostsession    ${host/server}
    ${response}     get request    hostsession    ${GetSinglePath}
    log    ${response.status_code}
    log  ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    200
    run keyword and continue on failure    GetSContentValidation    ${response.content}
ListUserGet
#    create session   hostsession    ${host/server}
    ${response}    get request    hostsession    ${GetListPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    200
    run keyword and continue on failure    GetLContentValidation    ${response.content}
UserNotFound
#    create session   hostsession    ${host/server}
    ${response}     get request    hostsession    ${UserNotFound}
    log    ${response.status_code}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    404
SRUserGet
#    create session   hostsession    ${host/server}
    ${response}    get request    hostsession    ${GetSRPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    200
    run keyword and continue on failure    GetSRContentValidation    ${response.content}
LRUserGet
#    create session   hostsession    ${host/server}
    ${response}    get request    hostsession    ${GetLRPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    200
    run keyword and continue on failure    GetLRContentValidation    ${response.content}
RUserNotFound
#    create session   hostsession    ${host/server}
    ${response}    get request    hostsession    ${RUserNotFound}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    404
DRUserGet
#    create session   hostsession    ${host/server}
    ${response}    get request    hostsession    ${GetDRPath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    200
    run keyword and continue on failure    GetDRContentValidation    ${response.content}

DeleteUser
#    create session    hostsession    ${host/server}
    ${response}    delete request    hostsession    ${DeletePath}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    204
PostCreateUser
#    create session    hostsession    ${host/server}
    ${body}    create dictionary    name=morpheus    job=leader
    ${header}    create dictionary    Content-Type=application/json
    ${response}    post request    hostsession    ${PostCreate} data=${body}    headers=${header}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    201
    run keyword and continue on failure    PostCUContantValidation    ${response.content}
PostRSUser
#    create session    hostsession    ${host/server}
    ${body}    create dictionary    email=eve.holt@reqres.in    password=pistol
    ${header}    create dictionary    Content-Type=application/json
    ${response}    post request    hostsession    ${PostRS}} data=${body}    headers=${header}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    201
    run keyword and continue on failure    PostRSContantValidation    ${response.content}
PostRUUser
#    create session    hostsession    ${host/server}
    ${body}    create dictionary    email=sydney@fife
    ${header}    create dictionary    Content-Type=application/json
    ${response}    post request    hostsession    ${PostRU}} data=${body}    headers=${header}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    201
    run keyword and continue on failure    PostRUContantValidation    ${response.content}
PostLSUser
#    create session    hostsession    ${host/server}
    ${body}    create dictionary    email=eve.holt@reqres.in    password=cityslicka
    ${header}    create dictionary    Content-Type=application/json
    ${response}    post request    hostsession    ${PostLS}} data=${body}    headers=${header}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    201
    run keyword and continue on failure    PostLSContantValidation    ${response.content}
PostLUUser
#    create session    hostsession    ${host/server}
    ${body}    create dictionary    email=peter@klaven
    ${header}    create dictionary    Content-Type=application/json
    ${response}    post request    hostsession    ${PostLU}} data=${body}    headers=${header}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    201
    run keyword and continue on failure    PostLUContantValidation    ${response.content}
PutUpdate
#    create session    hostsession    ${host/server}
    ${body}    create dictionary    name=morpheus    job=zion resident
    ${header}    create dictionary    Content-Type=application/json
    ${response}    put request    hostsession    ${PutPath} data=${body}    headers=${header}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    200
    run keyword and continue on failure    PutUpdateContantValidation    ${response.content}
PatchUpdate
#    create session    hostsession    ${host/server}
    ${body}    create dictionary    name=morpheus    job=zion resident
    ${header}    create dictionary    Content-Type=application/json
    ${response}    put request    hostsession    ${PatchPath} data=${body}    headers=${header}
    log    ${response.status_code}
    log    ${response.content}
    run keyword and continue on failure    CodeValidation    ${response.status_code}    200
    run keyword and continue on failure    PatchUpdateContantValidation    ${response.content}

*** Keywords ***
CodeValidation
    [Arguments]    ${code}    ${newcode}
    log    ${code}
    run keyword and continue on failure    should be equal as integers    ${code}    ${newcode}
GetSContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    log    ${json}
    run keyword and continue on failure    should be equal as integers    ${json['data']['id']}    2
    run keyword and continue on failure    should be equal as strings    ${json['data']['email']}    janet.weaver@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data']['first_name']}    Janet
    run keyword and continue on failure    should be equal as strings    ${json['data']['last_name']}    Weaver
    run keyword and continue on failure    should be equal as strings    ${json['data']['avatar']}    https://reqres.in/img/faces/2-image.jpg
    run keyword and continue on failure    should be equal as strings    ${json['support']['text']}    To keep ReqRes free, contributions towards server costs are appreciated!
    run keyword and continue on failure    should be equal as strings    ${json['support']['url']}    https://reqres.in/#support-heading

GetLContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['page']}    2
    run keyword and continue on failure    should be equal as integers    ${json['per_page']}    6
    run keyword and continue on failure    should be equal as integers    ${json['total']}    12
    run keyword and continue on failure    should be equal as integers    ${json['total_pages']}    2

    run keyword and continue on failure    should be equal as integers    ${json['data'][0]['id']}    7
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['email']}    michael.lawson@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['first_name']}    Michael
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['last_name']}    Lawson
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['avatar']}    https://reqres.in/img/faces/7-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][1]['id']}    8
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['email']}    lindsay.ferguson@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['first_name']}    Lindsay
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['last_name']}    Ferguson
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['avatar']}    https://reqres.in/img/faces/8-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][2]['id']}    9
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['email']}    tobias.funke@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['first_name']}    Tobias
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['last_name']}    Funke
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['avatar']}    https://reqres.in/img/faces/9-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][3]['id']}    10
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['email']}    byron.fields@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['first_name']}    Byron
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['last_name']}    Fields
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['avatar']}    https://reqres.in/img/faces/10-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][4]['id']}    11
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['email']}    george.edwards@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['first_name']}    George
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['last_name']}    Edwards
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['avatar']}    https://reqres.in/img/faces/11-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][5]['id']}    12
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['email']}    rachel.howell@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['first_name']}    Rachel
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['last_name']}    Howell
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['avatar']}    https://reqres.in/img/faces/12-image.jpg

    run keyword and continue on failure    should be equal as strings    ${json['support']['url']}    https://reqres.in/#support-heading
    run keyword and continue on failure    should be equal as strings    ${json['support']['text']}    To keep ReqRes free, contributions towards server costs are appreciated!
#GetSRCodeValidation
#    [Arguments]    ${code}
#    log    ${code}
#    run keyword and continue on failure    should be equal as integers    ${code}    200
GetSRContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['data']['id']}    2
    run keyword and continue on failure    should be equal as strings    ${json['data']['name']}    fuchsia rose
    run keyword and continue on failure    should be equal as integers    ${json['data']['year']}    2001
    run keyword and continue on failure    should match regexp    ${json['data']['color']}    [#a-zA-Z0-9]
    run keyword and continue on failure    should match regexp    ${json['data']['pantone_value']}    [#a-zA-Z0-9]
    run keyword and continue on failure    should be equal as strings     ${json['support']['url']}    https://reqres.in/#support-heading
    run keyword and continue on failure    should be equal as strings    ${json['support']['text']}    To keep ReqRes free, contributions towards server costs are appreciated!

#GetLRCodeValidation
#    [Arguments]    ${code}
#    log    ${code}
#    run keyword and continue on failure    should be equal as integers    ${code}    200
GetLRContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['page']}    1
    run keyword and continue on failure    should be equal as integers    ${json['per_page']}    6
    run keyword and continue on failure    should be equal as integers    ${json['total']}    12
    run keyword and continue on failure    should be equal as integers    ${json['total_pages']}    2

    run keyword and continue on failure    should be equal as integers    ${json['data'][0]['id']}    1
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['name']}    cerulean
    run keyword and continue on failure    should be equal as integers    ${json['data'][0]['year']}    2000
    run keyword and continue on failure    should match regexp    ${json['data'][0]['color']}    [#a-zA-z0-9]
    run keyword and continue on failure    should match regexp    ${json['data'][0]['pantone_value']}    [#a-zA-z0-9]

    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['id']}    2
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['name']}    fuchsia rose
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['year']}    2001
    run keyword and continue on failure    should match regexp    ${json['data'][1]['color']}  [#a-zA-Z0-9]
    run keyword and continue on failure    should match regexp    ${json['data'][1]['pantone_value']}  [#a-zA-Z0-9]

    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['id']}    3
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['name']}    true red
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['year']}    2002
    run keyword and continue on failure    should match regexp    ${json['data'][2]['color']}  [#a-zA-Z0-9]
    run keyword and continue on failure    should match regexp    ${json['data'][2]['pantone_value']}  [#a-zA-Z0-9]

    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['id']}    4
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['name']}    aqua sky
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['year']}    2003
    run keyword and continue on failure    should match regexp    ${json['data'][3]['color']}  [#a-zA-Z0-9]
    run keyword and continue on failure    should match regexp    ${json['data'][3]['pantone_value']}  [#a-zA-Z0-9]

    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['id']}    5
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['name']}    tigerlily
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['year']}    2004
    run keyword and continue on failure    should match regexp    ${json['data'][4]['color']}  [#a-zA-Z0-9]
    run keyword and continue on failure    should match regexp    ${json['data'][4]['pantone_value']}  [#a-zA-Z0-9]

    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['id']}    6
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['name']}    blue turquoise
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['year']}    2005
    run keyword and continue on failure    should match regexp    ${json['data'][5]['color']}  [#a-zA-Z0-9]
    run keyword and continue on failure    should match regexp    ${json['data'][5]['pantone_value']}  [#a-zA-Z0-9]

    run keyword and continue on failure    should be equal as strings    ${json['support']['url']}    https://reqres.in/#support-heading
    run keyword and continue on failure    should be equal as strings    ${json['support']['text']}    To keep ReqRes free, contributions towards server costs are appreciated!

#RUserNotFoundCodeValidation
#    [Arguments]    ${code}
#    log    ${code}
#    run keyword and continue on failure    should be equal as integers    ${code}    404
#GetDRCodeValidation
#    [Arguments]    ${code}
#    log    ${code}
#    run keyword and continue on failure    should be equal as integers    ${code}    200
GetDRContentValidation
    [Arguments]    ${data}
    log    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should be equal as integers    ${json['page']}    1
    run keyword and continue on failure    should be equal as integers    ${json['per_page']}    6
    run keyword and continue on failure    should be equal as integers    ${json['total']}    12
    run keyword and continue on failure    should be equal as integers    ${json['total_pages']}    2

    run keyword and continue on failure    should be equal as integers    ${json['data'][0]['id']}    1
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['email']}    george.bluth@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['first_name']}    George
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['last_name']}    Bluth
    run keyword and continue on failure    should be equal as strings    ${json['data'][0]['avatar']}    https://reqres.in/img/faces/1-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][1]['id']}    2
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['email']}    janet.weaver@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['first_name']}    Janet
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['last_name']}    Weaver
    run keyword and continue on failure    should be equal as strings    ${json['data'][1]['avatar']}    https://reqres.in/img/faces/2-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][2]['id']}    3
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['email']}    emma.wong@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['first_name']}    Emma
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['last_name']}    Wong
    run keyword and continue on failure    should be equal as strings    ${json['data'][2]['avatar']}    https://reqres.in/img/faces/3-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][3]['id']}    4
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['email']}    eve.holt@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['first_name']}    Eve
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['last_name']}    Holt
    run keyword and continue on failure    should be equal as strings    ${json['data'][3]['avatar']}    https://reqres.in/img/faces/4-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][4]['id']}    5
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['email']}    charles.morris@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['first_name']}    Charles
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['last_name']}    Morris
    run keyword and continue on failure    should be equal as strings    ${json['data'][4]['avatar']}    https://reqres.in/img/faces/5-image.jpg

    run keyword and continue on failure    should be equal as integers    ${json['data'][5]['id']}    6
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['email']}    tracey.ramos@reqres.in
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['first_name']}    Tracey
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['last_name']}    Ramos
    run keyword and continue on failure    should be equal as strings    ${json['data'][5]['avatar']}    https://reqres.in/img/faces/6-image.jpg

    run keyword and continue on failure    should be equal as strings    ${json['support']['url']}    https://reqres.in/#support-heading
    run keyword and continue on failure    should be equal as strings    ${json['support']['text']}    To keep ReqRes free, contributions towards server costs are appreciated!
PostCUContantValidation
    [Arguments]    ${data}
    log    ${data}
    ${newdata}=    convert to string    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should match regexp    ${json['id']}  [0-9]
    run keyword and continue on failure    should match regexp    ${json['createdAt']}    [A-Z0-9:.]
PostRSContantValidation
    [Arguments]    ${data}
    log    ${data}
    ${newdata}=    convert to string    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should match regexp    ${json['id']}    [0-9]
    run keyword and continue on failure    should match regexp    ${json['createdAt']}    [a-zA-Z0-9:.]
PostRUContantValidation
    [Arguments]    ${data}
    log    ${data}
    ${newdata}=    convert to string    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should match regexp    ${json['id']}    [0-9]
    run keyword and continue on failure    should match regexp    ${json['createdAt']}    [a-zA-Z0-9:.]
PostLSContantValidation
    [Arguments]    ${data}
    log    ${data}
    ${newdata}=    convert to string    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should match regexp    ${json['id']}    [0-9]
    run keyword and continue on failure    should match regexp    ${json['createdAt']}    [a-zA-Z0-9:.]
PostLUContantValidation
    [Arguments]    ${data}
    log    ${data}
    ${newdata}=    convert to string    ${data}
    ${json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should match regexp    ${json['id']}    [0-9]
    run keyword and continue on failure    should match regexp    ${json['createdAt']}    [a-zA-Z0-9:.]
PutUpdateContantValidation
    [Arguments]    ${data}
    log    ${data}
    ${newdata}=    convert to string    ${data}
    ${Json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should match regexp    ${json['updatedAt']}    [a-zA-Z0-9:.]
PatchUpdateContantValidation
    [Arguments]    ${data}
    log    ${data}
    ${newdata}=    convert to string    ${data}
    ${Json}=    evaluate    json.loads('''${data}''')
    run keyword and continue on failure    should match regexp    ${json['updatedAt']}    [a-zA-Z0-9:.]
hostsession
    create session    hostsession    ${host/server}
Custom_Teardown
    Delete All Sessions