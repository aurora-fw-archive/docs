Requirements:
- msys2: http://www.msys2.org/
- git-repo: https://github.com/esrlabs/git-repo
- python2.7: https://www.python.org/downloads/
- git: https://git-scm.com/download/win

Add to PATH, environment variable:
- C:\Program Files (x86)\Git\cmd
- C:\Program Files (x86)\Git\bin
- C:\Python27
- C:\AuroraFW-build\bin


```
mkdir -p /c/AuroraFW-build/bin/
curl https://raw.githubusercontent.com/esrlabs/git-repo/stable/repo > /c/AuroraFW-build/bin/repo
curl https://raw.githubusercontent.com/esrlabs/git-repo/stable/repo.cmd > /c/AuroraFW-build/bin/repo.cmd
repo init -u https://github.com/aurora-fw/manifest.git
repo sync
pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-cmake mingw-w64-x86_64-make mingw-w64-x86_64-pkg-config mingw-w64-x86_64-gtk3 mingw-w64-x86_64-freeimage mingw-w64-x86_64-glew mingw-w64-x86_64-glfw mingw-w64-x86_64-libsndfile mingw-w64-x86_64-portaudio
```