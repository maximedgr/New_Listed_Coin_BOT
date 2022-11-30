# New Coin Listed - BOT Telegram
This project offers you to host a telegram bot detecting the new coins listed on different chains: Ethereum, Solana, Cardano, Polygon, BSC...

You can host it directly on your machine or on a remote server to receive notifications at any time through the Telegram messaging application.

This bot uses the Coingecko listings that I recommend you to check: https://www.coingecko.com/en/new-cryptocurrencies

# Bot Configuration 
Clone this repo :
```
git clone <repo_url>
```

Enable script execution :
```
chmod u+x init.sh
chmod u+x recap.sh
```

Then run init.sh : 
```
./init.sh
```

SetUp a bot on Telegram by using @BotFather
Create a new public group and add the bot.
Request the API :[https://api.telegram.org/bot<YourBOTToken>/getUpdates](https://api.telegram.org/bot<YourBOTToken>/getUpdates)
And get yout chatid.
  
In init.sh and recap.sh edit $TOKEN and $CHATID with YOUR OWN values.

# Linux / Cron Job configuration

On your linux instance, after cloning this repo you can setup a cron job to get Telegram notification every 30min for example.
Every 24h you will get a recap : Price mean of last 24h 10 listed tokens.
Go into the project folder and run :
```
$ crontab –e
```
In the crontab terminal edit and write :
```
30 * * * * <PATH_TO_init.sh>
0 0 * * * <PATH_TO_recap.sh>
```
Close the terminal and you should get a sucess message.
```
> crontab: installing new crontab
```
You did it ! Check your telegram channel and enjoy the latest Listed Coin notifications !
