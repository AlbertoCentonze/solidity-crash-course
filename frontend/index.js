import { ethers } from "./ethers-5.6.esm.min.js"    //module
import { NftTicketManagerAddress, NftTicketAddress, abiNftTicketManager, abiNftTicket, abiERC721 } from "./constants.js"

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
const contract2 = new ethers.Contract(NftTicketAddress, abiERC721, provider);
const contract3 = new ethers.Contract(NftTicketAddress, abiNftTicket, signer);

 async function connect() {
    if (typeof window.ethereum !== 'undefined') {
        await window.ethereum.request({ method: 'eth_requestAccounts' });
        console.log('Connected!');
        connectButton.innerHTML = 'Connected!';
    } else {
        connectButton.innerHTML = 'Install Metamask';
    }
}

contract2.on("Transfer", (from, to, value) => {
    let info = {
        from: from,
        to: to,
        value: value,
    }
    console.log(info);
    const nft = contract3.tokenURI(2).then((result) => {
        console.log(result)
        nftMinted.src = result;
    });
})

async function buyTicket() {
    if (typeof window.ethereum !== 'undefined') {
        const contract = new ethers.Contract(NftTicketManagerAddress, abiNftTicketManager, signer);
        await contract.buyTicket({ value: ethers.utils.parseEther("1") }); 
        console.log('minted')
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

