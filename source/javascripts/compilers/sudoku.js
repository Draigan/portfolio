import { Sudoku } from "/assets/sudoku/sudoku.js"

up.compiler('[sudoku]', function(element) {
  const sudoku = new Sudoku(element);
});
