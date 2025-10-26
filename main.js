const buttons = document.querySelectorAll('button');
const result = document.querySelector('#result');

let concatText = "";
let justCalculated = false;

function buttonPressed(event) 
{const text = event.target.textContent;

  if (text === "=") {
    try {
      concatText = eval(concatText).toString();}
     catch {concatText = "Error";}
         justCalculated = true;}
         
         
 else if (text === "AC") 
    { concatText = ""; justCalculated = false; }
  
 else {    if (justCalculated && !isNaN(text)) 
    { concatText = text; } 
      else { if (
        
        !isNaN(text) &&
        
        (concatText === "0" ||
         /[+\-*/]0$/.test(concatText))
      ) {
        
        concatText = concatText.replace(/0$/, text);
      } else {
     concatText += text; }
    }
    justCalculated = false;
  }

  result.textContent = concatText;}

buttons.forEach(button => button.addEventListener('click', buttonPressed));
