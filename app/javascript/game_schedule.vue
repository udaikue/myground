<template>
  <div id="gameSchedule">
    <ul>
      <li v-for='game in games' :key='game.id'>
        {{ game.team_home }} VS {{ game.team_visitor }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      games: []
    }
  },
  created() {
    this.getGameSchedule()
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    getGameSchedule() {
      fetch('/api/diaries/new', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        redirect: 'manual'
      })
        .then((response) => response.json())
        .then((json) => {
          this.games = json
          this.loaded = true
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    }
  }
}
</script>
