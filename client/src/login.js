import React, { Component } from 'react';

class UserDashboard extends Component {

    renderUserDashboard(){
    <div>
        <h2>Register as Donner</h2>
      
                    <button
                    name={store.name}
                    value={store.id}
                        onClick={(event) => {
                          this.setState({ storeId: event.target.value},() => this.loadProducts())
                          this.showStore(event);
                          
                        }}
                      >
                        Register as Donner
                    </button> 
                <h2>Register as Applicant</h2>
      
                    <button
                    name={store.name}
                    value={store.id}
                        onClick={(event) => {
                          this.setState({ storeId: event.target.value},() => this.loadProducts())
                          this.showStore(event);
                          
                        }}
                      >
                        Register as Applicant
                </button> 

                <h2>Register as Medical Stuff</h2>
      
      <button
      name={store.name}
      value={store.id}
          onClick={(event) => {
            this.setState({ storeId: event.target.value},() => this.loadProducts())
            this.showStore(event);
            
          }}
        >
          Register as Medical Stuff
  </button> 

      </div>;
   

}





render() {
    return (
        <div id="login-panel">
        {
          this.state.loadingDashboard
          ? <div id="loader" className="text-center"><p className="text-center">Loading...</p></div>
          : this.renderUserDashboard()
        }
        </div>

        );
}
}
export default Login;