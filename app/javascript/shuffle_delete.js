const shuffle_delete = () => {
  const pinkButtons = document.querySelectorAll('.fa-trash-alt, .fa-redo')

  if (pinkButtons) {


    pinkButtons.forEach((button) => {
      button.addEventListener("click", () => {
        button.classList.toggle("text-secondary");
      });
    });


  };
  };
  export { shuffle_delete };
