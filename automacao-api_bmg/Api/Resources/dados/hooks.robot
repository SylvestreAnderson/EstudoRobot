*** Settings ***
Resource    base.robot

*** Keywords ***
# Gerar boleto de deposito pela API
#     ${UUID}=            Uuid 4
#     ${headers}=         Create Dictionary    Content-Type=application/json    Authorization=Basic dGhpYWdvLm9yZmFubzp4VXoxTkJKZnVZb3g= 
#     Log To Console    ${headers} 
#     ${endereco}=        Create Dictionary    Logradouro=Rua Automacao, 10     Bairro=Automacao Back      cidade=Automacao    UF=MG    CEP=30315010          
#     ${body}=            Create Dictionary    Valor=20.00    Vencimento=2023-09-13    Nome=BMG Automacao    CPF_CNPJ=Rua Automacao, 10    SolicitanteId=${UUID}    Produto=8734
#     ${response}         Post    url=http://wsih/GBDP001/api/boleto    headers=${headers}    json=${body}    expected_status=201

#     Log To Console    ${response}

Gerar boleto pela API
    [Arguments]     ${00.00}    ${AAAA-MM-DD}    ${CPF}
    ${UUID}=        Uuid 4
    ${headers}=     create dictionary   Content-Type=application/json    Authorization=${api_boleto.auth}
    ${endereco}=    create dictionary    Logradouro=${api_boleto.logradouro}    Bairro=${api_boleto.bairro}    Cidade=${api_boleto.cidade}   UF=${api_boleto.uf}    CEP=${api_boleto.cep}
    ${body}=        create dictionary    Valor=${00.00}   Vencimento=${AAAA-MM-DD}    Nome=${api_boleto.nome}    CPF_CNPJ=${CPF}    Endereco=${endereco}    SolicitanteId=${UUID}    Produto=${api_boleto.produto}
    ${response}=    POST    ${api_boleto.endpoint}      json=${body}   headers=${headers}    expected_status=201

    ${varia_Response}   Set Variable     ${response.json()['LinhaDigitavel']}

    Log To Console    ${varia_Response}
        