// const rotator = () => {
//   const rotate_items = document.querySelectorAll('.fa-caret-down')

//     rotate_items.forEach ((item) => {
//       item.addEventListener("click", () => {
//         item.classList.toggle('fa-rotate-180');
//       });
//     });
// };

const rotator = () => {
  const select_items = document.querySelectorAll('#selector')

    select_items.forEach ((item) => {
      item.addEventListener("click", () => {
        item.lastElementChild.classList.toggle('fa-rotate-180');
      }, false);
    });
};

export { rotator };
