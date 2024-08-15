*** Settings ***
Library    RequestsLibrary

*** Variables ***
${host}    https://reqres.in
${path}    /api/users/2

*** Test Cases ***
UserRemovefrormSer
    create session    removesession    ${host}
    ${response}=    delete request    removesession    ${path}
    log     ${response}

*** Keywords ***