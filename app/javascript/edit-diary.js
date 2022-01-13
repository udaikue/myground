import Vue from 'vue'
import EditForm from './edit-form.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-edit-diary'
  const diaries = document.querySelector(selector)
  if (diaries) {
    new Vue({
      render: (h) => h(EditForm)
    }).$mount(selector)
  }
})
