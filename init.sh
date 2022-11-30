#!/bin/bash
curl https://www.coingecko.com/en/new-cryptocurrencies > webpage.txt
echo "Bot is running..."
echo "/!\ Top 10 New Listed Coins : " >text.txt
echo " " >>text.txt
cat webpage.txt | grep -oPz '(?<=<tr>\n)(.*\n)+?(?=</tr>)' | while read -r line ; do 
pat1='class="py-0 coin-name cg-sticky-col cg-sticky-third-col px-0"'
pat2='class="td-price price text-right"'
pat3='<span class="font-bold">.*</span>'
pat4='<i data-address='
pat5='class="td-change24h change24h stat-percent'
pat6='class="trade p-0 col-market pl-2 text-center'

if [[ $line =~ $pat1 ]];
then
name=$(echo $line | grep -Po '(?<=class="py-0 coin-name cg-sticky-col cg-sticky-third-col px-0" data-sort=.).*(?=.>)')
echo "Name: $name" >>text.txt
fi 
if [[ $line =~ $pat2 ]]; 
then
price=$(echo $line | grep -Po '[\d\.]+(?=.*class="td-price price text-right")')
echo "Price: $price$" >>text.txt
echo "$price" >> save_data.txt
fi
if [[ $line =~ $pat3 ]]; then
chain=$(echo $line | grep -Po '(?<=class="font-bold">).*(?=</span>)')
echo "Chain: $chain" >>text.txt
fi
if [[ $line =~ $pat4 ]]; then
contract=$(echo $line | grep -Po '(?<=i data-address=").*(?=" data-action=")')
if [[ $chain == "BNB Smart Chain" ]];then
echo "Contract : https://www.bscscan.com/address/$contract">>text.txt

elif [[ $chain == "Ethereum" ]]; then
echo "Contract : https://etherscan.io/address/$contract">>text.txt

elif [[ $chain == "Fantom" ]]; then
echo "Contract : https://ftmscan.com/address/$contract">>text.txt

elif [[ $chain == "Polygon POS" ]]; then
echo "Contract : https://polygonscan.com/address/$contract">>text.txt

elif [[ $chain == "Cardano" ]]; then
echo "Contract : https://cardanoscan.io/tokenPolicy/$contract">>text.txt

elif [[ $chain == "Solana" ]]; then
echo "Contract : https://explorer.solana.com/address/$contract">>text.txt

else 
echo "Contract : $contract" >>text.txt
fi
fi

if [[ $line =~ $pat5 ]];
then
ONEVAR=$(echo $line | grep -Po '(?<=td data-sort=).*(?=class="td-change24h change24h)')
echo "24h change: $ONEVAR%" >>text.txt
echo " " >>text.txt
fi 

# if [[ $line =~ $pat6 ]];
# then
# ADDED=$(echo $line | grep -Po '(?<=td class="trade p-0 col-market pl-2 text-center">).(\r\n)*(?=</td>)')
# echo $ADDED
# echo "Last Added : $ADDED hours" >>text.txt
# echo " " >>text.txt
# fi 

done

MESSAGE=$(head -n 44 text.txt) #You can change the value '44' in order to have more coin listed.
echo $MESSAGE
TOKEN='YOUR_TELEGRAM_TOKEN'
CHAT_ID='YOUR_TELEGRAM_CHAT_ID'
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE" 

rm text.txt #Delete the following 'rm' lines if you want to keep to whole token listing
rm webpage.txt
sed '11,$d' save_data.txt >> recap_data.txt
rm save_data.txt

echo "Done."


#Project by @maximedgr - 2022 | Feel free to contribute 