if (Get-Process MobaXterm_Personal_24.1)
{
    Exit
}

Write-Host "Bootup Net Test"

Function IPAddressTest
{

    # Saving Google DNS Servers as a Variable
    $googleDNS = "8.8.8.8" 

    $successCounter = 0

    Write-Host ""
    Write-Host "Starting IP Test ..."

    for ($i = 0; $i -lt 4; $i++)
    {
        try {
            # Test-Connection -ComputerName $gateway -Count 1 EQUALS Ping 8.8.8.8 With One ICMP/Ping Packet

            # Remember to put "-Quiet for pings or traceroutes!"

      `     $pingResult = Test-Connection -ComputerName $googleDNS -Count 1 -Quiet

               if($pingResult -eq $true) {
                    $successCounter++
         `          Write-Host ""
                    Write-Host "IP Ping #$successCounter : Pass"
                } 

                else 
                { 
                    throw "Failed, Missing Network Connection (No Response From Google DNS Servers: 8.8.8.8)"
                }

        }

        catch 
        {
            $successCounter++
            Write-Host ""
            Write-Host "IP Ping #$successCounter : $_"
        }
   

        Start-Sleep -Milliseconds 100
    }
}

#Calling pingTest function

IPAddressTest

Function nameResolutionTest
{
    # Saving Google DNS Servers as a Variable
    $googleFQDN = "www.google.com" 

    $successCounter = 0

    Write-Host ""
    Write-Host "Starting Name Resolution Test..."

    for ($i = 0; $i -lt 4; $i++)
    {
        try {
            # Test-Connection -ComputerName $googleFQDN -Count 1 EQUALS Ping www.google.com With One ICMP/Ping Packet

            # Remember to put "-Quiet for pings or traceroutes!"

      `     $pingResult = Test-Connection -ComputerName $googleFQDN -Count 1 -Quiet

               if($pingResult -eq $true) {
                    $successCounter++
         `          Write-Host ""
                    Write-Host "FQDN Ping #$successCounter : Pass"
                } 

                else 
                {
                    throw "Failed, Name Resolution Issue Likely Cause"
                }

        }

        catch 
        {
            $successCounter++
            Write-Host ""
            Write-Host "IP Ping #$successCounter : $_"
        }

        Start-Sleep -Milliseconds 100
    }
}

#Calling pingTest function

nameResolutionTest

Function pfSenseTest {
    # Define the LAN IP of your pfSense box
    $pfSenseLANIP = "X.X.X.X" 

    $successCounter = 0

    Write-Host ""
    Write-Host "Starting pfSense connectivity Test..."

    for ($i = 0; $i -lt 4; $i++) {
        try {
            # Perform the ping operation
            $pingResult = Test-Connection -ComputerName $pfSenseLANIP -Count 1 -Quiet
            if ($pingResult -eq $true) {
                $successCounter++
                Write-Host ""
                Write-Host "Ping #$successCounter to igb0 (LAN Interface) : Pass"
            } else {
                throw "Failed, No Response from $pfSenseLANIP"
            }
        } catch {
            $successCounter++
            Write-Host ""
            Write-Host "Ping #$successCounter to igb0 (LAN Interface) : $_"
        }

        # Wait for 1 second before the next ping attempt
        Start-Sleep -Milliseconds 100
    }
}

# Call the PfsenseLANPingTest function to execute the ping test
pfSenseTest

Write-Host ""
Write-Host "SSHing into pfSense"

Start-Process C:\Your Path to the MobaxTerm Executable 

# Wait for MobaXterm to start
Start-Sleep -Seconds 4

# Add System.Windows.Forms Assembly 
Add-Type -AssemblyName System.Windows.Forms

# Programmatically input the Ctrl + Shift + N Keys 
[System.Windows.Forms.SendKeys]::SendWait("^+n")

# Wait for SSH password prompt
Start-Sleep -Seconds 1

# Input Remote Server IP Address 
[System.Windows.Forms.SendKeys]::SendWait("X.X.X.X")

#Press Tab 3 Times to reach text form that asks for port number (e.g. - 53, 514, etc.)
for($i = 0; $i -lt 3; $i++)
{
    [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
}
Start-Sleep -Seconds 1


#Input port number at which pfSense is accepting SSH connections
[System.Windows.Forms.SendKeys]::SendWait("XX")

[System.Windows.Forms.SendKeys]::SendWait("{TAB}")

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Start-Sleep -Seconds 2

# Type in pfSense username
[System.Windows.Forms.SendKeys]::SendWait("admin")

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Start-Sleep -Seconds 1

# Type in pfSense password
[System.Windows.Forms.SendKeys]::SendWait("Your_Password")

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

Start-Sleep -Seconds 1

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

#Press Tab a bunch and Enter once to ignore a pop up 
for($i = 0; $i -lt 4; $i++)
{
    [System.Windows.Forms.SendKeys]::SendWait("{TAB}")
}

[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")














