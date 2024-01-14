*** Settings ***
Library  SeleniumLibrary
Library  Selenium2Library
Library  String

*** Variable ***
${BROWSER}                      chrome
${URL}                          https://www.amazon.com.br/
${AMAZON}                       amazon
${INDICE}                       1


*** Keywords ***

Abra o navegador 
    Open Browser                          browser=${BROWSER}
    Maximize Browser Window 
options=add_experimental_option("detach", True)    


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
    @{total_itens}             Get WebElements      locator=//div[@data-cy="title-recipe"]
    @{total_itens_str}         Convert To String    @{total_itens}
    ${total_itens_int}         Convert To Integer   @{total_itens}

    ${item}                    Get WebElement       locator=//div[@data-cy="title-recipe"]
    ${item_str}                Convert To String    ${item}
    #converter string nao resolveu pq a keyword espera so 1 argumento   
    
    Set Test Variable           ${i}        1
    @{itens_texto}          Create List         @{total_itens}

    IF      ${i}   <=    ${total_itens_int}
        FOR  ${item_str}    IN      @{itens_texto}
            ${i}     Evaluate        ${i}  +  1
             Log  ${i}   
        END
    END
    # ${texto_elemento}=          Evaluate    ' '.join(${total_produtos})         
    # Log ${texto_elemento}    


#    ${elementos}=         Get WebElements    locator=//div[@data-cy="title-recipe"]
#    ${lista_produtos}=    Create List
    # FOR    ${total_itens}    IN    @{elementos}
        # ${texto}=    Get Text    locator=//div[@data-cy="title-recipe"]
        # Append To List    ${lista_produtos}    ${texto}
    # END
    # ${total_itens_int}          Convert To Integer    item=${total_itens}
    # Log   total aqui      ${total_itens} 
    # ${produto}     Get Text        locator=//div[@data-cy="title-recipe"]
    # FOR  ${produto}   IN   @{total_produtos}
        # Log     testando o loop
        # ${produto}     Get Text        locator=//div[@data-cy="title-recipe"]
        # Log     produto aqui    ${produto}
    # END
    # Conte a lista total de produtos encontrados     
    # Log To Console  A quantidade de itens total na proxima keyword aqui ${contador}
    # ${r1}   Evaluate   ${contador} // 100
    # ${produto_resposta}      Get Text          locator=//div[@data-cy="title-recipe"]
    # ${qtd_iphone}            Get Line Count    ${produto}
    # Log To Console         ${qtd_iphone}


    # ${elemento}     Get Length      
    # ${elemento}
    # FOR  1  IN  @{elementos}
    #   ${texto}  Get Text  ${elemento}
    #   Log  Texto encontrado: ${texto}
    #  ${teste}  document.querySelectorAll('.a-size-mini a-spacing-none a-color-base s-line-clamp-4');
    # END 
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

    # END



    # Log    valor que quero  ${r1}