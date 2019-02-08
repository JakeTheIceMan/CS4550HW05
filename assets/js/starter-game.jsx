import React from 'react';
import ReactDOM from 'react-dom';
import _ from 'lodash';

export default function game_init(root, channel) {
  console.log("HEEE");
  ReactDOM.render(<Starter channel={channel}/>, root);
}

class Starter extends React.Component {
  constructor(props) {
    console.log("CONSING");
    super(props);
    this.channel = props.channel;
    this.channel
        .join()
        .receive("ok", this.got_view.bind(this))
        .receive("error", resp => { console.log("Unable to join", resp); });
    this.state = {
      clicks: 0,
      tiles: ["", "", "", "", "", "", "", "","", "", "", "", "", "", "", ""]
    }
  }
//n
  got_view(view) {
    console.log("new view", view);
    this.setState(view.game);
  }

//n
  on_flip(ev) { 
    if (_ev.target.id <= 15 && _ev.target.id >= 0) {
      this.channel.push("flip", { tileNum: ev.target.id })
                  .recieve("ok", this.got_view.bind(this));
    }
  }

//r
  make_button(num) {
    return <div className="column" onClick={this.on_flip.bind(this)}>
             <div className="button" id={num}>{this.state.tiles[num]}</div>
           </div>;
  }

//n
  restart() {
    this.channel.push("restart")
                .recieve("ok", this.got_view.bind(this));
  }

//r
  render() {
    return <div>
      <div className="column" onClick={this.restart.bind(this)}>
             <div className="button">Restart</div>
             </div>
      <p>Score: {parseInt(1000000 / Math.max(parseInt(this.state.clicks/2)-7, 1))}</p>
      <p>Clicks: {this.state.clicks}</p>
      <div className="row">
        {this.make_button(0)}
        {this.make_button(1)}
        {this.make_button(2)}
        {this.make_button(3)}
      </div>
      <div className="row">
        {this.make_button(4)}
        {this.make_button(5)}
        {this.make_button(6)}
        {this.make_button(7)}
      </div>
      <div className="row">
        {this.make_button(8)}
        {this.make_button(9)}
        {this.make_button(10)}
        {this.make_button(11)}
      </div>
      <div className="row">
        {this.make_button(12)}
        {this.make_button(13)}
        {this.make_button(14)}
        {this.make_button(15)}
      </div>
    </div>;
  }
}

