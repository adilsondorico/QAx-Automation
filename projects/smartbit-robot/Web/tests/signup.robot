*** Settings ***
Documentation        Cenários de testes de pré-cadastro de clientes

Resource    ../resources/Base.resource


Test Setup        Start session
Test Teardown     Take Screenshot
 
*** Test Cases ***
Deve iniciar o cadastro do cliente
    [Tags]    smoke
    
    #Massa de testes criada automaticamente
    #${account}    Get Fake Account

    ${account}    Create Dictionary
    ...    name=teste
    ...    email=teste@teste.com
    ...    cpf=86390851022

    Delete Account By Email    ${account}[email]
    Submit signup form    ${account}
    Verify welcome message


Validar os campos obrigatórios nome
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=teste@teste.com
    ...    cpf=00000014141

   Submit signup form    ${account}
   Notice should be    Por favor informe o seu nome completo

Validar os campos obrigatórios e-mail
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=abc
    ...    email=${EMPTY}
    ...    cpf=00000014141    

    Submit signup form    ${account}
    Notice should be    Por favor, informe o seu melhor e-mail

Validar os campos obrigatórios CPF
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=abc
    ...    email=teste@teste.com
    ...    cpf=${EMPTY}

    Submit signup form    ${account}
    Notice should be    Por favor, informe o seu CPF

Email inválido
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=abc
    ...    email=teste&teste.com
    ...    cpf=00000044141

   Submit signup form    ${account}
   Notice should be    Oops! O email informado é inválido


CPF inválido
    [Tags]    required

    ${account}    Create Dictionary
    ...    name=abc
    ...    email=teste@teste.com
    ...    cpf=0000004414a

   Submit signup form    ${account}
   Notice should be    Oops! O CPF informado é inválido



