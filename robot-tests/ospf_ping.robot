*** Settings ***
Library    SSHLibrary

*** Variables ***
${USER}        admin
${PASS}        admin
${CEOS1}       ceos1
${CEOS2}       ceos2

${CEOS1_TO_2}  10.0.12.2
${CEOS2_TO_1}  10.0.12.1
${CEOS2_LO}    2.2.2.2

*** Test Cases ***
Check OSPF Neighbor From CEOS1
    Open Connection To Device    ${CEOS1}
    Login Device
    ${output}=    Show OSPF Neighbor
    Log    ${output}
    Should Contain    ${output}    FULL
    Should Contain    ${output}    ${CEOS2_LO}
    Close All Connections

Ping CEOS1 to CEOS2 Interface
    Open Connection To Device    ${CEOS1}
    Login Device
    ${ping_out}=    Execute Command    ping ${CEOS1_TO_2}
    Log    ${ping_out}
    Should Contain    ${ping_out}    0% packet loss
    Close All Connections

Ping CEOS1 to CEOS2 Loopback
    Open Connection To Device    ${CEOS1}
    Login Device
    ${ping_out}=    Execute Command    ping ${CEOS2_LO}
    Log    ${ping_out}
    Should Contain    ${ping_out}    0% packet loss
    Close All Connections

*** Keywords ***
Open Connection To Device
    [Arguments]    ${host}
    Open Connection    ${host}    port=22    timeout=10s

Login Device
    Login    ${USER}    ${PASS}
    Set Client Configuration    prompt=\\w+#

Show OSPF Neighbor
    ${out}=    Execute Command    show ip ospf neighbor
    RETURN     ${out}
