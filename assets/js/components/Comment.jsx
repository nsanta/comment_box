import React, { Component } from 'react';
import PropTypes from 'prop-types';

class Comment extends Component {

  constructor(props){
    super(props);
    const divStyle = {
      borderBottom: "1px solid silver"
    };
    this.divStyle = divStyle;
  }

  
  render() {
    return(
      <div style={this.divStyle}>
        <div>Comment: {this.props.comment.message}</div>
        <div>User: {this.props.comment.user_id}</div>
        <div>Created at: {this.props.comment.inserted_at}</div>
      </div>
    );
  }
}

Comment.propTypes = {
  comment: PropTypes.object
}

export default Comment;
