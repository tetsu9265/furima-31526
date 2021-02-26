window.addEventListener('load', function(){
  const Price = document.getElementById("item-price")
  const AddTaxPrice = document.getElementById("add-tax-price")
  const Profit = document.getElementById("profit")

  Price.addEventListener('input', function(){
    value = this.value
    AddTaxPrice.innerHTML = value * 0.1
    Profit.innerHTML = value * 0.9
  })
})
