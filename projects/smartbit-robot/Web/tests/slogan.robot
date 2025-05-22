*** Settings ***
Documentation        Hello Robot

Library        Browser

*** Test Cases ***
Deve exibir o Slogan na Landing Page
    #Execução assistida abrindo o browser
    New Browser    browser=chromium    headless=False
    #Execução em backgorund sem linha 9
    New Page        http://localhost:3000
    Get Text    css=.headline h2    equal    Sua Jornada Fitness Começa aqui!
    Sleep    5

