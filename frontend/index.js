import { ethers } from "./ethers-5.6.esm.min.js"    //module
import { nftTicketManagerAddress, nftTicketAddress, abiNftTicketManager, abiNftTicket, abiERC721 } from "./constants.js"

const connectButton = document.getElementById('connectButton');
const buyTicketButton = document.getElementById('buyTicketButton');
const balanceButton = document.getElementById('balanceButton');
const balanceETH = document.getElementById('balanceETH');
const nftMinted = document.getElementById('nftMinted');
connectButton.onclick = connect;
buyTicketButton.onclick = buyTicket;
balanceButton.onclick = getBalance;

const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();
const contractNftTicketManager = new ethers.Contract(nftTicketManagerAddress, abiNftTicketManager, signer);
const contractNftTicket = new ethers.Contract(nftTicketAddress, abiNftTicket, signer);
//const contractNft = new ethers.Contract(nftTicketAddress, abiERC721, provider);

 async function connect() {
    if (typeof window.ethereum !== 'undefined') {
        await window.ethereum.request({ method: 'eth_requestAccounts' });
        console.log('Connected!');
        connectButton.innerHTML = 'Connected!';
    } else {
        connectButton.innerHTML = 'Install Metamask';
    }
}

async function getBalance() {
    if (typeof window.ethereum !== 'undefined') {
        let accounts = await provider.send("eth_requestAccounts", []);
        let address = accounts[0];
        await provider.getBalance(address).then((balance) => {
         // convert a currency unit from wei to ether
         const balanceInEth = ethers.utils.formatEther(balance)
         balanceETH.innerHTML = `${balanceInEth} ETH`
        })
    }
}

async function buyTicket() {
    if (typeof window.ethereum !== 'undefined') {
        await contractNftTicketManager.buyTicket({ value: ethers.utils.parseEther("1") }); 
        console.log('Purchase processing')
    }
}

contractNftTicket.on("Transfer", (from, to) => {
    let info = {
        from: from,
        to: to,
    }
    console.log(info);
    const nft = contractNftTicket.tokenURI(2).then((result) => {
        console.log(result)
        nftMinted.src = result;
    });
})