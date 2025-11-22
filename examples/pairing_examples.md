# SmartCast Pairing Examples

## Start pairing

curl -ks -X PUT \
  "https://<TV_IP>:7345/pairing/start" \
  -H "Content-Type: application/json" \
  -d '{"DEVICE_NAME":"linux_box","DEVICE_ID":"linux_box_01"}'

curl -ks -X PUT \
  "https://<TV_IP>:7345/pairing/pair" \
  -H "Content-Type: application/json" \
  -d '{
    "DEVICE_ID": "linux_box_01",
    "CHALLENGE_TYPE": 1,
    "RESPONSE_VALUE": <PIN>,
    "PAIRING_REQ_TOKEN": <TOKEN>
  }'
