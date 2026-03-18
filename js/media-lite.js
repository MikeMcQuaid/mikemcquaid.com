document.addEventListener("click", function (e) {
  var button = e.target.closest(".youtube-lite-button");
  if (button) {
    e.preventDefault();
    var wrapper = button.closest(".youtube-lite");
    loadYouTubeIframe(wrapper, wrapper.dataset.videoId);
    return;
  }

  var deckButton = e.target.closest(".speakerdeck-lite-button");
  if (deckButton) {
    e.preventDefault();
    var deckWrapper = deckButton.closest(".speakerdeck-lite");
    var deckIframe = document.createElement("iframe");
    deckIframe.className = "interview-media-embed";
    deckIframe.style.aspectRatio = deckWrapper.dataset.ratio || "1.77777777777778";
    deckIframe.setAttribute("allowfullscreen", "");
    deckIframe.src = "https://speakerdeck.com/player/" + deckWrapper.dataset.deckId;
    deckWrapper.replaceWith(deckIframe);
    return;
  }

  var tsLink = e.target.closest(".transcript-timestamp[data-timestamp]");
  if (!tsLink) return;

  e.preventDefault();

  if (tsLink.dataset.audioUrl) {
    var audio = document.querySelector('audio[src="' + tsLink.dataset.audioUrl + '"]');
    if (audio) {
      audio.currentTime = parseInt(tsLink.dataset.timestamp, 10);
      audio.play();
    }
    return;
  }

  var videoId = tsLink.closest("ul").dataset.videoId;
  if (!videoId) return;
  var timestamp = tsLink.dataset.timestamp;

  var player = document.getElementById("youtube-player");
  if (player && player.tagName === "IFRAME") {
    player.src = "https://www.youtube.com/embed/" + videoId + "?autoplay=1&playsinline=1&start=" + timestamp;
    return;
  }

  var lite = document.getElementById("youtube-player") || document.querySelector(".youtube-lite");
  if (lite) {
    loadYouTubeIframe(lite, videoId, timestamp);
  }
});

function loadYouTubeIframe(element, videoId, startTime) {
  var iframe = document.createElement("iframe");
  iframe.className = "interview-media-embed";
  if (element.id) iframe.id = element.id;
  iframe.setAttribute("allow", "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share");
  iframe.setAttribute("allowfullscreen", "");

  // Insert into DOM before setting src — Safari requires the iframe to be
  // in the document (within the user-gesture call stack) for autoplay to work.
  var src = "https://www.youtube.com/embed/" + videoId + "?autoplay=1&playsinline=1" + (startTime ? "&start=" + startTime : "");
  element.replaceWith(iframe);
  iframe.src = src;
}
