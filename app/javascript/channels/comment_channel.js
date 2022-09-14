import consumer from "./consumer"

if(location.pathname.match(/\/products\/\d/)){
  console.log("読み込み完了")

  consumer.subscriptions.create({
    channel: "CommentChannel",
    product_id: location.pathname.match(/\d+/)[0]
  }, {

    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const html = `
        <div class="comment-content">
        <a href="#" class="comment-user">${data.user.nickname}</a>
        <p>${data.comment.text}</p>
        </div>`
      const comments = document.getElementById("comments")
      comments.insertAdjacentHTML('beforeend', html)
      const commentForm = document.getElementById("comment-form")
      commentForm.reset();

    }
  })
}