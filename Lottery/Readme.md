## Lottery Smart Contract

#### How It Works

1. At least three addresses need to participate and participants can only send intervals of 0.1 Ether at a time. The Owner of the contract cannot play.
2. Only the contract owner can view the balance.
3. Algorithm used to create random number should never go to Prod. Chainlink VRF should be used instead.
4. Only the manager can run the pickWinner() function and this function only runs if there are more than 2 addresses playing. With this function, a random player is chosen, 90% of the balance is sent to the winner and 10% sent to the contract owner.

#### How To Deploy (Testing only)

1. Change Metmask to the Rinkeby Test Network
2. Open contract in Remix IDE, Compile, and set deployment environment to Injected Web3. Connect to Metamask.
3. Once connected click Deploy. (This address will be the contract owner and cannot play).

