
const shopping_list_item_listener = () => {
  const shopping_list_items = document.querySelectorAll('.shopping_list_item')
  const shopping_list_items_bought = document.querySelectorAll('.shopping_list_item_bought')



  shopping_list_items.forEach((shopping_list_item) => {
    shopping_list_item.addEventListener("click", () => {
      shopping_list_item.style.backgroundColor = "#F5F5F5";
      shopping_list_item.style.color = "#EBEBEB";
    });
  });

 shopping_list_items_bought.forEach((shopping_list_item) => {
    shopping_list_item.addEventListener("click", () => {
      shopping_list_item.style.backgroundColor = "#EBEBEB";
      shopping_list_item.style.color = "black";
    });
  });




};
export { shopping_list_item_listener };



//



