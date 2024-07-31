@echo off

echo.
echo  " ----------------------------------------------------------------
echo  "                                                                                                                       
echo  "       Cysic 测试网节点 WINDOWS 一键部署程序。    
echo  "                                                                                                                       
echo  "                              By: Doge                                                        
echo  "                                                                                                                       
echo  " ----------------------------------------------------------------
echo.


set "VERIFIER_DIR=%USERPROFILE%\cysic-verifier"
set "PATH=%VERIFIER_DIR%;%PATH%"


set /p WALLET_ADDRESS=请输入您的钱包地址：


if not exist "%VERIFIER_DIR%" (
    mkdir "%VERIFIER_DIR%"
)


echo 正在下载 verifier.exe...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://cysic-verifiers.oss-accelerate.aliyuncs.com/verifier_win_x86_64.exe', '%VERIFIER_DIR%\verifier.exe')"
echo 下载 verifier.exe 完成.

echo 正在下载 zkp.dll...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://cysic-verifiers.oss-accelerate.aliyuncs.com/libzkp.dll', '%VERIFIER_DIR%\zkp.dll')"
echo 下载 zkp.dll 完成.

echo 正在下载 start.ps1...
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://cysic-verifiers.oss-accelerate.aliyuncs.com/start.ps1', '%VERIFIER_DIR%\start.ps1')"
echo 下载 start.ps1 完成.


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
echo 如果命令出错，请关闭杀毒软件防火墙。
echo  " ----------------------------------------------------------------
echo 部署完成，正在启动节点...
echo 首次运行请耐心等待下载验证器依赖文件，可能需要15~20分钟。
echo  " ----------------------------------------------------------------
echo !!! 请务必备份 USER\.cysic\keys\ 下的KEY文件 !!!
echo  " ----------------------------------------------------------------
echo 此窗口可关闭。
echo  " ----------------------------------------------------------------
cd /d "%VERIFIER_DIR%"
start "" "verifier.exe"


pause
