*** Settings ***
Documentation    Arquivo principal do projeto

Library        Browser

Resource        actions/signup.resource

*** Keywords ***

Start session
   #New Browser    browser=chromium                      # Execução em background#
    New Browser    browser=chromium    headless=False    # Abrindo o browser/execução assitida#
    New Page    https://walkdog.vercel.app               # Acessando a página #

    Wait For Elements State    css=h1 >> text=Cuidado e diversão em cada passo
    ...        visible        5        # Validando se está na tela correta/Aguardando algum elemento #    

Finish session
    Take Screenshot    fullPage=True
