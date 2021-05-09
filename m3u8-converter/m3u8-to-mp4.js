const streams = require("./stream-input.json")
var m3u8ToMp4 = require("m3u8-to-mp4");
var converter = new m3u8ToMp4();

streams.forEach(stream => {
  (async function() {
    console.log(`Converting ${stream.name}...`);

    await converter
      .setInputFile(stream.src)
      .setOutputFile(`${stream.name}.mp4`)
      .start();
  
    console.log(`${stream.name} converted`);
  })();
});
