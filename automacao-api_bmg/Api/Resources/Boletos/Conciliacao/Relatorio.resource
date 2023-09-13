*** Settings ***
Library                RequestsLibrary
Library                String
Library                Collections

*** Variables ***
${URL}                        https://dgp205-saquecartao-apih.bancobmg.com.br

*** Keywords ***
Dado que preciso consulta alguns boletos
    Log            ${URL}
Quando consulto data inicial e data final
    
    Criar Sessao na teste
    ${resp_google}=   GET On Session  Elegibilidade  /  expected_status=200                                   
    ${resp_json}=     GET On Session  jsonplaceholder  /posts/1                                        
                                                                                                       
    Should Be Equal As Strings          ${resp_google.reason}  OK                                      
    Dictionary Should Contain Value     ${resp_json.json()}  sunt aut facere repellat provident      

Criar Sessao na teste
    ${header}            Create Dictionary
    ...                  cpf="99743849319"      
    
    Create Session    alias=Elegibilidade    url=${URL}/Elegibilidade        headers=${header}