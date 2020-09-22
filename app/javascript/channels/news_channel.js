import consumer from "./consumer"

consumer.subscriptions.create("NewsChannel", {
  connected() {
    console.log('hello!');
  },
  
  received(data) {
    console.log(data);
    document.getElementById('broadcast').insertAdjacentHTML("beforeend", data.time + '<br/>');
  }
});
