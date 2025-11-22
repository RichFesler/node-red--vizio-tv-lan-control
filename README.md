# Vizio SmartCast Local Control (Linux + Node-RED)

This project provides **fully local control** of Vizio SmartCast televisions using:
- A lightweight Bash control script  
- Local HTTPS SmartCast API  
- Node-RED for automation and dashboard control  

No cloud APIs. No external dependencies. Entirely LAN-based.

---

## Features

- Power toggle  
- Volume up / down  
- Mute toggle  
- Input menu  
- D-pad navigation (up / down / left / right / enter)  
- Home button  
- Script-driven structure: simple one-word commands  
- Node-RED flow with clean UI buttons  
- Works even when the TV “appears off” if **Quick Start+** is enabled  

---

## Requirements

- Vizio SmartCast TV  
- Linux host on the same LAN  
- Node-RED installed on that host  
- TV setting:  
  **Settings → System → Power Mode → Quick Start+ = ON**  
- `curl` installed  

---

## 1. Pairing with SmartCast

### 1.1 Start pairing  
Replace `<TV_IP>` with your TV’s IP.

```bash
curl -ks -X PUT \
  "https://<TV_IP>:7345/pairing/start" \
  -H "Content-Type: application/json" \
  -d '{"DEVICE_NAME":"linux_box","DEVICE_ID":"linux_box_01"}'
