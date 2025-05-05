Add-Type -AssemblyName System.Windows.Forms

# Global variable for theme state
$darkMode = $false

# Function to generate random emergency situations
function Get-EmergencySituation {
    $situations = @(
        "Car accident on the highway",
        "House fire in the city center",
        "Person collapsed in the park",
        "Flood in the residential area",
        "Explosion in the factory district"
    )
    return $situations | Get-Random
}

# Function to handle the dispatch action
function Dispatch-Service {
    param ([string]$service)
    switch ($service) {
        "Police" { $message = "Police are on the way to the situation!" }
        "Ambulance" { $message = "Ambulance is rushing to the scene!" }
        "Fire" { $message = "Fire service is responding to the fire!" }
        "Paramedic" { $message = "Paramedics are en route to assist the injured!" }
        "Search and Rescue" { $message = "Search and Rescue teams are heading to the scene!" }
        "Helicopter" { $message = "A helicopter is being dispatched for air support!" }
        default { $message = "Invalid service selection." }
    }
    $lblMessage.Text = $message
}

# Function to switch theme
function Switch-Theme {
    $global:darkMode = -not $global:darkMode

    if ($darkMode) {
        $form.BackColor = "Black"
        $lblEmergency.ForeColor = "White"
        $lblMessage.ForeColor = "White"
        $form.Controls | ForEach-Object {
            if ($_ -is [System.Windows.Forms.Button]) {
                $_.BackColor = "#333333"
                $_.ForeColor = "White"
            }
        }
    } else {
        $form.BackColor = "White"
        $lblEmergency.ForeColor = "Black"
        $lblMessage.ForeColor = "Black"
        $form.Controls | ForEach-Object {
            if ($_ -is [System.Windows.Forms.Button]) {
                $_.BackColor = [System.Drawing.SystemColors]::Control
                $_.ForeColor = "Black"
            }
        }
    }
}

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "999 Emergency Dispatcher"
$form.Size = New-Object System.Drawing.Size(500, 400)
$form.StartPosition = 'CenterScreen'

# Labels
$lblEmergency = New-Object System.Windows.Forms.Label
$lblEmergency.Size = New-Object System.Drawing.Size(450, 40)
$lblEmergency.Location = '25,50'
$lblEmergency.TextAlign = 'MiddleCenter'
$lblEmergency.Font = New-Object System.Drawing.Font("Arial", 12)
$form.Controls.Add($lblEmergency)

$lblMessage = New-Object System.Windows.Forms.Label
$lblMessage.Size = New-Object System.Drawing.Size(450, 40)
$lblMessage.Location = '25,150'
$lblMessage.TextAlign = 'MiddleCenter'
$lblMessage.Font = New-Object System.Drawing.Font("Arial", 12)
$form.Controls.Add($lblMessage)

# Buttons
$buttons = @(
    @{ Text="Dispatch Police"; Location='25,200'; Action={ Dispatch-Service "Police" } },
    @{ Text="Dispatch Ambulance"; Location='150,200'; Action={ Dispatch-Service "Ambulance" } },
    @{ Text="Dispatch Fire"; Location='275,200'; Action={ Dispatch-Service "Fire" } },
    @{ Text="Dispatch Paramedic"; Location='25,250'; Action={ Dispatch-Service "Paramedic" } },
    @{ Text="Dispatch Search & Rescue"; Location='150,250'; Action={ Dispatch-Service "Search and Rescue" } },
    @{ Text="Dispatch Helicopter"; Location='275,250'; Action={ Dispatch-Service "Helicopter" } }
)

foreach ($b in $buttons) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Size = '100,40'
    $btn.Location = $b.Location
    $btn.Text = $b.Text
    $btn.Add_Click($b.Action)
    $form.Controls.Add($btn)
}

# Start Game button
$btnStart = New-Object System.Windows.Forms.Button
$btnStart.Size = '100,40'
$btnStart.Location = '150,100'
$btnStart.Text = "Start Game"
$btnStart.Add_Click({
    $lblEmergency.Text = "Emergency: $(Get-EmergencySituation)"
    $lblMessage.Text = ""
})
$form.Controls.Add($btnStart)

# Theme Switcher button
$btnTheme = New-Object System.Windows.Forms.Button
$btnTheme.Size = '100,40'
$btnTheme.Location = '360,10'
$btnTheme.Text = "Switch Theme"
$btnTheme.Add_Click({ Switch-Theme })
$form.Controls.Add($btnTheme)

# Show form
$form.ShowDialog()
