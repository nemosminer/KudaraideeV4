if (!(IsLoaded(".\Include.ps1"))) {. .\Include.ps1; RegisterLoaded(".\Include.ps1")}

$Path = ".\Bin\NVIDIA-DSTM\zm.exe"
$Uri = "https://github.com/nemosminer/DSTM-equihash-miner/releases/download/DSTM-v0.6.1/zm_0.6.1_win.zip"

$Commands = [PSCustomObject]@{
    "equihash" = " -d $SelGPUDSTM" #Equihash
}
$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "--telemetry=127.0.0.1:$($Variables.NVIDIAMinerAPITCPPort) --server $($Pools.(Get-Algorithm($_)).Host) --port $($Pools.(Get-Algorithm($_)).Port) --user $($Pools.(Get-Algorithm($_)).User) --pass $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Hour * .98} # substract 2% devfee
        API = "DSTM"
        Port = $Variables.NVIDIAMinerAPITCPPort
        Wrap = $false
        URI = $Uri    
	User = $Pools.(Get-Algorithm($_)).User
    }
}
