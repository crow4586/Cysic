@echo off

echo.
echo  " ----------------------------------------------------------------
echo  "                                                                                                                       
echo  "       Cysic �������ڵ� WINDOWS һ���������    
echo  "                                                                                                                       
echo  "                              By: Doge                                                        
echo  "                                                                                                                       
echo  " ----------------------------------------------------------------
echo.


set "VERIFIER_DIR=%USERPROFILE%\cysic-verifier"
set "PATH=%VERIFIER_DIR%;%PATH%"


set /p WALLET_ADDRESS=����������Ǯ����ַ��


if not exist "%VERIFIER_DIR%" (
    mkdir "%VERIFIER_DIR%"
)


echo �������� verifier.exe...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_win_x86_64.exe', '%VERIFIER_DIR%\verifier.exe')"
echo ���� verifier.exe ���.

echo �������� zkp.dll...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.dll', '%VERIFIER_DIR%\zkp.dll')"
echo ���� zkp.dll ���.

echo �������� start.ps1...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://cysic-verifiers.oss-accelerate.aliyuncs.com/start.ps1', '%VERIFIER_DIR%\start.ps1')"
echo ���� start.ps1 ���.


(
echo # Not Change
echo chain:
echo   endpoint: "testnet-node-2.prover.xyz:9090"
echo   chain_id: "cysicmint_9000-1"
echo   gas_coin: "cysic"
echo   gas_price: 10
echo claim_reward_address: "%WALLET_ADDRESS%"
echo server:
echo   cysic_endpoint: "https://api-testnet.prover.xyz"
) > "%VERIFIER_DIR%\config.yaml"


reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%PATH%" /f
echo  " ----------------------------------------------------------------
echo ������������ر�ɱ���������ǽ��
echo  " ----------------------------------------------------------------
echo ������ɣ����������ڵ�...
echo �״����������ĵȴ�������֤�������ļ���������Ҫ15~20���ӡ�
echo  " ----------------------------------------------------------------
echo !!! ����ر��� USER\.cysic\keys\ �µ�KEY�ļ� !!!
echo  " ----------------------------------------------------------------
echo �˴��ڿɹرա�
echo  " ----------------------------------------------------------------
cd /d "%VERIFIER_DIR%"
start "" "verifier.exe"


pause
