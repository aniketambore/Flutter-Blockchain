module.exports = {
  networks: {
     development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 7545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
     },
     advanced: {      // Account to send txs from (default: accounts[0])
     websockets: true        // Enable EventEmitter interface for web3 (default: false)
     },
  },

  contracts_build_directory: "./src/abis/",
  // Configure your compilers
  compilers: {
    solc: {         // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: true,
          runs: 200
        },
    }
  }
};
