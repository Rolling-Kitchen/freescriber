    // 2. This code loads the IFrame Player API code asynchronously.
    var tag = document.createElement("script");
    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName("script")[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // 3. This function creates an <iframe> (and YouTube player)
    //    after the API code downloads.
    var player;
    const all_subtitles = document.getElementsByClassName("timecode");

    function onYouTubeIframeAPIReady() {
      player = new YT.Player("player", {
        height: "490",
        width: "800",
        videoId: "<%=@video.video_source %>",
        enablejsapi: 1,
        modestbranding: 1,
        rel: 0,
        events: {
          onReady: onPlayerReady,
          onStateChange: onPlayerStateChange,
          onError: onPlayerError
        },
      });
      Array.prototype.forEach.call(all_subtitles, function (element) {
        element.addEventListener("click", function () {
          console.log("timecode is: " + element.dataset.startSeconds);
          player.seekTo(element.dataset.startSeconds, true);
        });
      });
    }
  function onPlayerError(event) {
    window.location.reload(true); 
  }
    // 4. The API will call this function when the video player is ready.
    function onPlayerReady(event) {
      // event.target.playVideo();
    }

    // https://stackoverflow.com/questions/37904499/sync-embedded-youtube-video-time-stamp-to-custom-progress-bar
    function get_subtitle(current_time) {
      for (let index = 0; index < all_subtitles.length; index++) {
        if (all_subtitles[index].dataset.startSeconds >= current_time - 1) {
          console.log(all_subtitles[index]);
          return all_subtitles[index];
        }
      }
    }
    function subtitle_sync() {
      var current_time = player.getCurrentTime();
      let current_subtitle = get_subtitle(current_time);
      if (current_subtitle.classList.contains("current_subtitle")) {
      } else {
        Array.prototype.forEach.call(all_subtitles, function (element) {
          element.classList.remove("current_subtitle");
        });

        current_subtitle.className += " current_subtitle";
      }

      timeout_setter = setTimeout(subtitle_sync, 1000);
    }

    function onPlayerStateChange(event) {
      switch (event.data) {
        case 0:
          console.log("video ended");
          Array.prototype.forEach.call(all_subtitles, function (element) {
            element.classList.remove("current_subtitle");
          });

          break;
        case 1:
          subtitle_sync();
          break;
        case 2:
          console.log("video paused at " + player.getCurrentTime());
      }
    }