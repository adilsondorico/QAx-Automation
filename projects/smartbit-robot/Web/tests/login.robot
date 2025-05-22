*** Settings ***

Documentation        Cenários de testes do Login SAC

Library    Browser

Resource    ../resources/Base.resource
Resource    ../resources/pages/components/BoxNotice.resource
Resource    ../resources/pages/Landing.resource

Test Setup        Start session
Test Teardown     Take Screenshot    

*** Test Cases ***
Deve logar como Gestor de Academia

    Go to login page
    Submit login form    sac@smartbit.com    pwd123
    User is logged in    sac@smartbit.com

Não deve logar com senha incorreta
    [Tags]    inv_pass
    Go to login page
    Submit login form    sac@smartbit.com    132abc
    Toast should be      As credenciais de acesso fornecidas são inválidas. Tente novamente!

Não deve logar com email não cadastrado
    [Tags]    inv_email
    Go to login page
    Submit login form    404@smartbit.com    pwd123
    Toast should be      As credenciais de acesso fornecidas são inválidas. Tente novamente!


Tentativa de login com dados incorretos
    [Template]    Login with verify notice

#Campos email           senha   
        ${EMPTY}        ${EMPTY}    Os campos email e senha são obrigatórios.
        ${EMPTY}        pwd123      Os campos email e senha são obrigatórios.
        sac@smartbit    ${EMPTY}    Os campos email e senha são obrigatórios.
        www.teste.com   pwd123      Oops! O email informado é inválido



*** Keywords ***
Login with verify notice
    [Arguments]        ${email}    ${password}    ${output_message}

    Go to login page
    Submit login form    ${email}    ${password}
    Notice should be     ${output_message}

