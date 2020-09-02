const pref_toggler = () => {
  const preferencesA = document.querySelectorAll('.btn-outline-secondary, .btn-secondary')
  const preferencesB = document.querySelectorAll('.btn-outline-danger, .btn-danger')
  const preferencesC = document.querySelectorAll('.btn-outline-info, .btn-info')
  const preferencesD = document.querySelectorAll('.btn-outline-warning, .btn-warning')
  if (preferencesA) {


    preferencesA.forEach((preference) => {
      preference.addEventListener("click", () => {
        preference.classList.toggle("btn-secondary");
        preference.classList.toggle("btn-outline-secondary");
      });
    });


  };

  if (preferencesB) {


    preferencesB.forEach((preference) => {
      preference.addEventListener("click", () => {
        preference.classList.toggle("btn-danger");
        preference.classList.toggle("btn-outline-danger");
      });
    });


  };

  if (preferencesC) {


    preferencesC.forEach((preference) => {
      preference.addEventListener("click", () => {
        preference.classList.toggle("btn-info");
        preference.classList.toggle("btn-outline-info");
      });
    });


  };

    if (preferencesD) {


    preferencesD.forEach((preference) => {
      preference.addEventListener("click", () => {
        preference.classList.toggle("btn-warning");
        preference.classList.toggle("btn-outline-warning");
      });
    });


  };

};
export { pref_toggler };
