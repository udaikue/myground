import Vue from 'vue'
import Diary from './diary.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-diary'
  const games = document.querySelector(selector)
  if (games) {
    new Vue({
      render: (h) => h(Diary)
    }).$mount(selector)
  }
})
