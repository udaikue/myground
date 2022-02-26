import Vue from 'vue'
import EditForm from './edit-form.vue'

document.addEventListener('DOMContentLoaded', () => {
  const selector = '#js-edit-diary'
  const diaries = document.querySelector(selector)
  if (diaries) {
    const diaryId = diaries.dataset.diaryId
    const diariesEditPath = `${diaries.dataset.diariesPath}/${diaryId}`
    new Vue({
      render: (h) => h(EditForm, { props: { diaryId, diariesEditPath } })
    }).$mount(selector)
  }
})
