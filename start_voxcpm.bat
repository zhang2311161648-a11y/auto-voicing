@echo off
setlocal
cd /d "%~dp0"
echo Starting VoxCPM on http://127.0.0.1:8808/
echo First startup can take 2-3 minutes before the page is available.
echo Keep this window open while using VoxCPM.
".venv\Scripts\python.exe" -u app.py --port 8808 --device auto
