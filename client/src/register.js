import React, { Component } from 'react';
class Register extends Component {

    captureFile = (event) => {
        event.preventDefault()
        const file = event.target.files[0]
        const reader = new window.FileReader()
        reader.readAsArrayBuffer(file)
        reader.onloadend = () => {
          this.setState({ buffer: Buffer(reader.result) })
          console.log('buffer', this.state.buffer)
        }
      }
      
      onSubmit = (event) => {
        event.preventDefault()
        console.log("Submitting file to ipfs...")
        ipfs.add(this.state.buffer, (error, result) => {
          console.log('Ipfs result', result)
          if(error) {
            console.error(error)
            return
          }
           this.state.contract.methods.set(result[0].hash).send({ from: this.state.account }).then((r) => {
             return this.setState({ memeHash: result[0].hash })
           })
        })
      }

render() {
    return (
      <div>
        <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
          <a
            className="navbar-brand col-sm-3 col-md-2 mr-0"
            target="_blank"
          >
            Upload Gene Info
          </a>
        </nav>
        <div className="container-fluid mt-5">
          <div className="row">
            <main role="main" className="col-lg-12 d-flex text-center">
              <div className="content mr-auto ml-auto">
                <a
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <img src={`https://ipfs.infura.io/ipfs/QmcB5BuYFYxFTQquwuxu7qau7gFFNx8E3ZyeAuLEEqkUkp`} />
                </a>
                <p>&nbsp;</p>
                <h2>Upload Or Upgrade Gene</h2>
                <form onSubmit={this.onSubmit} >
                  <input type='file' onChange={this.captureFile} />
                  <input type='file' onChange={this.captureFile} />
                  <input type='submit' />

                </form>
              </div>
            </main>
          </div>
        </div>
      </div>
    );
  }


}
export default Register;
