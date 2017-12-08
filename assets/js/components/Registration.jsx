import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';

class Registration extends Component {

  constructor(props){
    super(props);
    this.state = {
      email: '',
      password: '',
      passwordConfirmation: '',
      disableSubmitButton: true
    };
    this.register = this.register.bind(this);
    this.handleChange = this.handleChange.bind(this);
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

  register(e){
    e.stopPropagation();
    e.preventDefault();
    axios.post('/api/v1/registrations', {
      user: {
        email: this.state.email,
        password: this.state.password,
        password_confirmation: this.state.passwordConfirmation
      }
    })
    .then((response) => {
      this.props.onSignedUp();
    })
    .catch((error) => {
      console.log(error)
      alert("Invalid email or password does not match");
    });
  }

  disableSubmitButton(){
    return ((this.state.email === '' || this.state.password === '') || this.state.passwordConfirmation === '');
  }

  render() {
    return(
      <div>
        <form onSubmit={this.register} action="#">
          <div className="form-group">
            <label htmlFor="email">Email</label>
            <input type="email" className="form-control" name="email" placeholder="Email" value={this.state.email} onChange={this.handleChange} />
          </div>
          <div className="form-group">
            <label htmlFor="password">Password</label>
            <input type="password" className="form-control" name="password" placeholder="Enter your password" value={this.state.password} onChange={this.handleChange} />
          </div>
          <div className="form-group">
            <label htmlFor="passwordConfirmation">Password Confirmation</label>
            <input type="password" className="form-control" name="passwordConfirmation" placeholder="Enter the password confirmation" value={this.state.passwordConfirmation} onChange={this.handleChange}/>
          </div>
          <button className="btn btn-primary" disabled={this.state.disableSubmitButton}>Register!</button>
        </form >
      </div>
    );
  }
};

Registration.propTypes = {
  onSignedUp: PropTypes.func
};

export default Registration;