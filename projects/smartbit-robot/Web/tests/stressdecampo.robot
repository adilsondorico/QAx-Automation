*** Settings ***
Documentation        Cenários de testes de pré-cadastro de clientes

Resource    ../resources/Base.resource
Resource    ../resources/pages/Welcome.resource
Resource    ../resources/pages/components/BoxNotice.resource

Test Setup        Start session
Test Teardown     Take Screenshot
 
*** Test Cases ***
Deve iniciar o cadastro do cliente

    ${account}    Get Fake Account
    
    
    Submit signup form    ${account}
    Verify welcome message

Tentativa de pré-cadastro - Tela de Cadastro de usuário - Stress de Campo
    [Template]    Attempt signup
#Campos     name        email                cpf            output_messagem
            ${EMPTY}    teste@teste.com      00000014141    Por favor informe o seu nome completo
            Fernando    ${EMPTY}             00000014141    Por favor, informe o seu melhor e-mail
            Roberto     teste@teste.com      ${EMPTY}       Por favor, informe o seu CPF
            João        teste&teste.com      00000014141    Oops! O email informado é inválido

*** Keywords ***
Attempt signup
    [Arguments]    ${name}    ${email}    ${cpf}    ${output_message}

    ${account}    Create Dictionary
    ...    name=${name}
    ...    email=${email}
    ...    cpf=${cpf}

   Submit signup form    ${account}
   Notice should be      ${output_message}
 

