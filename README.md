# Remix Deployment Guide for Decentralised_Music_marketplace

Prerequisites:

Remix IDE: [https://remix.ethereum.org/](https://remix.ethereum.org/)

Steps:

1. Creating the Code:
   * Open Remix and create a new file.
   * Wrute the `Decentralised_Music_marketplace.sol` code into the file.

2. Select Compiler Settings:
   * Go to the "Compile" tab.
   * Choose the desired Solidity compiler version (e.g., 0.8.0).

3. Compile the Contract:
   * Click the "Compile" button.
   * If there are no compilation errors, you'll see the compiled bytecode and ABI.

4. Deploy the Contract:
   * Go to the "Deploy & Run" tab.
   * Select the compiled contract from the dropdown.
   * Choose the environment where you want to deploy (e.g., JavaScript VM(VM Cancun in our case), Injected Web3).
   * If you're using a local or test network, ensure you have a running node and have connected to it in Remix.
   * Provide any required parameters for the contract constructor (if applicable).
   * Click the "Deploy" button.

5. Interact with the Contract:
   * Once deployed, you'll see the contract's address and functions in the "Deploy & Run" tab.
   * Use the functions to interact with the contract, such as registering artists, uploading songs, purchasing songs, etc.

Example Usage:

* Register an artist:
   * Call the `registerArtists` function with the desired artist name.
* Register an listener:
   * Call the `registerListener` function with the desired listener name.
* Upload a song:
   * Call the `songUpload` function with the song name, price, and artist name.
* Purchase a song:
   * Call the `BuyA_Song` function with the song ID and send the required amount of Ether.
* Donate to a Artist:
   * Call the `Donate_Artist` function with the artist address and donate the required amount of Ether.

Note:

* There is Event notification for each of the event so you'll get desired information about whats going on with detailed indexed value if possible.
* Ensure you have sufficient funds in your connected wallet to pay for gas fees when deploying and interacting with the contract.
* For more complex interactions or testing on a public network, you might need to use a tool like Truffle or Hardhat.
* Always test your contract thoroughly on a test network before deploying to a mainnet.

By following these steps, you can successfully deploy and use the `Decentralised_Music_marketplace` contract in Remix.
