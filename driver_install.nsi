!include "MUI2.nsh"

Name "OpenMono Serial Device Driver"
OutFile "OpenMonoSerialDriverSetup-v$%VERSION%.exe"

;Request application privileges for Windows Vista, 7, 8
RequestExecutionLevel admin

!include LogicLib.nsh

Function .onInit
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
    MessageBox mb_iconstop "Administrator rights required!"
    SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
    Quit
${EndIf}
FunctionEnd

!insertmacro MUI_LANGUAGE "English"


Section "Install" SecInstall

    SetOutPath $TEMP

    File "windriver\USBUART_cdc.inf"
    File "windriver\USBUART_cdc.cat"

    !include x64.nsh
    ${DisableX64FSRedirection}
    nsExec::ExecToLog '"$SYSDIR\PnPutil.exe" /i /a "$TEMP\USBUART_cdc.inf"' $0
    ${EnableX64FSRedirection}

SectionEnd
