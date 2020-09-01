const pref_toggler = () => {
  const preferences = document.querySelectorAll('.btn-outline-secondary')

preferences.forEach((preference) => {

  preference.addEventListener("click", () =>
    preference.classList.toggle("btn-outline-secondary");
    preference.classList.toggle("btn-secondary");
    );
});
};

export { pref_toggler };
