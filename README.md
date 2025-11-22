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

## Steps

1. Discover your Vizio TV on the LAN

You identify the TV’s local IP address—for example:

192.168.x.x

SmartCast listens on TCP port 7345 for HTTPS API commands.


2. Pair your Linux device with the TV

SmartCast requires a one-time pairing:

Send a pairing/start request

TV displays a 4-digit PIN

Send a pairing/pair request with that PIN

TV returns a persistent AUTH_TOKEN

This token functions like a password for all future commands.


3. Verify the local SmartCast API works

Use curl to query and control the TV:

Check power mode

Send key commands (power, volume, navigation, etc.)

This confirms that the TV is reachable and correctly paired.


4. Create a command-line control script (vizio_key.sh)

A single shell script wraps all SmartCast key codes into simple commands:

./vizio_key.sh power
./vizio_key.sh volup
./vizio_key.sh home

The script sends HTTPS SmartCast commands using your AUTH_TOKEN.


5. Integrate with Node-RED

Node-RED executes the same script:

An Inject node sends text: power, volup, left, etc.

An Exec node runs the script using that payload

Buttons appear in the Node-RED flow/UI

The TV responds instantly

This creates a local web-based remote control.
