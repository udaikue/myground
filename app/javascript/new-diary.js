import Vue from 'vue'
import NewGame from './new-game.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-new-diary'
  const diaries = document.querySelector(selector)
  if (diaries) {
    new Vue({
      render: (h) => h(NewGame)
    }).$mount(selector)
  }
})
