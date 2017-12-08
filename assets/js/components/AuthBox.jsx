import React, { Component } from 'react';
import Login from './Login';
import Registration from './Registration';
import PropTypes from 'prop-types';
// import socket from "./socket"

class AuthBox extends Component {

  constructor(props) {
    super(props);
    this.state = {showLogin: true};
    this.toggleContainer = this.toggleContainer.bind(this);
  }

  toggleContainer(){
    this.setState({showLogin: !this.state.showLogin});
  }

  renderContainer(){
    if (this.state.showLogin) {
      return (
        <div>
          <h4 className="text-center">Login</h4>
          <Login onLoggedIn={this.props.onLoggedIn} />
          <div className="text-center">
            <span>
              You don't have an account? <a href="#" onClick={this.toggleContainer}>Register Here!</a>
            </span>
          </div>
        </div>
      )
    } else {
      return (
        <div>
          <h4 className="text-center">Register</h4>
          <Registration  onSignedUp={this.props.onLoggedIn} />
          <div className="text-center">
            <span>
              Have an account? <a href="#" onClick={this.toggleContainer}>Go to login</a>
            </span>
          </div>
        </div>
      )
    }
  }

  render() {
    return(
      <div>
        {this.renderContainer()}
      </div>
    );
  }
}

AuthBox.propTypes = {
  onLoggedIn: PropTypes.func
};

export default AuthBox;