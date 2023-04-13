
var rows = 4;
var columns = 4;

var currTile;
var otherTile;

var turns = 0;

window.onload = function() {
	//initialize the board
	for (let r = 0; r < rows; r++){
		for (let c = 0; c < columns; c++){
			//create an img tag
			let tile = document.createElement("img");
			tile.src = "./images/blank.jpg";

			tile.addEventListener("dragstart", dragStart); //click on image to drag
			tile.addEventListener("dragover", dragOver); //drag an image
			tile.addEventListener("dragenter", dragEnter); //dragging image into another one
			tile.addEventListener("dragleave", dragLeave); //dragging an image away from another one
			tile.addEventListener("drop", dragDrop); // drop an image onto another one
			tile.addEventListener("dragend", dragEnd); //completed drang and drop

			document.getElementById("board").append(tile);
		}
	}

	//pieces
	let pieces = [];
	for (let i=1; i <= rows*columns; i++){
		pieces.push(i.toString()); //put "1" to "16" into the array
	}

	//mix
	pieces.reverse();
	for (let i=0; i < pieces.length; i++){
		let j = Math.floor(Math.random() * pieces.length);

		let aux = pieces[i];
		pieces[i] = pieces[j];
		pieces[j] = aux;
	}

	for (let i = 0; i < pieces.length; i++){
		let tile = document.createElement("img");
		tile.src = "./images/" + pieces[i] + ".jpg";

		//drag and drop
		tile.addEventListener("dragstart", dragStart); //click on image to drag
		tile.addEventListener("dragover", dragOver); //drag an image
		tile.addEventListener("dragenter", dragEnter); //dragging image into another one
		tile.addEventListener("dragleave", dragLeave); //dragging an image away from another one
		tile.addEventListener("drop", dragDrop); // drop an image onto another one
		tile.addEventListener("dragend", dragEnd); //completed drang and drop

		document.getElementById("pieces").append(tile);
	}
}

function dragStart() {
	currTile = this; 
}

function dragOver(e) {
	e.preventDefault();
}

function dragEnter(e) {
	e.preventDefault();
}

function dragLeave() {

}

function dragDrop() {
	otherTile = this;
}

function dragEnd() {
	if (currTile.src.includes("blank")){
		return;
	}
	let currImg = currTile.src;
	let otherImg = otherTile.src;
	currTile.src = otherImg;
	otherTile.src = currImg;


}