if (!(Get-Command "C:\Program Files\RedHat\Podman\docker.exe" -ErrorAction SilentlyContinue)) {
    cmd /c mklink "C:\Program Files\RedHat\Podman\docker.exe" "C:\Program Files\RedHat\Podman\podman.exe"
} else {
    Write-Host "✅ docker -> podman symlink already created" -ForegroundColor Green
}