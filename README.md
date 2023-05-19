## 🌟 **Open to Work** 🌟

Hello there! 👋

If you or your team are working on projects similar to the ones you find in this GitHub repository, I'm open to collaboration and excited to contribute my skills as a developer.

I have a deep passion for developing mobile apps, and I'm eager to work on innovative and challenging tasks. You can find my resume [here](https://drive.google.com/file/d/12qOmW2rQDDKn3IwK25qbcDcJSc0GpV1W/view), which provides more details about my experience and qualifications.

If you see potential for collaboration or would like to discuss how I can contribute to your projects, please feel free to reach out to me at [aaa.software.dev@gmail.com](mailto:aaa.software.dev@gmail.com?subject=Job%20Opportunity&body=Hello,%0D%0A%0D%0AI%20am%20contacting%20you%20in%20response%20to%20your%20website%20and%20to%20inquire%20about%20your%20availability%20for%20a%20potential%20job%20opportunity%20as%20a%20software%20developer.%0D%0A%0D%0APlease%20let%20me%20know%20if%20you%20are%20interested%20in%20discussing%20further.%0D%0A%0D%0AThank%20you,%0D%0A[Your%20Name]%0D%0A[Your%20Contact%20Information]).

Thank you for taking the time to visit my repository. I look forward to potential opportunities to work together and create something amazing!

---

<div align="center">
    <img src="https://i.ibb.co/9ZhjNCj/icons8-module-96.png?raw=true" width="100px" alt="Blockchain Logo"/>
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
- [Compiling and Migrating Smart Contract](#compiling-and-migrating-smart-contract)
- [Testing the Smart Contract](#testing-the-smart-contract)
- [Contract Linking](#contract-linking)
- [DAPPS](#dapps)
- [Tutorials](#tutorials)
- [Contributing](#contributing)

## Setting up the development environment

Truffle is the most popular development framework for Ethereum with a mission to make your life a whole lot easier. But before we install truffle make sure to install [**node**](https://nodejs.org/en/) .

Once we have node installed, we only need one command to install Truffle:
**`npm install -g truffle`**

We will also be using [**Ganache**](http://truffleframework.com/ganache), a personal blockchain for Ethereum development you can use to deploy smart contracts, develop applications, and run tests. You can download Ganache by navigating to http://truffleframework.com/ganache and clicking the “Download” button.


## Directory Structure

<div align="center">
    <img src="README_Images/directory_structure.png?raw=true" width="30%" alt="Directory Structure"/>
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

## DAPPS

Hello World Dapp                                                            |   Population Dapp                                                        |
:--------------------------------------------------------------------------:|:------------------------------------------------------------------------:|
<img src="hello_world/screenshot/Screenshot_1.png?raw=true" width="340px"/> |  <img src="population/screenshot/population.gif?raw=true" width="320px"/>|


Bidder                                                           |  Minter                                                          | 
:---------------------------------------------------------------:|:----------------------------------------------------------------:|
<img src="bidder/screenshot/bidder.gif?raw=true" width="280px"/> | <img src="minter/Screenshot/minter.gif?raw=true" width="340px"/> |


Cat Adoption                                                                |  Election        |
:--------------------------------------------------------------------------:|:-----------------------------------:|
<img src="cat_adoption/screenshot/catAdoption.gif?raw=true" width="340px"/> | <img src="elections/screenshots/Screenshot_1.png?raw=true" width="300px"/> |

## Tutorials

- [Flutter and Blockchain – Hello World Dapp](https://www.geeksforgeeks.org/flutter-and-blockchain-hello-world-dapp/)
- [Flutter and Blockchain – Population Dapp](https://www.geeksforgeeks.org/flutter-and-blockchain-population-dapp/)


## Contributing:

 - Fork it!
 - Create your feature branch: `git checkout -b my-new-feature`
 - Commit your changes: `git commit -am 'Add some feature'`
 - Push to the branch: `git push origin my-new-feature`
 - Submit a pull request.


<h3 align="center">Show some ❤ and star the repo to support the project</h3>


