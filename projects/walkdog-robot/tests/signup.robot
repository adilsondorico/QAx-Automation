*** Settings ***
Documentation    Suite de testes de cadastro de dog walker
# Comando para rodar todos os testes    $ robot -d ./logs/ tests/signup.robot
# Comando para testar apenas um ou mais cenários    $ robot -d ./logs/ -i aservice tests/signup.robot
# "aservice" é a TAG abaixo do nome do caso de teste. É um identificador do caso de testes
# ${dog_walker} - Super variavel ou dicionário de dados que viabiliza/habilita a massa de testes
# "dog_walker" é só um nime dado para a massa de dados

Resource    ../resources/base.resource

Test Setup    Start session
Test Teardown    Finish session

*** Test Cases ***
Deve poder cadastrar um novo dog walker

    ${dog_walker}    Create Dictionary
    #(massa de testes)
    ...    name=passeador
    ...    email=passeador@gmail.com
    ...    cpf=00000014141
    ...    cep=04534011
    ...    addressStreet=Rua Joaquim Floriano
    ...    addressDistrict=Itaim Bibi
    ...    addressCityUf=São Paulo/SP
    ...    addressNumber=123
    ...    addressDetails=123abc
    ...    CNH=toretto.jpg


    #Steps
    Go to signup page    Faça seu cadastro
    Fill signup Form    ${dog_walker}
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.


CPF incorreto
    [Tags]    cpf_inv

    ${dog_walker}    Create Dictionary
    #(massa de testes)
    ...    name=passeador
    ...    email=passeador@gmail.com
    ...    cpf=000000141aa
    ...    cep=04534011
    ...    addressStreet=Rua Joaquim Floriano
    ...    addressDistrict=Itaim Bibi
    ...    addressCityUf=São Paulo/SP
    ...    addressNumber=123
    ...    addressDetails=123abc
    ...    CNH=toretto.jpg


    #Steps
    Go to signup page    Faça seu cadastro
    Fill signup Form    ${dog_walker}
    Submit signup form
    Alert should be    CPF inválido


Obrigatoriedade de preenchimento
    [Tags]    required
    
    #Steps
    Go to signup page    Faça seu cadastro
    Submit signup form
    #Validando mensagem com o mesmo identificados para mais de um campo
    Alert should be    Informe o seu nome completo
    Alert should be    Informe o seu melhor email
    Alert should be    Informe o seu CPF
    Alert should be    Informe o seu CEP
    Alert should be    Informe um número maior que zero
    Alert should be    Adcione um documento com foto (RG ou CHN)
    Take Screenshot    fullPage=True


Deve poder cadastrar um novo dog walker que sabe cuidar de pets
    [Tags]    aservice

    ${dog_walker}    Create Dictionary
    #(massa de testes)    
    ...    name=passeador
    ...    email=passeador@gmail.com
    ...    cpf=00000014141
    ...    cep=04534011
    ...    addressStreet=Rua Joaquim Floriano
    ...    addressDistrict=Itaim Bibi
    ...    addressCityUf=São Paulo/SP
    ...    addressNumber=123
    ...    addressDetails=123abc
    ...    CNH=toretto.jpg
    ...    additional_service=Cuidar


    #Steps
    Go to signup page    Faça seu cadastro
    Fill signup Form    ${dog_walker}
    Additional Service    Cuidar
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.


Deve poder cadastrar um novo dog walker que sabe Adestrar pets
    [Tags]    aservice

    ${dog_walker}    Create Dictionary
    #(massa de testes)
    ...    name=passeador
    ...    email=passeador@gmail.com
    ...    cpf=00000014141
    ...    cep=04534011
    ...    addressStreet=Rua Joaquim Floriano
    ...    addressDistrict=Itaim Bibi
    ...    addressCityUf=São Paulo/SP
    ...    addressNumber=123
    ...    addressDetails=123abc
    ...    CNH=toretto.jpg
    ...    additional_service=Adestrar


    #Steps
    Go to signup page    Faça seu cadastro
    Fill signup Form    ${dog_walker}
    Additional Service    Adestrar
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.
