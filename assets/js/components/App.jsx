import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import AuthBox from './AuthBox';
import Comments from './Comments';
import CommentForm from './CommentForm';
// import socket from "./socket"

class App extends Component {

  constructor(props) {
    super(props);
    this.state = {
      boxId: props.boxId,
      loggedIn: props.loggedIn,
      comments: []
    };
    this.onLoggedIn = this.onLoggedIn.bind(this);
    this.logout = this.logout.bind(this);
    this.onCommentCreation = this.onCommentCreation.bind(this);
  }
  
  componentDidMount(){
    this.getComments();
  }

  getComments(){
    axios.get("/api/v1/boxes/" + this.props.boxId + "/comments")
    .then((response) => {
      this.setState({comments: response.data.data});
    })
  }

  onCommentCreation(comment){
    let newComments =  this.state.comments;
    newComments.push(comment);
    this.setState({
      comments: newComments
    });
    console.log(this.state.comments); 
  }

  onLoggedIn(){
    this.setState({loggedIn: true});
  }

  logout(){
    axios.delete("/api/v1/sessions")
    .then((response) => {
      this.setState({loggedIn: false});
    })
  }
  
  renderContainer() {
    if(this.state.loggedIn) {
      return (
        <div>
          <CommentForm onCommentCreation={this.onCommentCreation} boxId={this.state.boxId} />
          <div className="pull-right" ><a onClick={this.logout} href="#">Logout</a></div>
        </div>
      );
    }{
      return (<AuthBox onLoggedIn={this.onLoggedIn} />);
    }
  }

  render() {
    return(
      <div>
        <Comments commentList={this.state.comments} boxId={this.state.boxId}></Comments>
        <hr />
        {this.renderContainer()}
      </div>
    );
  }
}

App.propTypes = {
  boxId: PropTypes.string,
  loggedIn: PropTypes.bool
};

export default App;