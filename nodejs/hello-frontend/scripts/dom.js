function onLoad() {
  var title = document.querySelector("#title");
  var msg = document.querySelector("#msg");
  title.textContent = "Foobar";
  msg.textContent = "操作text"
}

function onClick(){
  var msg = document.querySelector("#result") ;
  var input = document.querySelector('#input');
  var checked = document.querySelector('#c1').checked;
  msg.textContent = input.value;
  if (checked) {
    msg.textContent += ' checked'     ;
  }

  var os_list = document.querySelector('#ml').getElementsByTagName('option');
  for ( var i in os_list ) {
    if (os_list[i].selected) {
      msg.textContent += " " + os_list[i].value;
    }
  }
}

function color(){
  var r = document.querySelector('#red').value;
  var g = document.querySelector('#green').value;
  var b = document.querySelector('#blue').value;
  msg.style.backgroundColor = 'rgb('+r+','+g+','+b +')';
}

function changesize(){
  var size = document.querySelector('#size').value;
  msg.style.fontSize = size + 'pt';
}


function lighton(event){
  if (event.target.id == 'move') {
    event.target.style.backgroundColor = '#ffaaaa' ;
  }
}

function lightoff(event){
  if (event.target.id == 'move') {
    event.target.style.backgroundColor = '#cc7777' ;
  }
}

function doMove(event){
  if (event.target.id =='move'){
    if (event.buttons == 1) {
      var w = event.clientX;
      var h = event.clientY;
      event.target.style.left = (w -50 ) +'px';
      event.target.style.top= (h -50 ) +'px';
    }
  }
}
