import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Quick", "Easy", "Simple"],
    typeSpeed: 100,
    loop: false
  });
}

export { loadDynamicBannerText };
