*** Settings ***
Documentation        Testes adesões de planos

Resource        ../resources/Base.resource
Resource    ../resources/pages/components/Modal.resource

Test Setup       Start session
Test Teardown    Take Screenshot
Library    XML

*** Test Cases ***
Deve poder realizar uma nova adesão

    ${data}    Get Json fixture    memberships    create

    Delete Account By Email    ${data}[account][email]
    Insert Account             ${data}[account]
    
    SignIn admin
    Go To memberships
    Create new membership    ${data}
    Toast should be    Matrícula cadastrada com sucesso.

Não deve cadastrar adesão duplicada
    [Tags]    dup
    
    ${data}    Get Json fixture    memberships    duplicate

    Insert Membership    ${data}
 
    SignIn admin
    Go To memberships
    Create new membership    ${data}
    Toast should be    O usuário já possui matrícula.

Deve buscar por nome
    [Tags]    search
    ${data}    Get Json fixture    memberships    search

    Insert Membership    ${data}

    SignIn admin
    Go To memberships
    Search by name           ${data}[account][name]
    Should filter by name    ${data}[account][name]


Deve excluir a conta
    [Tags]    remove
    ${data}    Get Json fixture    memberships    remove

    Insert Membership    ${data}

    SignIn admin
    Go To memberships
    Request removal    ${data}[account][name]
    Confirm removal
    Membership should not be visible    ${data}[account][name]
    

 