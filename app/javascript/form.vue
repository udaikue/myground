<template>
  <form class='form' action='/api/diaries' method='post'>
    <input type='hidden' name='authenticity_token' v-bind:value='token()'>
    <input type='hidden' name='diary[game_id]' v-bind:value='game.id'>
    <div class='field'>
      <label class='label'>日記</label>
      <div class='control'>
        <textarea class='textarea' name='diary[comment]'></textarea>
      </div>
    </div>
    <div class='field'>
      <label class='label'>リンク</label>
      <div class='control'>
        <input class='input' name='link[url]'>
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
        <button class='button'>保存</button>
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
      comment: null,
      published: false
    }
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
  },
}
</script>
