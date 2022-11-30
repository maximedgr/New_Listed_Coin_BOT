#!/bin/bash
value=$(awk '{T+= $NF} END { print T/NR }' recap_data.txt)
echo "-> 24H RECAP : " >recap.txt
echo "Price mean of last 24h 10 listed tokens : "$value"$" >>recap.txt

MESSAGE=$(head recap.txt) 
TOKEN='YOUR_TELEGRAM_TOKEN'
CHAT_ID='YOUR_TELEGRAM_CHAT_ID'
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE" 

echo $MESSAGE
rm recap_data.txt
rm recap.txt
