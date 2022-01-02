<template>
  <form class='form' action='/api/diaries' method='post'>
    <input type='hidden' name='authenticity_token' v-bind:value='token()'>
    <input type='hidden' name='diary[game_id]' v-bind:value='game.id'>
    <input type='hidden' name='link[url]' v-bind:value='links[0]'>
    <input type='hidden' name='link[title]' v-bind:value='links[1]'>
    <div class='field'>
      <label class='label'>日記</label>
      <div class='control'>
        <textarea class='textarea' name='diary[comment]'></textarea>
      </div>
    </div>
    <div class='field'>
      <label class='label'>リンク</label>
      <div class='link' v-for='link in links' :key='link.key'>
        {{ link[2] }}
      </div>
      <div class='control'>
        <p>URL</p>
        <input class='input' v-model='url'>
        <p>リンクタイトル</p>
        <input class='input' v-model='title'>
        <input type='button' @click='addLink()' value='＋'>
      </div>
    </div>
    <div class='field'>
      <div class='control'>
        <label class='checkbox'>
          <input type='checkbox' name='diary[published]'>
          公開する
        </label>
      </div>
    </div>
    <div class='field is-grouped'>
      <div class='control'>
        <button class='button' @click='addLink()'>保存</button>
      </div>
      <div class='control'>
        <button class='button is-light'>キャンセル</button>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  props: {
    game: { type: Object, required: true }
  },
  data() {
    return {
      url: '',
      title: '',
      key: 0,
      links: [],
      comment: '',
      published: false
    }
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    addLink() {
      if (!(this.url === null) && !(this.title === null)) {
        this.links.push([this.key, this.url, this.title])
        this.key ++
        this.url = ''
        this.title = ''
      }
    },
  },
}
</script>
