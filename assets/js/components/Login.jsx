import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';

class Login extends Component {

  constructor(props){
    super(props);
    this.state = {
      email: '',
      password: '',
      disableSubmitButton: true
    };
    this.handleChange = this.handleChange.bind(this);
    this.login = this.login.bind(this);
    
  }

  handleChange(event){
    const target = event.target;
    const value = target.value;
    const name = target.name;
    this.setState({
      [name]: value
    });
    this.setState({
      disableSubmitButton: this.disableSubmitButton()
    });
    
  }

  login(e){
    e.stopPropagation();
    e.preventDefault();
    axios.post('/api/v1/sessions', {
      user: {
        email: this.state.email,
        password: this.state.password
      }
    })
    .then((response) => {
      this.props.onLoggedIn();
    })
    .catch((error) => {
      console.log(error);
      alert("Invalid email or password");
    });
    
  }

  disableSubmitButton(){
    return (this.state.email === '' || this.state.password === '');
  }

  render() {
    return(
      <form onSubmit={this.login} action="#">
        <div className="form-group">
          <label htmlFor="email">Email</label>
          <input type="email" className="form-control" name="email" placeholder="Email" value={this.state.email} onChange={this.handleChange}/>
        </div>

        <div className="form-group">
          <label htmlFor="password">Password</label>
          <input type="password" className="form-control" name="password" placeholder="Enter your password" value={this.state.password} onChange={this.handleChange}/>
        </div>
        <button className="btn btn-primary" disabled={this.state.disableSubmitButton}>Login</button>
      </form >
    );
  }
}


Login.propTypes = {
  onLoggedIn: PropTypes.func
};

export default Login;