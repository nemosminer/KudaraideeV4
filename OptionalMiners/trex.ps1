if (!(IsLoaded(".\Include.ps1"))) {. .\Include.ps1;RegisterLoaded(".\Include.ps1")}

$Path = ".\Bin\NVIDIA-trex070\t-rex.exe"
$Uri = "https://nemosminer.com/data/optional/t-rex-0.7.0-win-cuda10.0.7z"

$Commands = [PSCustomObject]@{
"balloon" = "" #Balloon(fastest)
"polytimos" = "" #Poly(fastest)
"bcd" = "" #Bcd(fastest)
"skunk" = "" #Skunk(fastest)
"hsr" = "" #Hsr(Testing)
"bitcore" = "" #Bitcore(fastest)
"lyra2z" = "" #Lyra2z (cryptodredge faster)
"tribus" = "" #Tribus(CryptoDredge faster)
"c11" = "" #C11(fastest)
"x17" = "" #X17(fastest)
"x16s" = "" #X16s(fastest)
"x16r" = "" #X16r(fastest)
"sonoa" = "" #SonoA(fastest)
"hmq1725" = "" #hmq1725(fastest)
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = " -b 127.0.0.1:$($Variables.NVIDIAMinerAPITCPPort) -d $($Config.SelGPUCC) -a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day * .99} # substract 1% devfee
        API = "ccminer"
        Port = $Variables.NVIDIAMinerAPITCPPort
        Wrap = $false
        URI = $Uri
        User = $Pools.(Get-Algorithm($_)).User
    }
}
