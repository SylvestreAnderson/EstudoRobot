*** Settings ***                                                                                       
Library    Collections                                                                                 
Library    RequestsLibrary                                                                             
Library    String

*** Variables ***
#${HEADERS}                                    {'content-type': 'application/json', 'cpf': '86226185791'}
${HEADERS}                                    {'content-type': 'application/json', 'cpf': '29650503889'}
${URL}                                        https://dgp205-saquecartao-apih.bancobmg.com.br
${ELEGIBILIDADE}                              Elegibilidade
${VALOR_VERDADEIRO}                           {"content":{"clienteElegivel":true,"limiteCliente":900.4500},"messages":[]} 
${VALOR_FALSO}                                {"content":{"clienteElegivel":false,"limiteCliente":null},"messages":["Não foi possivel obter o idPessoa do cpf 29650503889"]}
                                                                                                       

*** Test Cases ***
Realizando o primeiro GET Elegibilidade
    Create Session        alias=${ELEGIBILIDADE}        url=${URL}                    headers=${HEADERS}        
    ${RESPONSE}           GET On Session                alias=${ELEGIBILIDADE}        url=/${ELEGIBILIDADE}         expected_status=200         msg=Essa mensagem é um teste

    Status Should Be                 200  ${RESPONSE}  
      

    Log To Console    ${RESPONSE}
    Log To Console    ${RESPONSE.text}
    
    

    Log To Console    ${RESPONSE.json()['content']['clienteElegivel']}

    ${VALIDAR_ELEGIBILIDADE}        Set Variable            ${RESPONSE.json()['content']['clienteElegivel']}

    Log To Console    ${VALIDAR_ELEGIBILIDADE}

    IF    ${VALIDAR_ELEGIBILIDADE} == True
        Should Be Equal        ${RESPONSE.text}        ${VALOR_VERDADEIRO}
        Log To Console         VERDADEIRO!  
    ELSE
        Should Be Equal        ${RESPONSE.text}        ${VALOR_FALSO}
        Log To Console         FALSE!
        Fail    msg=Cliente não Elegivel ao saque
    END

    