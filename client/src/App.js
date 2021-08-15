import React, { Component } from "react";
import SimpleStorageContract from "./contracts/SimpleStorage.json";
import getWeb3 from "./getWeb3";
import Meme from '../abis/DEHR.json'
import ipfs from "./ipfs";

import "./App.css";
import AdminDashboard from './dashboard-admin'
import OrganDonnerDashboard from './dashboard-organDonner'
import OrganApplicantDashboard from './dashboard-organApplicant'
import MedicalStuffDashboard from './dashboard-medicalStuff'
import Login from './login'

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      web3: null, 
      userRole:'user',
      accounts: null, 
      DEHRContract: null,
      donners:[],
      applicants:[],
      donateOffer:[],
      loading:true,
     }


     //this.checkUserRole= this.checkUserRole.bind(this)
     this.addDonner = this.addDonner.bind(this)
     this.addApplicant = this.addApplicant.bind(this)
     this.addDonateOffer = this.addDonateOffer.bind(this)
     this.DonateRequest = this.DonateRequest.bind(this)
     
  }

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();

      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = DEHRContract.networks[networkId];
      const DEHRContractInstance = new web3.eth.Contract(
        DEHRContract.abi,
        deployedNetwork && deployedNetwork.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.


      this.setState({ 
        web3,
        userRole:'user',
        accounts, 
        DEHRContract:DEHRContractInstance,
       donners:[],
        applicants:[],
        donateOffer:[],
        loading:true,}, this.checkUserRole); 
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };



  checkUserRole = async () => {
    // try {  
     const isAdmin = await this.state.DEHRContract.methods.isAdmin(this.state.accounts[0]).call();
     const isOrganDonner = await this.state.DEHRContract.methods.isOrganDonner(this.state.accounts[0]).call();
     const isOrganApplicant = await this.state.DEHRContract.methods.isOrganApplicant(this.state.accounts[0]).call();
     const isMedicalStuff = await this.state.DEHRContract.methods.isMedicalStuff(this.state.accounts[0]).call();
  
     if(isAdmin)
     {
       this.setState({userRole:'admin'}, this.loadMarketAdmins);
       this.setState({ loading: false});
     }
     else if(isOrganDonner)
     {
       this.setState({userRole:'organDonner'}, this.loadStoreOwner);
       this.setState({ loading: false});
     }
     else if(isOrganApplicant)
     {
       this.setState({userRole:'organApplicant'}, this.loadStores);
       this.setState({ loading: false});
     }
     else if(isMedicalStuff)
     {
       this.setState({userRole:'medicalStuff'}, this.loadStores);
       this.setState({ loading: false});
     }
     else
     {
       this.setState({userRole:'user'}, this.loadStores);
       this.setState({ loading: false});
     }




    };


    renderDashboard(){
      if(this.state.userRole==='admin')
        return <AdminDashboard 
        />
      if(this.state.userRole==='organDonner')
        return <OrganDonnerDashboard 
        />
        if(this.state.userRole==='organApplicant')
          return <OrganApplicantDashboard 

          />
          if(this.state.userRole==='medicalStuff')
          return <MedicalStuffDashboard 
          />
          if(this.state.userRole==='user')
          return <Login 
          />
  };

  addDonner(accountAdddress){
    this.setState({loading:true});
     this.state.DEHRContractInstance.methods.addDonner(accountAdddress).send({from:this.state.accounts[0]})
    .once('receipt', (receipt) => {
      this.setState({ loading: false })
    })

  };

  addDonner(accountAdddress){
    this.setState({loading:true});
     this.state.DEHRContractInstance.methods.addApplicant(accountAdddress).send({from:this.state.accounts[0]})
    .once('receipt', (receipt) => {
      this.setState({ loading: false })
    })

  };

  addDonateOffer(accountAdddress){
    this.setState({loading:true});
    this.state.marketplaceContract.methods.donateOffer(accountAdddress).send({from:this.state.accounts[0]})

      
    .once('receipt', (receipt) => {
      
      this.setState({ loading: false })
    })

  };

  removeStoreOwner(accountAdddress){
    this.setState({loading:true});
    this.state.marketplaceContract.methods.removeStoreOwner(accountAdddress).send({from:this.state.accounts[0]})

    .once('receipt', (receipt) => {
      this.setState({ loading: false })
    })

  };

  async addStore(name){
    this.setState({loading:true});
    console.log('name:', name)
    let result=this.state.marketplaceContract.methods.addStore(name).send({from:this.state.accounts[0]})
    .once('receipt', (receipt) => {
      console.log('result:',result)
      console.log('receipt:',receipt)
      this.setState({ loading: false })
    })
  };

  removeStore(storeId){
    this.setState({loading:true});
    this.state.marketplaceContract.methods.removeStore(storeId).send({from:this.state.accounts[0]})
    .once('receipt', (receipt) => {
      this.setState({ loading: false })
    })

  };




  async loadBlockchainData() {

    this.setState({ account: accounts[0] })
    const networkId = await web3.eth.net.getId()
    const networkData = DEHR.networks[networkId]
    if(networkData) {
      const contract = web3.eth.Contract(DEHR.abi, networkData.address)
      this.setState({ contract })
      const DEHR_Hash = await contract.methods.GetGenHashInfo().call()
      this.setState({ DEHR_Hash })
    } else {
      window.alert('Smart contract not deployed to detected network.')
    }
  }

  downloadTxtFile = () => {
    const file = new Blob("someinfo", {type: 'text/plain'});
    element.href = URL.createObjectURL(file);
  }

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }
    return (
      <div className="App">
        <h1>Good to Go!</h1>
        <p>Your Truffle Box is installed and ready.</p>
        <h2>Smart Contract Example</h2>
        <p>
          If your contracts compiled and migrated successfully, below will show
          a stored value of 5 (by default).
        </p>
        <p>
          Try changing the value stored on <strong>line 42</strong> of App.js.
        </p>
        <div>The stored value is: {this.state.storageValue}</div>
      </div>
    );
  }
}

export default App;
