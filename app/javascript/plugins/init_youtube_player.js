export function init_youtube_player() {
  const caption_container = document.getElementById("caption_container");
  if (caption_container) {
    var YouTubeIframeLoader = require("youtube-iframe");
    var player;
    const container_div_source =
      document.getElementById("player").dataset["videoSource"];
    const all_captions = document.getElementsByClassName("timecode");
    YouTubeIframeLoader.load(function (YT) {
      player = new YT.Player("player", {
        height: "490",
        width: "800",
        videoId: container_div_source,
        enablejsapi: "1",
        modestbranding: "1",
        controls: "0",
        rel: "0",
        fs: "0",
        loop: "0",
        events: {
          onReady: onPlayerReady,
          onStateChange: onPlayerStateChange,
          onError: onPlayerError,
        },
      });
      Array.prototype.forEach.call(all_captions, function (element) {
        element.addEventListener("click", function () {
          console.log("timecode is: " + element.dataset.startSeconds);
          player.seekTo(element.dataset.startSeconds, true);
        });
      });
    });
    function onPlayerError(event) {
      // window.location.reload(true);
    }
    // 4. The API will call this function when the video player is ready.
    function onPlayerReady(event) {
      // event.target.playVideo();
      const urlParams = new URLSearchParams(window.location.search);
      const skim_value = urlParams.get("start_skim");
      if (skim_value != null) {
        console.log("skim value");
        console.log(skim_value);
        player.seekTo(skim_value, true);
      }
    }

    // https://stackoverflow.com/questions/37904499/sync-embedded-youtube-video-time-stamp-to-custom-progress-bar
    function get_subtitle(current_time) {
      for (let index = 0; index < all_captions.length; index++) {
        if (all_captions[index].dataset.startSeconds >= current_time - 2) {
          console.log(all_captions[index]);
          return all_captions[index];
        }
      }
    }

    function subtitle_sync() {
      var current_time = player.getCurrentTime();
      let current_caption = get_subtitle(current_time);
      if (current_caption.classList.contains("current_caption")) {
      } else {
        Array.prototype.forEach.call(all_captions, function (element) {
          element.classList.remove("current_caption");
        });
        current_caption.className += " current_caption";
        // The current caption will be shown 120 px from the top of the caption_container
        caption_container.scrollTop =
          current_caption.offsetTop - caption_container.offsetTop + 90;
      }
      setTimeout(subtitle_sync, 1000);
    }

    function onPlayerStateChange(event) {
      switch (event.data) {
        case 0:
          console.log("video ended");
          Array.prototype.forEach.call(all_captions, function (element) {
            element.classList.remove("current_caption");
          });

          break;
        case 1:
          subtitle_sync();
          break;
        case 2:
          console.log("video paused at " + player.getCurrentTime());
      }
    }

    const textSearch = document.querySelector(".form-text");
    console.log(textSearch);
    textSearch.addEventListener("ajax:success", (event, data) => {
      console.log("event and data")
      console.log(event, data);
      const jsonResponse = event.detail[0];
      console.log("json")
      console.log(jsonResponse);

      const fullTranscript = document.getElementById("fullTranscript");
      const searchResults = document.getElementById("searchResults");
      if (jsonResponse.length !== 0) {
        // captionSearch.innerHTML = "";
        fullTranscript.style.display = "none";
        jsonResponse.forEach((caption) => {
          console.log(caption, "hello");
          searchResults.innerHTML = "";
          searchResults.insertAdjacentHTML(
            "beforeend",
            `<li><a data-start-seconds=${caption.start_seconds} data-end-seconds=${caption.end_seconds} class=timecode>${caption.start} - ${caption.text}</a></li>`
          );
        });
      }
      Array.prototype.forEach.call(all_captions, function (element) {
        element.addEventListener("click", function () {
          console.log("timecode is: " + element.dataset.startSeconds);
          player.seekTo(element.dataset.startSeconds, true);
          searchResults.innerHTML = "";
          fullTranscript.style.display = "block";
        });
      });
    });
    console.log("textsearch")
    console.log(textSearch);
  }
  return player;
}
