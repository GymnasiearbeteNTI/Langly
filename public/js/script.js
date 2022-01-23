
var turn = true;

var itemParent = null;

function translateCard(flip) {
  if (flip == true){
    event.target.children[0].style.display = 'none';
    event.target.children[1].style.display = 'block';
    turn = false;
  } else {
    event.target.children[0].style.display = 'block';
    event.target.children[1].style.display = 'none';
    turn = true;
  }
}

function revealCards(flip) {
  if (flip == true){
    for (let i = 0; i < event.target.parentElement.getElementsByClassName('hidden_card').length; i++) {
      event.target.parentElement.getElementsByClassName('revealed_card')[i].style.display = 'block';
      event.target.parentElement.getElementsByClassName('hidden_card')[i].style.display = 'none';
      turn = false;
    }
  } else {
    for (let i = 0; i < event.target.parentElement.getElementsByClassName('hidden_card').length; i++) {
      event.target.parentElement.getElementsByClassName('revealed_card')[i].style.display = 'none';
      event.target.parentElement.getElementsByClassName('hidden_card')[i].style.display = 'block';
      turn = true;
    }
  }
}

function allowDrop(ev) {
  ev.preventDefault();
}

function dragStart(ev) {
  itemParent = ev.target.parentElement;
  ev.dataTransfer.setData("Text", ev.target.getAttribute('id'));
}

function drop(ev,el,limit) {
    ev.preventDefault();
    if (el.childNodes.length == limit) {
        var data = ev.dataTransfer.getData("text");
        console.log(itemParent);           
        itemParent.appendChild(document.getElementById(data));
    }else{
    	var data = ev.dataTransfer.getData("Text");
    	el.appendChild(document.getElementById(data));
    }
};