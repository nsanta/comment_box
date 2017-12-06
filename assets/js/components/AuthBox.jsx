import React, { Component } from 'react';
import Login from 'Login';
import Registration from 'Registration';
// import socket from "./socket"

export default class AuthBox extends Component {


  renderContainer(){
    if (showLogin) {
      return (
        <Login />
      )
    } else {
      return (
        <Registration />
      )
    }
  }

  render() {
    return(
      <div>
        Ahoy
      </div>
    );
  }
}