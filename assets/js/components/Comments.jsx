import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Comment from './Comment';
// import socket from "./socket"

class Comments extends Component {

  constructor(props){
    super(props);
    console.log(props.commentList);
    this.state = {
      comments: []
    };
  }

  componentWillMount(){
    console.log(this.props.commentList);
    this.setState({
      comments: this.props.commentList
    });
  }

  renderContainer(){
    if (this.state.comments.length > 0){
      this.state.comments.map((comment) =>{
        return (
          <Comment comment={comment}></Comment>
        );
      });
    } else {
      return (
        <h4 className="text-center">No Comments yet. Be the first one on start the experience.</h4>
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
};

Comments.propTypes = {
  commentList: PropTypes.array
}

export default  Comments;