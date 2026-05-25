wget https://github.com/google/filament/releases/download/v1.71.4/filament-v1.71.4-windows.tgz -OutFile filament.tgz
mkdir bin
cd bin
tar -xzf ../filament.tgz --strip-components=1 "bin"
cd ..