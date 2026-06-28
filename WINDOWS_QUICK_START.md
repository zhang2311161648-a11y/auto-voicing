# Windows Quick Start

This repository contains the VoxCPM web demo source.

## Requirements

- Python 3.10, 3.11, or 3.12
- For fast generation: NVIDIA GPU with CUDA 12+

CPU mode can start the web UI, but VoxCPM2 generation can be very slow.

## Setup

```powershell
cd "D:\DOCKING AUTO\auto-voicing"
py -3.11 -m venv .venv
.\.venv\Scripts\python.exe -m pip install --upgrade pip
.\.venv\Scripts\python.exe -m pip install -e .
```

## Start

```powershell
.\start_voxcpm.bat
```

Then open:

```text
http://127.0.0.1:8808/
```

Keep the PowerShell window open while using the app.
