*** Settings ***
Library            Collections                                                                                 
Library            RequestsLibrary   
Library            FakerLibrary        locale=pt_BR  
Library            DateTime



Resource           ../../resources/dados/Config.robot
Resource           ../../resources/dados/hooks.robot

Variables          ../../resources/dados/${ENV}.yaml
#Variables          ../../resources/dados/Variaveis.yaml