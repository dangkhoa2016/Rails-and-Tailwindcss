// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import * as Flowbite from 'flowbite';

// Initialize on page load and after Turbo content is replaced
const initializeHtml = () => {
  Flowbite.initFlowbite();
  initMenuClick();
};

const initMenuClick = () => {
  const megaMenuFullToggle = document.querySelector('[data-collapse-toggle="mega-menu-full"]');
  if (megaMenuFullToggle) {
    megaMenuFullToggle.addEventListener('click', function() {
      // const megaMenuFull = document.querySelector('#mega-menu-full');
      // if (!megaMenuFull.classList.contains('hidden')) {
        if (!document.querySelector('#mega-menu-full-dropdown').classList.contains('hidden'))
          document.querySelector('#mega-menu-full-dropdown-button').click();
      // }
    });
  }
};

// Reinitialize Flowbite when Turbo fully loads the page
document.addEventListener('turbo:load', initializeHtml);
