document.addEventListener("turbolinks:load", () => {
  const protein = document.querySelector("#js-p");
  const fat = document.querySelector("#js-f");
  const carbo = document.querySelector("#js-c");
  const calorie = document.querySelector("#js-calorie");
  const targets = [protein, fat, carbo];
  const calculate = () => {
    let totalAmount = 0;
    totalAmount += parseFloat(protein.value * 4);
    totalAmount += parseFloat(fat.value * 9);
    totalAmount += parseFloat(carbo.value * 4);
    calorie.value = Math.round(totalAmount);
  };

  targets.forEach((target) => {
    target.addEventListener("input", calculate);
  });
  calculate();
});
