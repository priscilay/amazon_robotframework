*** Settings ***
Documentation    Essa suite testa pesquisa de iphone no site da Amazon.com.br
Resource         ../resources/amazon_resources.robot
Test Setup       Abra o navegador 
Test Teardown    Fechar o navegador


*** Test Cases ***

Teste 01 - 80% dos produtos mostrados devem ser exclusivamente o produto pesquisado
    [Documentation]         Esse teste verifica se a pesquisa retorna 80% 
    ...                     do real produto pesquisado
    Dado que estou na home do site da amazon 
    Quando buscar "Iphone" usando a barra de pesquisa
    E conte a lista total de produtos encontrados
    E conte o total de itens "iPhone" encontrados
    #Então certifique-se de que pelo menos "80"% dos itens encontrados sejam "Iphone"

# Teste 02 - O preço mais alto na primeira página não pode ser superior a US$ 2.000
    # [Documentation]         Esse teste verifica se o produto de valor maior em reais
    # ...                     não ultrapasse US$ 2.000 
    # Dado que estou na home do site da amazon
    # Quando buscar "Iphone" usando a barra de pesquisa
    # Encontre o “Iphone” mais caro na página
    # Converta seu valor em dólares americanos usando https://exchangeratesapi.io/ API (apikey c8f7e6ee116ef021330d34518a7260e7)
    # Certifique-se de que o valor convertido não seja maior que US$ 2.000

# Teste 03 - Produtos diferentes do produto pesquisado devem ser mais baratos que o produto pesquisado
    # [Documentation]
    # Encontre produtos que não sejam "Iphone"
    # Certifique-se de que todos os produtos encontrados sejam mais baratos que o “Iphone” mais barato    
