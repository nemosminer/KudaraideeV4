if (!(IsLoaded(".\Include.ps1"))) {. .\Include.ps1; RegisterLoaded(".\Include.ps1")}


$Path = ".\Bin\NVIDIA-Cornz\ccminer_CP.exe"
$Uri = "https://github.com/cornz/ccminer/releases/download/keccakc/ccminer_CP.zip"

$Commands = [PSCustomObject]@{
    #"bitcore" = "" #Bitcore
    #"blake2s" = "" #Blake2s
    #"blakecoin" = "" #Blakecoin
    #"vanilla" = "" #BlakeVanilla
    #"cryptonight" = "" #Cryptonight
    #"decred" = "" #Decred
    #"equihash" = "" #Equihash
    #"ethash" = "" #Ethash
    #"groestl" = " " #Groestl
    #"hmq1725" = "" #hmq1725
    #"keccak" = "" #Keccak
    #"lbry" = "" #Lbry
    #"lyra2v2" = " " #Lyra2RE2
    #"lyra2z" = "" #Lyra2z
    #"myr-gr" = " " #MyriadGroestl
    #"neoscrypt" = " " #NeoScrypt
    #"nist5" = " " #Nist5
    #"pascal" = "" #Pascal
    #"qubit" = "" #Qubit
    #"scrypt" = "" #Scrypt
    #"sia" = "" #Sia
    #"sib" = "" #Sib
    #"skein" = "" #Skein
    #"timetravel" = "" #Timetravel
    #"x11" = "" #X11
    #"veltor" = "" #Veltor
    #"x11evo" = "" #X11evo
    #"x17" = "" #X17
    #"yescrypt" = "" #Yescrypt
    "keccakc" = " --api-remote " #Keccakc
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-b $($Variables.NVIDIAMinerAPITCPPort) -a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Live}
        API = "Ccminer"
        Port = 4068
        Wrap = $false
        URI = $Uri
		User = $Pools.(Get-Algorithm($_)).User
    }
}