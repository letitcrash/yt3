// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
import socket from "./socket"
import { Elm } from "../elm/src/Main.elm"

const app = Elm.Main.init({
  node: document.getElementById('elm-node'),
  flags: ""
});

const channel = socket.channel("sources:ready", {})
channel.join()

app.ports.url.subscribe(url => {
  channel.push('url', url)
})

channel.on('meta', meta => {
  console.log(meta)
  app.ports.meta.send(meta.meta)
})

channel.on('file', file => {
  console.log(file)
  app.ports.file.send(file)
})
