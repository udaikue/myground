<template>
  <div class='form'>
    <div class='field'>
      <label class='label'>日記</label>
      <div class='control'>
        <textarea class='textarea'></textarea>
      </div>
    </div>
    <div class='field'>
      <div class='control'>
        <label class='checkbox'>
          <input type='checkbox'>
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
  </div>
</template>

<script>
export default {
  props: {
    game: { type: Object, required: true }
  },
}
</script>
