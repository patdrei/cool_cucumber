
const shopping_list_item_listener = () => {
  const shopping_list_cards = document.querySelectorAll('.shopping_list_item, .shopping_list_item_bought')
  if (shopping_list_cards) {


    shopping_list_cards.forEach((shopping_list_card) => {
      shopping_list_card.addEventListener("click", () => {
        shopping_list_card.classList.toggle("shopping_list_item_bought");
        shopping_list_card.classList.toggle("shopping_list_item");
        const circle = shopping_list_card.querySelector("i");
          circle.classList.toggle('fa-check-circle');
          circle.classList.toggle('far')
          circle.classList.toggle('fas')
          circle.classList.toggle('fa-circle');
      });
    });


  };
};



export { shopping_list_item_listener };



//



