// TERRA — terraapp.world
// Minimal, purposeful JavaScript. No frameworks.

document.addEventListener('DOMContentLoaded', () => {

  // -- Intersection Observer: fade-in on scroll --
  const fadeEls = document.querySelectorAll(
    '.story-card, .data-card, .feel-quote, .about p, .get-inner > *'
  );

  fadeEls.forEach(el => el.classList.add('fade-in'));

  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry, i) => {
      if (entry.isIntersecting) {
        setTimeout(() => {
          entry.target.classList.add('visible');
        }, i * 60);
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

  fadeEls.forEach(el => observer.observe(el));

  // -- Nav: background opacity on scroll --
  const nav = document.querySelector('.nav');
  window.addEventListener('scroll', () => {
    if (window.scrollY > 60) {
      nav.style.background = 'rgba(5, 10, 26, 0.95)';
    } else {
      nav.style.background = 'rgba(5, 10, 26, 0.8)';
    }
  }, { passive: true });

  // -- Globe: subtle parallax on hero --
  const globe = document.querySelector('.hero-globe');
  if (globe) {
    window.addEventListener('mousemove', (e) => {
      const x = (e.clientX / window.innerWidth - 0.5) * 8;
      const y = (e.clientY / window.innerHeight - 0.5) * 8;
      globe.style.transform = `translate(${x}px, ${y}px)`;
    }, { passive: true });
  }

  // -- Story cards: color accent on hover --
  const storyCards = document.querySelectorAll('.story-card[data-color]');
  storyCards.forEach(card => {
    const color = card.dataset.color;
    card.addEventListener('mouseenter', () => {
      card.style.boxShadow = `0 8px 40px ${color}18, 0 0 0 1px ${color}22`;
    });
    card.addEventListener('mouseleave', () => {
      card.style.boxShadow = '';
    });
  });

  // -- App Store button placeholder --
  const appStoreBtn = document.querySelector('a[href="#"]');
  if (appStoreBtn) {
    appStoreBtn.addEventListener('click', (e) => {
      e.preventDefault();
      // Will be replaced with actual App Store URL on launch
      const msg = document.createElement('p');
      msg.textContent = 'Coming soon to the Mac App Store.';
      msg.style.cssText = `
        position: fixed; bottom: 32px; left: 50%; transform: translateX(-50%);
        background: #1a2a4a; color: #8dcfff; padding: 14px 28px;
        border-radius: 4px; font-size: 14px; letter-spacing: 0.5px;
        border: 1px solid rgba(141,207,255,0.2);
        animation: fadeMsg 3s ease forwards;
        z-index: 999;
      `;
      document.body.appendChild(msg);
      setTimeout(() => msg.remove(), 3000);
    });
  }

});

// Inject keyframe for message animation
const style = document.createElement('style');
style.textContent = `
  @keyframes fadeMsg {
    0%   { opacity: 0; transform: translateX(-50%) translateY(8px); }
    15%  { opacity: 1; transform: translateX(-50%) translateY(0); }
    75%  { opacity: 1; }
    100% { opacity: 0; }
  }
`;
document.head.appendChild(style);
