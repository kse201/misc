var glob = require('glob')

function onLoad(){
  glob("**/*.html", (err,files) => {
    if (err) {
      console.log(err)
    }
    var list = document.querySelector("#list")
    list.textContent = files
  })
}
