import React, { Component } from 'react';
import AuthBox from 'AuthBox';
import Comments from 'Comments';
// import socket from "./socket"

export default class App extends Component {

  init(){
    getComments()
  }

  getComments(){

  }
  
  renderContainer() {
    if(this.loggedIn) {
      <Comments comments="{this.comments}"></Comments>
    }{
      <AuthBox OnLoggedIn={this.OnLoggedIn} />
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