*** Settings ***
Library     SeleniumLibrary
Resource    ../Lib/Common_Utils.robot
Resource    ../Lib/Home.robot
Resource    ../Lib/Apparel.robot
Resource    ../Lib/Clothing.robot
Resource    ../Lib/Shoes.robot

Variables    ${EXECDIR}/Variables/webelement.yaml

Documentation    This resource file contains keywords for dealing with workflows
