# Run with script with powershell -file run.ps1
# diable the powershell window
# https://stackoverflow.com/questions/2401010/run-a-powershell-script-in-the-background-and-display-nothing

Add-Type -AssemblyName System.Windows.Forms  
Add-Type -AssemblyName System.Drawing  
[System.Windows.Forms.Application]::EnableVisualStyles()  

# Create the form 
$form = New-Object System.Windows.Forms.Form  
$form.Size = New-Object System.Drawing.Size(400, 120)  
$form.StartPosition = 'CenterScreen'  

# Disable resizing of the form and make it a fixed size and disable full screen
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.MaximizeBox = $false
$form.TopMost = $true

# Disable the top bar of the form
# $form.ControlBox = $false

# Title of the form
$form.Text = "Touchscreen Control"
  
# Write a functon to enable or disable the touchscreen
function Enable-Touchscreen {
    # Get the device ID of the touchscreen
    $touchscreen = Get-PnpDevice -FriendlyName "HID-compliant touch screen"
    # Enable the touchscreen
    Enable-PnpDevice -InstanceId $touchscreen.InstanceId -Confirm:$false

    # update the label
    $label.Text = "Touchscreen is enabled"
    # set the label to be green
    $label.ForeColor = "Green"
}

function Disable-Touchscreen {
    # Get the device ID of the touchscreen
    $touchscreen = Get-PnpDevice -FriendlyName "HID-compliant touch screen"
    # Disable the touchscreen
    Disable-PnpDevice -InstanceId $touchscreen.InstanceId -Confirm:$false

    # update the label
    $label.Text = "Touchscreen is disabled"
    # set the label to be red
    $label.ForeColor = "Red"
}

$button1_click = {Enable-Touchscreen}
$button2_click = {Disable-Touchscreen}


# Add a row of two buttons below the label
$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Size(35,35)
$Button1.Size = New-Object System.Drawing.Size(130,23)
$Button1.Location = New-Object System.Drawing.Point(50,14)
$Button1.Text = "Enable Touchscreen"
$Button1.Add_Click($Button1_Click)
$form.Controls.Add($Button1)

$Button2 = New-Object System.Windows.Forms.Button
$Button2.Location = New-Object System.Drawing.Size(35,35)
$Button2.Size = New-Object System.Drawing.Size(130,23)
$Button2.Location = New-Object System.Drawing.Point(200,14)
$Button2.Text = "Disable Touchscreen"
$Button2.Add_Click($button2_click)
$form.Controls.Add($Button2)

# add a label to the form that will update with the current state of the touchscreen
# center the label
$label = New-Object System.Windows.Forms.Label
$label.AutoSize = $true
# set the location of the label
$label.Location = New-Object System.Drawing.Size(110, 50)
# set the font of the label
$label.Font = New-Object System.Drawing.Font("Microsoft Sans Serif", 10)
# center the text of the label
$label.TextAlign = "MiddleCenter"
# center the label
$label.Anchor = "Top"
# center the label


# set the text of the label
$label.Text = "Press to enable or disable"
$form.Controls.Add($label)

$form.Add_Shown({$form.Activate()})  
$form.ShowDialog()
