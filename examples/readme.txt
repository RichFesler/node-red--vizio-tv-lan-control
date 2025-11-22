SmartCast Pairing Explained

The Vizio SmartCast local API requires a one-time device pairing.
Your Linux box identifies itself to the TV, the TV displays a 4-digit PIN, and you return that PIN to obtain an AUTH_TOKEN.

Below is a line-by-line explanation of the two required curl commands.

1. Start Pairing
curl -ks -X PUT \
  "https://<TV_IP>:7345/pairing/start" \
  -H "Content-Type: application/json" \
  -d '{"DEVICE_NAME":"linux_box","DEVICE_ID":"linux_box_01"}'

What it does

This command tells the TV:

“A new device (your Linux box) wants to pair.”

SmartCast responds by displaying a 4-digit PIN on the TV screen.

Field explanations
Field	Meaning
"DEVICE_NAME"	A friendly name that appears on the TV during pairing (any string).
"DEVICE_ID"	A unique identifier for your device (must remain consistent across pairings).
PUT /pairing/start	Command to initiate pairing mode.
PIN on TV	The TV now waits for you to prove you saw the code.
What you receive

Example response:

{
  "ITEM": {
    "PAIRING_REQ_TOKEN": 399683,
    "CHALLENGE_TYPE": 1
  },
  "STATUS": { "RESULT": "SUCCESS" }
}


You must save:

PAIRING_REQ_TOKEN → session identifier

PIN displayed on the TV → you manually read this

Both are required for the second step.

2. Complete Pairing
curl -ks -X PUT \
  "https://<TV_IP>:7345/pairing/pair" \
  -H "Content-Type: application/json" \
  -d '{
        "DEVICE_ID": "linux_box_01",
        "CHALLENGE_TYPE": 1,
        "RESPONSE_VALUE": <PIN_FROM_TV>,
        "PAIRING_REQ_TOKEN": <TOKEN_FROM_STEP_1>
      }'

What it does

This command tells the TV:

“Here is the PIN you showed me and the token you gave me. Please pair with this device.”

If both values match, the TV returns a long-term AUTH_TOKEN.

Field explanations
Field	What it means
"DEVICE_ID"	Must match the same ID used in /pairing/start
"CHALLENGE_TYPE": 1	Indicates a PIN-based challenge/response pairing
"RESPONSE_VALUE"	The 4-digit PIN displayed on the TV
"PAIRING_REQ_TOKEN"	The numeric token returned in the first step
What the TV returns

If successful, the response contains:

"AUTH_TOKEN": "xxxxxxxxxx"


This AUTH_TOKEN is your permanent credential.
You store it in your script and use it for all future commands.

Why Pairing Is Required

SmartCast uses pairing to ensure:

Only devices physically present (you can see the PIN) can control the TV

No remote attackers can send commands without authorization

Each device gets a unique token that can be revoked/reset

Once complete, the TV will trust your Linux box indefinitely (until factory reset or pairing reset).

Summary of the Pairing Workflow

Send /pairing/start
TV returns a token → TV displays a PIN.

Send /pairing/pair
Include both:

PIN from TV

Token from step 1

TV returns your AUTH_TOKEN
Save it.
Use it in all HTTPS commands:

-H "AUTH: <AUTH_TOKEN>"


That’s the entire pairing system.
