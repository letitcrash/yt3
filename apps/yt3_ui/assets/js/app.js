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

const channel = socket.channel("sources:ready", {})
const playButton = document.getElementById("play")
const urlInput = document.getElementById("url")
const errorMessageElement = document.getElementById("error")
const infoMessageElement = document.getElementById("info")

channel.join()

channel.on("meta", payload => {
  console.log(payload)
})

channel.on("file", payload => {
  console.log(payload)
  //var audio = new Audio("play?audio=" + payload.file)
  //audio.play()
  var audio = document.createElement('audio');
  audio.src = 'play?audio=' + payload.file
  audio.play();
})

playButton.addEventListener("click", (e) => {
  if(urlInput.value) {
    channel.push("url", {url: urlInput.value})
  }
})

