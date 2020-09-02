const disabled = () => {
  const select_items = document.querySelectorAll('.new-page-tag')
  select_items.forEach ((item) => {
    item.addEventListener("click", () => {
      item.classList.toggle('disabled');
    });
  });
};

export { disabled };
