# Test Suite for Register page
*** Settings ***
Library    String
Library    Collections

Resource    ${EXECDIR}/Lib/Common_Utils.robot
Resource    ${EXECDIR}/Lib/Checkout.robot 
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Home.robot

Variables    ${EXECDIR}/Variables/env.yaml
Variables    ${EXECDIR}/Variables/webelement.yaml
Variables    ${EXECDIR}/Variables/testdata.yaml