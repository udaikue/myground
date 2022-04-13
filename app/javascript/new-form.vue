<template>
  <div class='diary__items'>
    <form class='form' v-bind:action='diariesPath' method='post'>
      <input type='hidden' name='authenticity_token' v-bind:value='token()'>
      <input type='hidden' name='diary[game_id]' v-bind:value='game.id'>
      <div class='container'>
        <div class='diary__items-inner'>
          <div class='diary__item'>
            <label class='diary__item-title'>日記</label>
            <div class='control'>
              <textarea class='textarea' name='diary[comment]'></textarea>
            </div>
          </div>

          <div class='diary__item'>
            <label class='diary__item-title'>関連記事</label>
            <div class='links' v-if='links.length'>
              <div class='links__item' v-for='link in links' :key='link.key'>
                <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][url]`" v-bind:value='link.url'>
                <input type='hidden' v-bind:name="`diary[links_attributes][${link.id}][title]`" v-bind:value='link.title'>
                {{ link.title }}
              </div>
            </div>
            <div class='field'>
              <p class='label'>URL</p>
              <div class='control'>
                <input type='text' class='input' v-model='url'>
              </div>
            </div>
            <div class='field'>
              <p class='label'>タイトル</p>
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
              <label class='checkbox'>
                <input type='checkbox' name='diary[published]'>
                公開する
              </label>
            </div>
          </div>

          <div class='diary__item'>
            <div class='buttons'>
              <button class='button is-primary'>保存</button>
              <button class='button is-gray-light is-small' type='button' onclick='history.back()'>キャンセル</button>
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
    game: { type: Object, required: true },
    diariesPath: { type: String, required: true }
  },
  data() {
    return {
      url: '',
      title: '',
      key: 0,
      links: [],
      comment: '',
      published: false,
    }
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    addLink() {
      if (!(this.url === '') && !(this.title === '')) {
        const id = new Date().getTime()
        this.links.push({id: id, key: this.key, url: this.url, title: this.title})
        this.key ++
        this.url = ''
        this.title = ''
      }
    },
  },
}
</script>
