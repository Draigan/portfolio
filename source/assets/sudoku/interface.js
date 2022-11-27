export class Interface {
  constructor(nodes) {
    this.container = nodes.container;
    this.board = nodes.board;
    this.cells = nodes.cells;
    this.notesButton = nodes.notesButton;
    this.eraseButton = nodes.eraseButton;
    this.numberButtons = nodes.numberButtons;
    this.numberWrappers = nodes.numberWrappers;

    this.notesActive = false;


    //This represents the coordinates of the cell that is currently clicked
    this.currentCell = [4, 4];
    this.highlight(4, 4);

    //Call event listeners
    this.eventListeners();
  }
  highlight(x, y) {

    //Reset previous highlighted cells 
    for (let i = 0; i < 9; i++) {
      for (let j = 0; j < 9; j++) {
        this.cells[i][j].classList.remove("-center-highlight");
        this.cells[i][j].classList.remove("-highlight");
      }
    }
    //Highlight clicked cell
    this.cells[x][y].classList.add("-center-highlight");
    //Highlight rows and cols 
    for (let i = 0; i < 9; i++) {
      this.cells[x][i].classList.add("-highlight");
      this.cells[i][y].classList.add("-highlight");

    }

    //Highlight sections 
    let x0 = Math.floor((x / 3)) * 3;
    let y0 = Math.floor((y / 3)) * 3;

    for (let i = 0; i < 3; i++) {
      for (let j = 0; j < 3; j++) {
        this.cells[x0 + i][y0 + j].classList.add("-highlight");

      }
    }

  }
  //Erase all content of cell 
  erase() {
    this.currentNumberWrapper =
      this.numberWrappers[this.currentCell[0]][this.currentCell[1]];
    this.currentNumberWrapper.classList.add("-highlight");
  }

  eventListeners() {

    this.container.addEventListener("keydown", (event) => {
      if (event.keyCode == 37) {
        this.currentCell = [this.currentCell[0], this.currentCell[1] - 1];
        this.keypressWrapAround();
        this.highlight(this.currentCell[0], this.currentCell[1]);

      }
      if (event.keyCode == 39) {
        this.currentCell = [this.currentCell[0], this.currentCell[1] + 1];
        this.keypressWrapAround();
        this.highlight(this.currentCell[0], this.currentCell[1]);
      }
      if (event.keyCode == 40) {
        this.currentCell = [this.currentCell[0] + 1, this.currentCell[1]];
        this.keypressWrapAround();
        this.highlight(this.currentCell[0], this.currentCell[1]);
      }
      if (event.keyCode == 38) {
        this.currentCell = [this.currentCell[0] - 1, this.currentCell[1]];
        this.keypressWrapAround();
        this.highlight(this.currentCell[0], this.currentCell[1]);
      }
    });

    for (let i = 0; i < this.numberButtons.length; i++) {
      this.numberButtons[i].addEventListener("click", () => {

        //Put button number into current cell
        this.currentNumberWrapper =
          this.numberWrappers[this.currentCell[0]][this.currentCell[1]];
        this.currentNumberWrapper.classList.remove("-hidden");
        this.currentNumberWrapper.innerHTML = this.numberButtons[i].innerHTML

      })
    }
    this.eraseButton.addEventListener("click", () => {
      this.erase();
    })
    this.notesButton.addEventListener("click", () => {
    })
    for (let i = 0; i < 9; i++) {
      for (let j = 0; j < 9; j++) {
        this.cells[i][j].addEventListener("click", () => {
          this.highlight(i, j);
          this.currentCell = [i, j];
        })
      }
    }
  }

  //Wrap for the arrow keys
  keypressWrapAround() {
    if (this.currentCell[1] === -1) {
      this.currentCell[1] = 8;
    }
    if (this.currentCell[1] === 9) {
      this.currentCell[1] = 0;
    }
    if (this.currentCell[0] === 9) {
      this.currentCell[0] = 0;
    }
    if (this.currentCell[0] === -1) {
      this.currentCell[0] = 8;
    }
  }
}

