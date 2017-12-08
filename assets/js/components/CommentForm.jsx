import React, { Component } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';

class CommentForm extends Component {

  constructor(props){
    super(props);
    this.state = {
      message: ""
    }
    this.handleChange = this.handleChange.bind(this);
    this.createComment = this.createComment.bind(this);
  }

  handleChange(event){
    const target = event.target;
    const value = target.value;
    const name = target.name;
    this.setState({
      [name]: value
    });
  }

  createComment(e){
    e.stopPropagation();
    e.preventDefault();
    axios.post('/api/v1/boxes/' + this.props.boxId + '/comments', {
      comment: {
        message: this.state.message
      }
    })
    .then((response) => {
      this.props.onCommentCreation(response.data.data);
      this.setState({
        message: ''
      })
    })
    .catch((error) => {
      console.log(error);
    });
    
  }


  render() {
    return(
      <form onSubmit={this.createComment} action="#">
        <div className="form-group">
          <textarea className="form-control" name="message" placeholder="Bring your comment." value={this.state.message} onChange={this.handleChange}></textarea>
        </div>
        <button className="btn btn-primary" disabled={this.state.message == ""} >Send</button>
      </form >
    );
  }
}

CommentForm.propTypes = {
  boxId: PropTypes.string,
  onCommentCreation: PropTypes.func
};

export default CommentForm;