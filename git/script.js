const hamburger = document.querySelector('.hamburger');
const navarea = document.querySelector('.navarea');
const mask = document.querySelector('#mask');

/* ハンバーガークリック時に開閉*/
hamburger.addEventListener('click', () => {
  document.body.classList.toggle('open');
});

/* 背景（マスク）クリック時に閉じる*/
mask.addEventListener('click', () => {
  document.body.classList.remove('open');
});


mask.addEventListener('click', () => {
    document.body.classList.remove('open');})