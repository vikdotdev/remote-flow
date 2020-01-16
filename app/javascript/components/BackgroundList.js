import React from "react"
import PropTypes from "prop-types"
class BackgroundList extends React.Component {
  render () {
    return (
      <React.Fragment>
        Greeting: {this.props.greeting}
      </React.Fragment>
    );
  }
}

BackgroundList.propTypes = {
  greeting: PropTypes.string
};
export default BackgroundList
