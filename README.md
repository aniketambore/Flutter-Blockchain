<div align="center">
    <img src="https://q-sols.com/wp-content/uploads/2018/05/blockchain-development-services.png?raw=true" width="80px" alt="Blockchain Logo"/>
</div>

<h3 align="center">This project is meant for those with a basic knowledge of Ethereum and smart contracts, who have some knowledge of the Flutter framework but are new to mobile dapps.</h3>


<div align="center">
    <img src="README_Images/Flutter_and_Blockchain.jpg?raw=true" alt="Flutter and Blockchain Logo"/>
</div>

<div align="center">

# [Flutter and Blockchain](https://github.com/aniketambore/Flutter-Blockchain)

</div>

## Table of Contents

- [Setting up the development environment](#setting-up-the-development-environment)
- [Directory Structure](#directory-structure)
- [Compiling and Migrating Smart Contract](#compiling-smart-contract)
- [Testing the Smart Contract](#testing-the-smart-contract)
- [Contract Linking](#contract-linking)
- [Tutorials](#tutorials)
- [Contributing](#contributing)

## Setting up the development environment

Truffle is the most popular development framework for Ethereum with a mission to make your life a whole lot easier. But before we install truffle make sure to install [**node**](https://nodejs.org/en/) .

Once we have node installed, we only need one command to install Truffle:
**`npm install -g truffle`**

We will also be using [**Ganache**](http://truffleframework.com/ganache), a personal blockchain for Ethereum development you can use to deploy smart contracts, develop applications, and run tests. You can download Ganache by navigating to http://truffleframework.com/ganache and clicking the “Download” button.


## Directory Structure

<div align="center">
    <img src="README_Images/directory_structure.png?raw=true" width="70%" alt="Directory Structure"/>
</div>

- **contracts/** : Contains solidity contract file.
- **migrations/** : Contains migration script files (Truffle uses a migration system to handle contract deployment).
- **test/** : Contains test script files.
- **truffle-config.js** : Contains truffle deployment configurations information.


## Compiling and Migrating Smart Contract

### Compilation
In the terminal, make sure you are in the root of the directory that contains the flutter and truffle project, Run the following command:
**`truffle compile`**

You should see output similar to the following:
<div align="center">
    <img src="README_Images/truffle_compile_output.png?raw=true" width="70%" alt="Truffle Compile"/>
</div>

### Migration

Before we can migrate our contract to the blockchain, we need to have a blockchain running. 
We’re going to use **Ganache**, a personal blockchain for Ethereum development you can use to deploy contracts, 
develop applications, and run tests. 
If you haven’t already, download [**Ganache**](http://truffleframework.com/ganache) and double-click the icon to launch the application. This will generate a blockchain running locally on port 7545.

<div align="center">
    <img src="README_Images/ganache.png?raw=true" width="70%" alt="Ganache"/>
</div>

- Migrating the contract to the blockchain, run: **`truffle migrate`**

You should see output similar to the following:
<div align="center">
    <img src="README_Images/truffle_migrate.png?raw=true" width="70%" alt="Ganache"/>
</div>

- Take a look into the Ganache, the first account originally had 100 ether, it is now lower, due to the transaction costs of migration.

## Testing the Smart Contract

- Running the test as: **`truffle test`**
- If all the test pass, you’ll see the console output similar to this:
<div align="center">
    <img src="README_Images/truffle_test.png?raw=true" width="70%" alt="truffle test"/>
</div>

## Contract Linking

```
📁 project(eg. helloworld,bidder,...)
    📁 lib
        🎯 contract_linking.dart
          - Update _rpcUrl, _wsUrl, _privateKey as per your needs.
```
- You can get the RPC URL from the ganache :
<div align="center">
    <img src="README_Images/rpc_url.png?raw=true" width="70%" alt="truffle test"/>
</div>

- Get the Private Key from ganache:
<div align="center">
    <img src="README_Images/private_key.png?raw=true" width="70%" alt="truffle test"/>
</div>

- After Contract Linking, Just run the Flutter Project.

## Tutorials

- [Flutter and Blockchain – Hello World Dapp](https://www.geeksforgeeks.org/flutter-and-blockchain-hello-world-dapp/)
- [Flutter and Blockchain – Population Dapp](https://www.geeksforgeeks.org/flutter-and-blockchain-population-dapp/)


## Contributing:

 - Fork it!
 - Create your feature branch: `git checkout -b my-new-feature`
 - Commit your changes: `git commit -am 'Add some feature'`
 - Push to the branch: `git push origin my-new-feature`
 - Submit a pull request.





