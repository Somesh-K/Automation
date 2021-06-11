function numInstances([string]$process)
{
    @(get-process -ea silentlycontinue $process).count
}

 function unzip {
	param( [string]$ziparchive, [string]$extractpath )
	[System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
 function mysql_download
{ 
	$url = "https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.20-winx64.zip"
    $mysql_count=$mysql_count+1
	$soutput=$drive+'Mysql'+$mysql_count
	mkdir $soutput
	cd $soutput
	$output = $soutput+'\mysql57.zip'

	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	Invoke-WebRequest -Uri $url -OutFile $output
	
	Add-Type -AssemblyName System.IO.Compression.FileSystem
	unzip $output $soutput
    $mysql_unzip=$soutput+"\mysql-5.7.20-winx64"
    Write-host "Mysql unzip path:"$mysql_unzip
    cd $mysql_unzip
#    Get-Location
	mkdir Data
    mkdir uploads
    Write-host "Mysql scriptPath path:" $PSScriptRoot
    cd $PSScriptRoot
    #Get-Location
   cp my.ini $mysql_unzip\my.ini
    $datadir_conf='datadir='+$mysql_unzip+'\Data'
    $secure_file_priv_conf='secure-file-priv='+$mysql_unzip+'\uploads'
	$server_id_priv_conf='server-id='+$mysql_count
    $port_config='port='+$port_config
    Write-host "Mysql datadir path:" $datadir_conf
    Write-host "Mysql secure_file_priv path:" $secure_file_priv_conf
    (Get-Content $mysql_unzip\my.ini) -replace 'datadir=', $datadir_conf | Set-Content $mysql_unzip\my.ini
    (Get-Content $mysql_unzip\my.ini) -replace 'secure-file-priv=', $secure_file_priv_conf | Set-Content $mysql_unzip\my.ini
	(Get-Content $mysql_unzip\my.ini) -replace 'server-id=', $server_id_priv_conf | Set-Content $mysql_unzip\my.ini
	(Get-Content $mysql_unzip\my.ini) -replace 'port=', $port_config | Set-Content $mysql_unzip\my.ini
    cd $mysql_unzip\bin
	$datadir=$mysql_unzip+'\Data'
    #Get-Location
    $mysql_base= $mysql_unzip+'\bin\'
    cd $mysql_base
    Write-host "Mysql mysql_base path:" $mysql_base
#    (get-acl $datadir).access | ft IdentityReference,FileSystemRights,AccessControlType,IsInherited,InheritanceFlags -auto
    $QueryResult1 = .\mysqld --initialize-insecure --basedir=$mysql_unzip  --datadir=$datadir
    $QueryResult2 = .\mysqld --install Mysql$mysql_count --defaults-file=$mysql_unzip\my.ini
    net start Mysql$mysql_count
  #  #$my_ini_path=$scriptPath
}



 
function main_op
{
	$cpath = Read-Host -Prompt "Enter the Drive" 
	$port_config = Read-Host -Prompt "Provide the Mysql Port number"
	Write-host "Mysql will be installed in" $cpath "Drive with port number" $port_config	
	$drive=$cpath+':\'
	cd $drive
	#Get-Location
	mysql_download 
	#$output

}

$mysql_count=numInstances mysqld

#Write-host Mysql status:$mysql_count

if ($mysql_count -ge 0)
{
#	$start_time = Get-Date

Write-host Number of instances:$mysql_count
$wait = Read-Host -Prompt "are you continue to proceed(y/n)"

	if ($wait -eq 'y')
	{
		Write-host yes
		main_op
    #Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"	
	}
	else 
	{
		break; 
	}

}


