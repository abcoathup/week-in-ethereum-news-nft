## Deploy

1. Deploy WeekInEthereumNewsNFT
source .env
forge script script/WeekInEthereumNewsNFT.s.sol:WeekInEthereumNewsNFTScript --rpc-url $GOERLI_RPC_URL --etherscan-api-key $ETHERSCAN_KEY --broadcast --verify -vvvv

