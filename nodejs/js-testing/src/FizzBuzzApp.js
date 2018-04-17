import React, { Component } from 'react'

export default class FizzBuzzApp extends Component {
  constructor(props) {
    super(props)
    this.state = {count: 0}
  }
  countUp() {
    this.setState({count: this.state.count + 1})
  }
  convertFizzBuzz(int) {
    if (int == 0) {
      return 'Click button'
    } else if ((int % 3 == 0) && (int % 5 == 0)) {
      return 'FizzBuzz'
    } else if (int % 3 == 0) {
      return 'Fizz'
    } else if (int % 5 == 0) {
      return 'Buzz'
    } else {
      return String(int)
    }
  }
  render() {
    return (
      <div>
        <h1>FizzBuzz</h1>
        <button id="button" onClick={() => this.countUp()}>Button</button>
        <div id="result" >{this.convertFizzBuzz(this.state.count)}</div>
      </div>
    )
  }
}
