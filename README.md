# coinflip
Problem Statement: Using the Harmony testnet and Harmony VRF, create a "Coin Flip" betting game in Solidity (Verifiable Random Function).

Solidity, Math Wallet, and Ethereum Smart Contracts make up the tech stack.

Solution Suggestion

How to Set Up Math Wallet
MathWallet is a multi-chain wallet with over 1.2 million users that supports 60+ blockchains like BTC, ETH, Polkadot, Filecoin, Solana, BinanceChain, and more.

Step 1: Navigate to the Extensions section of the Browser Web Store.
Step 2: Look for Math Wallet on the internet.
Step 3: Download and install the Math Wallet Extension.
Step 4: After installing the app, click the Create a Wallet button to make a new wallet.
Step 5: To set up your account and store your secret phrase, follow the on-screen instructions.
Step 6: Add a Harmony Testnet Network to the networks area and connect to it.
Step 7: Get ONE tokens for free on the testnet (via Faucet). https://faucet.pops.one/


Smart Contract :-
1. Remix IDE - Harmony was used to create the CoilFlipGame smart contract and write the solidity code.
2. Allows a user to bet on a specific outcome of a coin flip using a function that accepts amount = integer and bet = 0 or 1 signifying heads or tails, among other characteristics.
3.By default, each user's address will receive one ONE coin (equivalent to 100 points as specified in the problem statement), which will be stored in the user's balance as a mapping.
4. A struct Bet is generated that contains information about a user's bet, such as the bet amount, the bet made 0/1, the payout the user will receive after each bet, the result of the bet, and if the bet is ongoing or completed. Mappings store the structure.
5. When a user places a wager, the amount is debited from their account balance.
6. A user cannot place a bet if they already have one that is undecided.
7. To end all bets with a win/loss, a function is constructed.
8. Because standard random functions cannot be used on blockchain, Harmony VRF (Verifiable Random Functions) was used to generate a random integer.
9. If the generated random number is even, it is regarded 0 (heads), and if it is odd, it is considered 1 (tails).
10.If a user wins, they will be credited with a sum equal to their stake multiplied by two.
11.There is no balance transfer if a user wins.

	
