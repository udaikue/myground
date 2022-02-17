import Vue from 'vue'
import NewGame from './new-game.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-new-diary'
  const diaries = document.querySelector(selector)
  if (diaries) {
    const diariesPath = diaries.dataset.diariesPath
    new Vue({
      render: (h) => h(NewGame, { props: { diariesPath } })
    }).$mount(selector)
  }
})
