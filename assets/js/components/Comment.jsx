import React, { Component } from 'react';
import PropTypes from 'prop-types';

class Comment extends Component {

  render() {
    return(
      <div style="border-bottom: 1px solid silver;">
        <div>{this.props.comment.message}</div>
        <div>{this.props.comment.user_id}</div>
        <div>{this.props.comment.inserted_at}</div>
      </div>
    );
  }
}

Comment.propTypes = {
  comment: PropTypes.object
}

export default Comment;
