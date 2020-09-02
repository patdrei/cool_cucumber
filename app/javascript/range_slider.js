const range_slider = () => {

  const range_slider_value = document.querySelector('#range_slider_value')
  const range_slider = document.querySelector('#range_slider')
  if(range_slider){
    range_slider.addEventListener('input', () =>{
      range_slider_value.innerHTML = Math.round(range_slider.value)
    });
  };
};

export{ range_slider };

