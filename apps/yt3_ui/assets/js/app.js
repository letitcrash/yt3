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
const downloadButton = document.getElementById("download")
const urlInput = document.getElementById("url")
const errorMessageElement = document.getElementById("error")
const infoMessageElement = document.getElementById("info")
const audio = document.createElement('audio');
const stopSVGElement = ` 
  <svg class="video-overlay-play-button" viewBox="0 0 400 400" alt="Play">
    <rect x="100" y="100" width="200" height="200" fill="#fff"/>
  </svg>
`

const playSVGElement = `
  <svg class="video-overlay-play-button" viewBox="0 0 400 400" alt="Play">
    <polygon points="140, 110 140, 290 290, 200" fill="#fff"/>
  </svg>
`

channel.join()

channel.on("meta", payload => {
  console.log(payload)
  urlInput.disabled = true
  urlInput.value = payload.meta.title
})

const playEventHandler = (e) => {
  if(urlInput.value && !urlInput.disabled) {
    channel.push("url", {url: urlInput.value})
  }
}

const stopEventHandler = (e) => {
  audio.pause()
  playButton.removeEventListener("click", stopEventHandler)
  playButton.addEventListener("click", resumeEventHandler)
  playButton.innerHTML = playSVGElement
}

const resumeEventHandler = (e) => {
  audio.play()
  playButton.removeEventListener("click", resumeEventHandler)
  playButton.addEventListener("click", stopEventHandler)
  playButton.innerHTML = stopSVGElement
}

channel.on("file", payload => {
  console.log(payload)
  //var audio = new Audio("play?audio=" + payload.file)
  //audio.play()
  audio.src = 'play?audio=' + payload.file
  audio.play();
  playButton.innerHTML = stopSVGElement
  playButton.removeEventListener("click", playEventHandler)
  playButton.addEventListener("click", stopEventHandler)
  //downloadButton.addEventListener("click", downloadEventHandler(payload.file))
  downloadButton.style.display = "visible";
})

playButton.addEventListener("click", playEventHandler)
downloadButton.style.display = "none";


