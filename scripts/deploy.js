import { ethers } from "hardhat";

async function main() {
    const [deployer] = await ethers.getSigners();

    const Lock = await ethers.getContractFactory("Lock");
    const lock = await Lock.deploy("0x4ECd1605Ca71E8874524267eE30C03Eb80ba9A08");

    console.log("Contract address: ", lock.address);


}

main()
    .then(()=>process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })