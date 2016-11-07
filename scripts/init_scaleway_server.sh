#!/usr/bin/env bash

spin() {
   printf "\b${sp:sc++:1}"
   ((sc==${#sp})) && sc=0
}

BASE_URL=https://cp-par1.scaleway.com
ORGA_ID="e2b75923-ac57-439f-b3e7-0d1f2db2ac07"

# Remove server key from know host to avoid error on next ssh connection
ssh-keygen -f ~/.ssh/known_hosts -R $IP
ssh-keygen -f ~/.ssh/known_hosts -R $BASE_DOMAIN

SERVER_OUTPUT=$(curl -s -X POST -H "X-Auth-Token: $SCALEWAY_TOKEN" -H "Content-Type: application/json" $BASE_URL/servers -d \
"{ \
  \"organization\": \"$ORGA_ID\", \
  \"name\": \"Dokku conf\", \
  \"image\": \"15fd0f74-c939-43c3-bf41-ee5f711b3bb4\", \
  \"commercial_type\": \"VC1S\", \
  \"tags\": [ \
    \"dokku\",\
    \"conference\" \
  ], \
  \"enable_ipv6\": false \
}")
SERVER_ID=$(echo $SERVER_OUTPUT | jq '.server.id' | sed -e 's/^"//' -e 's/"$//')


echo $SERVER_ID > serverid

echo "Created server $(echo $SERVER_OUTPUT | jq '.server.name')"

curl -X PUT -H "X-Auth-Token: $SCALEWAY_TOKEN" -H "Content-Type: application/json" $BASE_URL/ips/$SCALEWAY_IP_ID -d \
"{
  \"address\": \"$IP\",
  \"id\": \"e539db75-e4ac-4358-944c-b9c6ec99376b\",
  \"organization\": \"$ORGA_ID\",
  \"server\": \"$SERVER_ID\",
  \"reverse\": null
}"
echo
echo "IP $IP affected to server"

curl -X POST -H "X-Auth-Token: $SCALEWAY_TOKEN" -H "Content-Type: application/json" $BASE_URL/servers/$SERVER_ID/action -d '{"action": "poweron"}'
echo
echo "Server is starting ..."

STATUS="stopped"
while [[ "$STATUS" !=  "\"running\"" ]]; do
  sleep 20
  STATUS=$(curl -s -H "X-Auth-Token: $SCALEWAY_TOKEN" $BASE_URL/servers/$SERVER_ID | jq '.server.state')
done
echo -ne "Server started"
sleep 30
