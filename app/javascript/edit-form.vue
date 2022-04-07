<template>
  <div id='diaries'>
    <form class='form' v-bind:action='diariesEditPath' method='post' name='put'>
      <input type='hidden' name='_method' value='put'>
      <input type='hidden' name='authenticity_token' v-bind:value='token()'>
      <div class='field'>
        <label class='label'>日記</label>
        <div class='control'>
          <textarea class='textarea' name='diary[comment]' v-bind:value='diary.comment'></textarea>
        </div>
      </div>
      <table class='table is-full-width link-destroy-selector'>
        <thead>
          <tr>
            <th><div class='has-text-centered'>リンク</div></th>
            <th width='50'><div class='has-text-centered'>削除</div></th>
          </tr>
        </thead>
        <tbody v-for='link in links' :key='link.key'>
          <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][id]`" v-bind:value='link.id' v-if='link.persisted'>
          <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][url]`" v-bind:value='link.url'>
          <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][title]`" v-bind:value='link.title'>
          <tr>
            <td><div class='has-text-left'>{{ link.title }}</div></td>
            <td><div class='has-text-centered'><input type='checkbox' v-bind:name="`diary[links_attributes][${link.id}][_destroy]`"></div></td>
          </tr>
        </tbody>
      </table>
      <div class='field'>
        <div class='control'>
          <p>URL</p>
          <input type='text' class='input is-small' v-model='url'>
          <p>リンクタイトル</p>
          <input type='text' class='input is-small' v-model='title'>
          <input type='button' @click='addLink()' value='リンク追加' class='button is-small'>
        </div>
      </div>
      <div class='field'>
        <div class='control'>
          <label class='label'>
          <input name="diary[published]" type="hidden" value="0">
          <input type="checkbox" value="1" name="diary[published]" v-bind:checked='diary.published'>
          公開する
          </label>
        </div>
      </div>
      <div class='field is-grouped'>
        <div class='control'>
          <button class='button is-link'>更新</button>
          <button class='button is-link is-outlined' type='button' onclick='history.back()'>キャンセル</button>
        </div>
      </div>
    </form>
    <form class='form' v-bind:action='diariesEditPath' method='post' name='delete'>
      <input type='hidden' name='_method' value='delete'>
      <input type='hidden' name='authenticity_token' v-bind:value='token()'>
      <div class='field'>
        <div class='control'>
          <button class='button is-danger' onclick="return confirm('本当に削除しますか?')">削除</button>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  props: {
    diaryId: { type: String, required: true },
    diariesEditPath: { type: String, required: true }
  },
  data() {
    return {
      diary: [],
      url: '',
      title: '',
      key: 0,
      links: [],
    }
  },
  mounted() {
    this.getDiary()
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    getDiary() {
      fetch(`/api/diaries/${this.diaryId}`, {
        method: 'GET',
        headers: {
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        redirect: 'manual'
      })
        .then((response) => response.json())
        .then((json) => {
          let json_diary = json
          this.diary = json_diary.diary
          this.links = json_diary.links.map(link => ({...link, persisted: true}))
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    },
    addLink() {
      if (!(this.url === '') && !(this.title === '')) {
        const id = new Date().getTime()
        this.links.push({id: id, key: this.key, url: this.url, title: this.title, persisted: false})
        this.key ++
        this.url = ''
        this.title = ''
      }
    },
  }
}
</script>
