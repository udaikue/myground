<template>
  <div id='diaries' class='diary'>
    <form class='form' v-bind:action='diariesEditPath' method='post' name='put'>
      <div class='diary__items'>
        <input type='hidden' name='_method' value='put'>
        <input type='hidden' name='authenticity_token' v-bind:value='token()'>
        <div class='container'>
          <div class='diary__items-inner'>

            <div class='diary__item'>
              <label class='diary__item-title'>日記</label>
              <div class='control'>
                <textarea class='textarea' name='diary[comment]' v-bind:value='diary.comment'></textarea>
              </div>
            </div>

            <div class='diary__item'>
              <label class='diary__item-title'>関連記事の削除</label>
              <table class='table is-fullwidth link-destroy-selector'>
                <thead>
                  <tr>
                    <th><div class='has-text-centered'>リンク</div></th>
                    <th width='50'><div class='has-text-centered'>削除</div></th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for='link in links' :key='link.key'>
                    <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][id]`" v-bind:value='link.id' v-if='link.persisted'>
                    <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][url]`" v-bind:value='link.url'>
                    <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][title]`" v-bind:value='link.title'>
                    <td><div class='has-text-left'>{{ link.title }}</div></td>
                    <td><div class='has-text-centered'><input type='checkbox' v-bind:name="`diary[links_attributes][${link.id}][_destroy]`"></div></td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div class='diary__item'>
              <label class='diary__item-title'>関連記事の追加</label>
              <div class='field'>
                <p class='label'>URL</p>
                <div class='control'>
                  <input type='text' class='input' v-model='url'>
                </div>
              </div>
              <div class='field'>
                <p class='label'>リンクタイトル</p>
                <div class='control'>
                  <input type='text' class='input' v-model='title'>
                </div>
              </div>
              <div class='field'>
                <input type='button' @click='addLink()' value='リンク追加' class='button is-small'>
              </div>
            </div>

            <div class='diary__item'>
              <div class='control'>
                <label class='diary__item-title'>
                <input name="diary[published]" type="hidden" value="0">
                <input type="checkbox" value="1" name="diary[published]" v-bind:checked='diary.published'>
                公開する
                </label>
              </div>
            </div>

            <div class='diary__item is-grouped'>
              <div class='buttons'>
                <button class='button is-primary'>更新</button>
                <button class='button is-small' type='button' onclick='history.back()'>キャンセル</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </form>

    <form class='form' v-bind:action='diariesEditPath' method='post' name='delete'>
      <input type='hidden' name='_method' value='delete'>
      <input type='hidden' name='authenticity_token' v-bind:value='token()'>
      <div class='diary__items'>
        <div class='container'>
          <div class='diary__item'>
            <div class='control'>
              <button class='' onclick="return confirm('本当に削除しますか?')">削除</button>
            </div>
          </div>
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
