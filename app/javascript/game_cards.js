import Vue from 'vue'
import gameCards from './game_cards.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-game-cards'
  const games = document.querySelector(selector)
  if (games) {
    new Vue({
      render: (h) => h(gameCards)
    }).$mount(selector)
  }
})
