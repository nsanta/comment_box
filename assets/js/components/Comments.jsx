import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Comment from './Comment';
// import socket from "./socket"

class Comments extends Component {

  renderContainer(){
    if (this.props.commentList.length > 0){
      return this.props.commentList.map((comment) =>{
        return (
          <Comment key={comment.id} comment={comment}></Comment>
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
};

export default  Comments;