*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variable ***
${BROWSER}                      chrome
${URL}                          https://www.amazon.com.br/
${AMAZON}                       amazon


*** Keywords ***

Abra o navegador
    Close All Browsers 
    Open Browser                          browser=${BROWSER}
    Maximize Browser Window 
options=add_experimental_option("detach", True)    


Navegue até www.amazon.com.br pela página de busca
    Go to                                  url=${URL}
    Wait Until Page Contains               text=${AMAZON}   


Pesquise "${produto}" usando a barra de pesquisa  
    Input Text                              locator=twotabsearchtextbox   text=${produto}
    Click Element                           locator=nav-search-submit-button

Fechar o navegador
    Capture Page Screenshot
    Close Browser    

Conte a lista total de produtos encontrados
    ${total_itens}              Get Element Count     locator=//div[@data-cy="title-recipe"]
    ${total_itens_int}          Convert To Integer    item=${total_itens} 
    Set Test Variable           ${contador}           ${total_itens_int}
    Log  Esse é o total de itens retornados após a pesquisa: ${total_itens_int}    

Conte o total de itens "${produto}" encontrados
    # Conte a lista total de produtos encontrados     
    Log To Console  A quantidade de itens total na proxima keyword aqui ${contador}
    # ${r1}   Evaluate   ${contador} // 100
    ${produto_resposta}      Get Text          locator=//div[@data-cy="title-recipe"]

    ${qtd_iphone}            Get Line Count    ${produto}

    Log To Console         ${qtd_iphone}

    #  ${teste}  document.querySelectorAll('.a-size-mini a-spacing-none a-color-base s-line-clamp-4');

        # ${teste}.forEach((teste) =>
        #   teste.addEventListener('click', (event) => {
        #     console.log(event.currentTarget.textContent);
        #   })
        # );
    # Log To Console     ${produto_resposta}
    # Log To Console    ${\n}
    # FOR  ${CONTADOR}   IN RANGE  3   ${contador}
        # Log To Console     Minha posição agora é: ${CONTADOR}  
        # ${prd_lista}        Get Text    locator=//div[@data-cy="title-recipe"]
        # Log To Console     Produto next: ${prd_lista}
        # Execute JavaScript    window.scrollTo(0,1000)
        Log   Minha posição agora é: ${CONTADOR}
    # END



    # Log    valor que quero  ${r1}