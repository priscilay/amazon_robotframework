*** Settings ***
Library  SeleniumLibrary
Library  String
Library  Collections

*** Variable ***
${BROWSER}                      chrome
${URL}                          https://www.amazon.com.br/
${AMAZON}                       amazon
${INDICE}                       1


*** Keywords ***

Abra o navegador 
    Open Browser                          browser=${BROWSER}
    Maximize Browser Window 
# options=add_experimental_option("detach", True)    


Dado que estou na home do site da amazon 
    Go to                                  url=${URL}
    Wait Until Page Contains               text=${AMAZON}   


Quando buscar "${produto}" usando a barra de pesquisa  
    Input Text                              locator=twotabsearchtextbox   text=${produto}
    Click Element                           locator=nav-search-submit-button

Fechar o navegador
    Capture Page Screenshot
    Close Browser    

E conte a lista total de produtos encontrados
    ${total_itens}              Get Element Count     locator=//div[@data-cy="title-recipe"]
    ${total_itens_int}          Convert To Integer    item=${total_itens}
    Set Suite Variable          ${total_itens_int}     ${total_itens_int}   
    Set Suite Variable           ${contador}           ${total_itens_int}
    Log  Esse é o total de itens retornados após a pesquisa: ${contador}    

E conte o total de itens "iPhone" encontrados
    ${total_iphon}              Get Element Count     locator=//h2/a/span[contains(.,'Apple iPhone')]
    ${total_iohon_int}          Convert To Integer    item=${total_iphon}
    Set Suite Variable          ${total_iohon_int}     ${total_itens_int}   
    Set Suite Variable           ${contador}           ${total_itens_int}

    ${prd}      Get Element Count    locator=//h2/a/span[contains(.,'Apple iPhone')]
    ${int}      Convert To Integer    ${prd}
    Set Suite Variable      ${total_iphones}        ${int}
    Log  total de iphones é: ${total_iphones}
    
Então certifique-se de que pelo menos "${porcentagem}"% dos itens encontrados sejam "Iphone"
    #REGRA DE 3 PRA SABER A QUANTIDADE DE PRODUTOS EQUIVALENTE A 80% DO RETORNADO
    ${resultado}=    Evaluate    ${contador} * (${porcentagem} / 100)
    Log    80% de ${contador} é: ${resultado}

    ${resultado_int}     Convert To Integer     ${resultado}

    IF  ${resultado_int} == ${total_iphones}
        Log  Tem pelo menos ${porcentagem}% de iphones nos produtos retornados
    ELSE
        Log  Tem menos de ${porcentagem}% de iphones nos produtos retornados
    END
