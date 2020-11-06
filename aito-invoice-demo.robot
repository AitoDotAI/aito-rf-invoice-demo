*** Settings ***
Library           SeleniumLibrary
Library           Dialogs
Library     Collections
Library     OperatingSystem
Library     aito.sdk.aito_client.AitoClient     %{AITO_INSTANCE_URL}     %{AITO_API_KEY}    False    WITH NAME    aito_client
Library     aito.api

*** Variables ***
${BROWSER}        Chrome
${DELAY}          0
${FORM URL}       https://anttiaito.wufoo.com/forms/z1gfzm4o11v5ekc/
${table}=         invoice_data

*** Keywords ***
Aito Predict
    [Arguments]    ${table}    ${inputs}    ${target}    ${limit}=1
    # table: String, name of the table in Aito schema
    # inputs: Dictionary, input data for prediction
    # target: String, name of the feature being predicted
    # limit: Integer, how many entries Aito returns

    # Make sure the limit is an integer
    ${limit}=       Convert To Integer  ${limit}

    # Construct predict query body as a Dictionary using arguments
    ${query}=       Create Dictionary   from=${table}   where=${inputs}   predict=${target}   limit=${limit}

    # Query for Aito
    ${client}      Get Library Instance    aito_client
    ${response}    Predict      ${client}   ${query}
    
    # Return only first feature and probability
    [Return]    ${response['hits'][0]['feature']}



*** Test Cases ***
Fill the form
    Open Browser    ${FORM URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Pause Execution   message="Fill input description"
    
    ${ITEM_DESCRIPTION}      Get Value        Field1
    
    ${inputs}=       Create Dictionary   Item_Description=${ITEM_DESCRIPTION}

    ${product_type}    Aito Predict   table=${table}    inputs=${inputs}   target=Product_Category 
    
    input text  Field2  ${PRODUCT_TYPE}

    ${gl_code}    Aito Predict   table=${table}    inputs=${inputs}   target=GL_Code 
    
    input text  Field3  ${gl_code}

    ${vendor_code}    Aito Predict   table=${table}    inputs=${inputs}   target=Vendor_Code
    
    input text  Field4  ${VENDOR_CODE}
