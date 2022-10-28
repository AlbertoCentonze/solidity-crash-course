import { ethers } from "./ethers-5.6.esm.min.js"    //module
import { contractAddress, abi } from "./constants.js"

const connectButton = document.getElementById('connectButton');
const buyTicketButton = document.getElementById('buyTicketButton');
const balanceButton = document.getElementById('balanceButton');
const balanceETH = document.getElementById('balanceETH')
connectButton.onclick = connect;
buyTicketButton.onclick = buyTicket;
balanceButton.onclick = getBalance;

const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();

async function connect() {
    if (typeof window.ethereum !== 'undefined') {
        await window.ethereum.request({ method: 'eth_requestAccounts' })
        connectButton.innerHTML = 'Connected!';
    } else {
        connectButton.innerHTML = 'Install Metamask';
    }
}

async function buyTicket() {
    if (typeof window.ethereum !== 'undefined') {
        const contract = new ethers.Contract(contractAddress, abi, signer);
        const mint = await contract.buyTicket({ value: ethers.utils.parseEther("1") }); 
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