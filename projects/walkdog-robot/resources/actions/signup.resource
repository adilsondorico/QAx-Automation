*** Settings ***
Documentation        Ações , steps e elementos da funcionalidade de cadastro

Library        Browser

*** Keywords ***
Go to signup page
    [Arguments]    ${expected_title}
    #New Browser    browser=chromium                      # Abrindo o browser/execução em background#
    #New Browser    browser=chromium    headless=False    # Abrindo o browser/execução assitida#
    #New Page    https://walkdog.vercel.app/signup        # Acessando a página #
    #Go To    https://walkdog.vercel.app/signup           # Acessando a página #
    Click    css=a[href="/signup"]                        # Página home #

    Wait For Elements State    form h1    visible    3    # Validando se está na tela correta/Aguardando algum elemento #    
    Get Text    form h1    equal    ${expected_title}    # Validando se está na tela correta #
    

Fill signup Form
    [Arguments]    ${dog_walker}
    Fill Text    css=input[name=name]             ${dog_walker}[name]
    Fill Text    css=input[name=email]            ${dog_walker}[email]
    Fill Text    css=input[name=cpf]              ${dog_walker}[cpf]
    Fill Text    css=input[name=cep]              ${dog_walker}[cep]

    Click        css=input[type=Button][value="Buscar CEP"]

    Sleep    3
        
    Get Property    css=input[name=addressStreet]    value    equal    ${dog_walker}[addressStreet]    # Validando valor do campo #
    Get Property    css=input[name=addressDistrict]  value    equal    ${dog_walker}[addressDistrict]  # Validando valor do campo #
    Get Property    css=input[name=addressCityUf]    value    equal    ${dog_walker}[addressCityUf]    # Validando valor do campo #

    Fill Text    css=input[name=addressNumber]    ${dog_walker}[addressNumber]
    Fill Text    css=input[name=addressDetails]   ${dog_walker}[addressDetails]
    
    

    Upload File By Selector    css=input[type=file]    ${EXECDIR}/resources/fixtures/${dog_walker}[CNH]    # Upload de Arquivos #

    Sleep    5

Additional Service
    [Arguments]    ${additional_service}

    Click        xpath=//span[text()="${additional_service}"]/..
    Take Screenshot    selector=//span[text()="${additional_service}"]/..




Submit signup form
    Click    css=.button-register

Popup should be
    [Arguments]    ${expected_text}
    Wait For Elements State     css=.swal2-html-container    visible    5    # Aguardando algum elemento aparecer na tela #
    Get Text                    css=.swal2-html-container    equal    ${expected_text}    # Validando mensagem de popup #

Alert should be
    [Arguments]        ${expected_text_error}
    Wait For Elements State     css=.alert-error >> text=${expected_text_error}    # Validando mensagem de erro na tela #
    ...    visible    5
    