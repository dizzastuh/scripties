
import { forEach } from "./stream-input.json";
import m3u8ToMp4 from "m3u8-to-mp4";
var converter = new m3u8ToMp4();

forEach(stream => {
  (async function() {
    console.log(`Converting ${stream.name}`);

    await converter
      .setInputFile(stream.src)
      .setOutputFile(`${stream.name}.mp4`)
      .start();
  
    console.log(`${stream.name} converted`);
  })();
});
