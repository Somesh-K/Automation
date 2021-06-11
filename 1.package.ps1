########################################################
#Check if running as administrator, if not then enables#
########################################################

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

#############################
#Make and download to folder#
#############################

New-Item -Path c:\VCRuntime -ItemType directory

Write "Download Microsoft Visual C++ 2005, 2008, 2010, 2012, 2013, 2015"
#Write "Microsoft Visual C++ 2005 SP1 Redistributable Package (x86)" -Verbose
#Invoke-WebRequest   "http://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE" -OutFile "C:\VCRuntime\vcredist_x86_2005.exe"
#Write "Microsoft Visual C++ 2005 SP1 Redistributable Package (x64)" -Verbose
#Invoke-WebRequest  "http://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE" -OutFile "C:\VCRuntime\vcredist_x64_2005.exe"
#Write "Microsoft Visual C++ 2008 SP1 Redistributable Package (x86)" -Verbose
#Invoke-WebRequest  "http://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe" -OutFile "C:\VCRuntime\vcredist_x86_2008.exe"
#Write "Microsoft Visual C++ 2008 SP1 Redistributable Package (x64)" -Verbose
#Invoke-WebRequest  "http://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe" -OutFile "C:\VCRuntime\vcredist_x64_2008.exe"
#Write "Microsoft Visual C++ 2010 SP1 Redistributable Package (x86)" -Verbose
#Invoke-WebRequest "http://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe" -OutFile "C:\VCRuntime\vcredist_x86_2010.exe"
#Write "Microsoft Visual C++ 2010 SP1 Redistributable Package (x64)" -Verbose
#Invoke-WebRequest "http://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe" -OutFile "C:\VCRuntime\vcredist_x64_2010.exe"
#Write "Microsoft Visual C++ 2012 Update 4 Redistributable Package (x86)" -Verbose
#Invoke-WebRequest "http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe" -OutFile "C:\VCRuntime\vcredist_x86_2012.exe"
#Write "Microsoft Visual C++ 2012 Update 4 Redistributable Package (x64)" -Verbose
#Invoke-WebRequest "http://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe" -OutFile "C:\VCRuntime\vcredist_x64_2012.exe"
Write "Microsoft Visual C++ 2013 Redistributable Package (x86)" -Verbose
Invoke-WebRequest "http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x86.exe" -OutFile "C:\VCRuntime\vcredist_x86_2013.exe"
Write "Microsoft Visual C++ 2013 Redistributable Package (x64)" -Verbose
Invoke-WebRequest "http://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe" -OutFile "C:\VCRuntime\vcredist_x64_2013.exe"
Write "Visual C++ Redistributable for Visual Studio 2015 (x86)" -Verbose
Invoke-WebRequest "https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x86.exe" -OutFile "C:\VCRuntime\vcredist_x86_2015.exe"
Write "Visual C++ Redistributable for Visual Studio 2015 (x64)" -Verbose
Invoke-WebRequest "https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe" -OutFile "C:\VCRuntime\vcredist_x64_2015.exe"
#Write "Visual C++ Redistributable for Visual Studio 2017 (x86)" -Verbose
#Invoke-WebRequest "https://download.microsoft.com/download/4/9/5/495e9ce4-e3a3-4055-8499-999dc2474a3c/vc_redist.x86.exe" -OutFile"C:\VCRuntime\vcredist_x86_2017.exe"
#Write "Visual C++ Redistributable for Visual Studio 2017 (x64)" -Verbose
#Invoke-WebRequest "https://download.microsoft.com/download/a/b/2/ab2cc1b4-d275-4d73-8d1a-23733eb27763/vc_redist.x64.exe" -OutFile"C:\VCRuntime\vcredist_x64_2017.exe"
#Write "Win Rar " -Verbose
#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#Invoke-WebRequest "http://rarlab.com/rar/winrar-x64-540.exe" -OutFile "C:\VCRuntime\winrar-x64-540.exe"
Write "Mysql Workbench " -Verbose
Invoke-WebRequest "https://downloads.mysql.com/archives/get/p/8/file/mysql-workbench-community-6.3.10-winx64.msi"  -OutFile "C:\VCRuntime\mysql-workbench-community-6.3.10-winx64.msi"


######################################
#Install the files from the directory#
######################################

$files = Get-ChildItem -Path "C:\VCRuntime\" -Filter *.exe

foreach($item in $files)
{
    Write-Output "Installing: $item"
     
    Start-Process -FilePath $item.FullName -ArgumentList '/q' -Wait
    Write-Output "Installation of $item has been completed."
}

$files = Get-ChildItem -Path "C:\VCRuntime\" -Filter *.msi

foreach($item in $files)
{
    Write-Output "Installing: $item"
     
    Start-Process -FilePath $item.FullName -ArgumentList '/q' -Wait
    Write-Output "Installation of $item has been completed."
}
Remove-Item -path "C:\VCRuntime" -recurse

Write-Output "All Prerequesties have been installed and cleanup performed."
 
