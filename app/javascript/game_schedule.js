import Vue from 'vue'
import gameSchedule from './game_schedule.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-game-schedule'
  const games = document.querySelector(selector)
  if (games) {
    new Vue({
      render: (h) => h(gameSchedule)
    }).$mount(selector)
  }
})
