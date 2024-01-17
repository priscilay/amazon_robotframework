*** Settings ***
Library  SeleniumLibrary
Library  String
Library  Collections
Library  RequestsLibrary
Library  Dotenv    .env

*** Variable ***
${BROWSER}                      chrome
${URL}                          https://www.amazon.com.br/
${AMAZON}                       amazon
${INDICE}                       1


*** Keywords ***

Abra o navegador 
    Open Browser                          browser=${BROWSER}
    Maximize Browser Window 
   
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

E encontrar o “Iphone” mais caro na página
    Click Element           locator=//span[@class='a-button-text a-declarative']
    Click Element           locator=s-result-sort-select_2
    Wait Until Element Is Visible           locator=//span[@class='a-price-whole']
    ${valor_mais_alto}      Get Text        locator=//span[@class='a-price-whole']
    Log     este é o valor maior: ${valor_mais_alto}
    Set Suite Variable          ${valor_maior}      ${valor_mais_alto}

E converta seu valor em dólares americanos usando "${url_api}"
    Set Suite Variable      ${url_api}      ${url_api}
    Criar sessão restapi   
        ${reponse}          Get On Session
                    ...     alias=Invertexto
                    ...     url=/currency/BRL_USD?token=6077|CKC9wifQoOM4meCsZ1bFXl3WY8IJzXV4
                    # ...     token=${TOKEN}
        Log                    ${reponse.json()}[BRL_USD][price]
        ${dolar_real}    Set Variable       ${reponse.json()}[BRL_USD][price] 
        ${resultado}     Evaluate           ${dolar_real} * ${valor_maior}
        Set Suite Variable      ${valor_convertido}         ${resultado}

Criar sessão restapi 
    ${headers}    Create Dictionary     accept=application/json     Content-Type=application/json
    # ${param}      Create Dictionary     token=${TOKEN} #tentativa de usar um dotenv para guardar dados sensiveis
    Create Session    alias=Invertexto    url=${url_api}      headers=${headers}


Então certifique-se de que o valor convertido não seja maior que US$ "${valor_dolar}"
    IF  ${valor_convertido} <= ${valor_dolar}
        Log     iphone mais caro com valor igual ou menor ao esperado em dolar
    ELSE
        Log                            iphone mais caro que o valor esperado em dolar
        Run Keyword If Test Failed     name=iphone mais caro que o valor esperado em dolar
    END

E encontrar produtos que não sejam "Iphone"
    ${product_count}=  Get Element Count    locator=//h2/a/span[not(contains(.,'Apple iPhone'))]
    Should Be True  ${product_count} > 0
    ${non_iphone_count}=  Get Element Count  locator=//h2/a/span[not(contains(.,'Apple iPhone'))]
                                                                        
    Should Be True  ${non_iphone_count} > 0

    ${teste_preco}      Get Text        locator=//div/div/h2/a/span[not(contains(.,'Apple iPhone'))]/../../../div/../../div/../div/../div[@data-cy='title-recipe']
    Log To Console      ${teste_preco}

