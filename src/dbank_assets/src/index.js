import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async () => {
  await update();
});

document.querySelector("form").addEventListener("submit", async event => {
  event.preventDefault();
  const button = event.target.querySelector("#submit-btn");

  const inputAmount = parseFloat(document.getElementById("input-amount").value);
  const withdrawal = parseFloat(document.getElementById("withdrawal-amount").value);

  button.setAttribute("disabled", true);

  // check if input value has been set
  if( document.getElementById("input-amount").value.length != 0 ){
    await dbank.topUp(inputAmount);
  }

  // withdrawal
  if( document.getElementById("withdrawal-amount").value.length != 0 ){
    await dbank.withdraw(withdrawal);
  }

  // add compound interest
  await dbank.compound();

  await update();

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  button.removeAttribute("disabled"); 
});

async function update(){
  const currentBalance = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentBalance * 100 / 100);
}