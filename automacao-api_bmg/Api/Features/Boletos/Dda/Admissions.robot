*** Settings ***
Resource                     ../../../Resources/dados/base.robot



*** Test Cases ***
# Criando o boleto do dia
#     # ${data}=        Get Current Date        result_format=%Y-%m-%d
#     # ${valor}=       Numerify    text=#.##
#     # ${valor}=       Set Variable    1${valor}    
#     # ${CPF}=         Set Variable    01074412461  
#     Gerar boleto de deposito pela API    


Dado que estou na página Boletos DDA após gerar boleto futuro em dia
    #[Arguments]    ${cpf}    ${senha}
    ${data}=     Get Current Date    result_format=%Y-%m-%d    increment=1 days
    ${valor}=    Numerify    text=#.##
    ${valor}=    Set Variable    1${valor}
    ${cpf}=      Set Variable    29650503889  
    Gerar boleto pela API    ${valor}    ${data}    ${cpf}

