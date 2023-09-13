*** Settings ***
Library    RequestsLibrary
Library    String
Library    FakerLibrary
Library    OperatingSystem


*** Variables ***
${URL_BASE}                http://internal-alb-bmg-dda-api-hml-559159630.us-east-2.elb.amazonaws.com:8080 
${ALIAS_NAME}              Pagador  
${URL_ADESOES}             /api/v1/adesoes   
${BODY}                    {"idTipoConta":29} 
${VALIDAR}                 {"statusCode":422,"details":[{"code":"MSGE0007","message":"Você já possui adesão ao DDA ativa ou em processamento."}]}
${CPF}                     {'content-type': 'application/json', 'cpf': '29650503889', 'X-Api-Key':'nnMDUsYDGITRMA5orgLQht10T3ra2H5ygMPZduJufp4='}  



*** Test Cases ***
01- Permitir corrigir o Status da Adesao do DDA de um cliente Pagador Eletrônico pela inscrição - PUT
    Create Session        alias=${ALIAS_NAME}             url=${URL_BASE}                    headers=${CPF}       
    ${RESPONSE}           Put On Session                alias=${ALIAS_NAME}        url=${URL_ADESOES}/sync         expected_status=204
    

    Log To Console    ${RESPONSE.text}
    ${STATUS_CODE}        Set Variable        204    

    Should Be Equal    ${RESPONSE}    204

02 - Consultar Status Adesao de Cliente Pagador Eletronico no DDA Async - GET
    Create Session        alias=${ALIAS_NAME}             url=${URL_BASE}                    headers=${CPF}       
    ${RESPONSE}           GET On Session                alias=${ALIAS_NAME}        url=${URL_ADESOES}         expected_status=200

    Log To Console    ${RESPONSE.text}

03 - Exclusão de Cliente Pagador Eletronico do DDA - DELETE
    ${GUID_DELETE}        Uuid 4
    ${header}           Create Dictionary    Content-Type=application/json    accept=text/plain    cpf=29650503889   X-Api-Key=nnMDUsYDGITRMA5orgLQht10T3ra2H5ygMPZduJufp4=    idempotencyId=${GUID_DELETE}        
    Create Session    alias=${ALIAS_NAME}     url=${URL_BASE}                  headers=${header}            
    ${RESPONSE_DELETE}    DELETE On Session    alias=${ALIAS_NAME}        url=${URL_ADESOES}         expected_status=204        

    Log To Console    ${RESPONSE_DELETE}

04 - Inclusão de Cliente Pagador Eletronico no DDA - POST  
    Sleep    20  
    ${GUID}               Uuid 4
    ${HEADERS}            Create Dictionary    Content-Type=application/json    accept=text/plain    cpf=29650503889    agencia=89    conta=111435304    X-Api-Key=nnMDUsYDGITRMA5orgLQht10T3ra2H5ygMPZduJufp4=    idempotencyId=${GUID}       

    Create Session    alias=${ALIAS_NAME}    url=${URL_BASE}        headers=${HEADERS} 
    ${RESPONSE}    POST On Session        alias=${ALIAS_NAME}        url=${URL_ADESOES}        expected_status=201       data=${BODY}   

    Log To Console    ${RESPONSE} 
    
05 - Inclusão de Cliente Pagador Eletronico no DDA já existente - POST
    
    ${GUID}               Uuid 4
    ${HEADERS}            Create Dictionary    Content-Type=application/json    accept=text/plain    cpf=29650503889    agencia=89    conta=111435304    X-Api-Key=nnMDUsYDGITRMA5orgLQht10T3ra2H5ygMPZduJufp4=    idempotencyId=${GUID}       

    Create Session    alias=${ALIAS_NAME}    url=${URL_BASE}        headers=${HEADERS} 
    ${RESPONSE}    POST On Session        alias=${ALIAS_NAME}        url=${URL_ADESOES}        expected_status=422       data=${BODY}   

    Log To Console    ${RESPONSE.json()} 
    ${TESTE_VALIDAR}    Set Variable      ${RESPONSE.text}

    Should Be Equal    ${VALIDAR}     ${TESTE_VALIDAR}
    

    