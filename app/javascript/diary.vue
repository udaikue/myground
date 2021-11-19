<template>
  <div id="game">
    <table class='table' v-if='gameCards.length && !result'>
      <thead>
        <tr>
          <th></th>
          <th>{{ cardMonth }}月 {{ cardDate }}日</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for='game in gameCards' :key='game.id'>
          <td>{{ game.team_home }}</td>
          <td @click='getScore(game.id)'>{{ game.score_home }} - {{ game.score_visitor }}</td>
          <td>{{ game.team_visitor }}</td>
        </tr>
      </tbody>
    </table>
    <div class='columns is-mobile' v-if='!result'>
      <div class='column is-one-quarter-mobile' v-if='!oldestMonth()' @click='previousMonth'>前の月</div>
      <div class='column is-one-quarter-mobile'>{{ calendarYear }}年{{ calendarMonth }}月</div>
      <div class='column is-one-quarter-mobile' v-if='!newestMonth()' @click='nextMonth'>次の月</div>
    </div>
    <table class='table' v-if='!result'>
      <thead>
        <tr>
          <th>月</th>
          <th>火</th>
          <th>水</th>
          <th>木</th>
          <th>金</th>
          <th>土</th>
          <th>日</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td v-for='date in monthlyCalendar[0]' :key='date.id' @click='getGameCards(date)'>{{ date }}</td>
        </tr>
        <tr>
          <td v-for='date in monthlyCalendar[1]' :key='date.id' @click='getGameCards(date)'>{{ date }}</td>
        </tr>
        <tr>
          <td v-for='date in monthlyCalendar[2]' :key='date.id' @click='getGameCards(date)'>{{ date }}</td>
        </tr>
        <tr>
          <td v-for='date in monthlyCalendar[3]' :key='date.id' @click='getGameCards(date)'>{{ date }}</td>
        </tr>
        <tr v-if='monthlyCalendar[4]'>
          <td v-for='date in monthlyCalendar[4]' :key='date.id' @click='getGameCards(date)'>{{ date }}</td>
        </tr>
        <tr v-if='monthlyCalendar[5]'>
          <td v-for='date in monthlyCalendar[5]' :key='date.id' @click='getGameCards(date)'>{{ date }}</td>
        </tr>
      </tbody>
    </table>
    <table class='table' v-if='result'>
      <thead>
        <tr>
          <th></th>
          <th>1</th>
          <th>2</th>
          <th>3</th>
          <th>4</th>
          <th>5</th>
          <th>6</th>
          <th>7</th>
          <th>8</th>
          <th>9</th>
          <th>計</th>
          <th>安</th>
          <th>失</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{ selectedGame.team_visitor }}</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td>{{ selectedGame.score_visitor }}</td>
          <td>{{ selectedGame.hits_visitor }}</td>
          <td>{{ selectedGame.errors_visitor }}</td>
        </tr>
        <tr>
          <td>{{ selectedGame.team_home }}</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td>{{ selectedGame.score_home }}</td>
          <td>{{ selectedGame.hits_home }}</td>
          <td>{{ selectedGame.errors_home }}</td>
        </tr>
      </tbody>
    </table>
    <table class='table is-bordered' v-if='result'>
      <tbody>
        <tr>
          <td>勝利投手</td>
          <td>{{ selectedGame.winning_pitcher }}</td>
        </tr>
        <tr>
          <td>敗戦投手</td>
          <td>{{ selectedGame.losing_pitcher }}</td>
        </tr>
        <tr>
          <td>セーブ</td>
          <td>{{ selectedGame.saving_pitcher }}</td>
        </tr>
      </tbody>
    </table>
    <table class='table is-bordered' v-if='result'>
      <tbody>
        <tr>
          <td rowspan='2'>本塁打</td>
          <td>{{ selectedGame.homerun_visitor }}</td>
        </tr>
        <tr>
          <td>{{ selectedGame.homerun_home }}</td>
        </tr>
      </tbody>
    </table>
    <Form v-if='result' :game='selectedGame'></Form>
  </div>
</template>
<script>
import Form from './form.vue'

export default {
  components: {
    Form
  },
  data() {
    return {
      games: [],
      currentYear: this.getCurrentYear(),
      currentMonth: this.getCurrentMonth(),
      cardYear: this.getCurrentYear(),
      cardMonth: this.getCurrentMonth(),
      cardDate: this.getCurrentDate(),
      calendarYear: this.getCurrentYear(),
      calendarMonth: this.getCurrentMonth(),
      calendarDate: this.getCurrentDate(),
      gameCards: [],
      monthlyCalendar: [],
      result: false,
      selectedGame: [],
    }
  },
  computed: {
    firstWday() {
      const firstDay = new Date(this.calendarYear, this.calendarMonth - 1, 1)
      return firstDay.getDay()
    },
    lastDate() {
      const lastDay = new Date(this.calendarYear, this.calendarMonth, 0)
      return lastDay.getDate()
    },
    getTodayCards() {
      this.gameCards = this.games.filter((value) => {
        return value.date === this.formatMonthDate().join('-')
      })
    },
  },
  mounted()  {
    this.getGameSchedule()
    this.getMonthlyCalendar()
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
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        credentials: 'same-origin',
        // redirect: 'manual'
      })
        .then((response) => response.json())
        .then((json) => {
          this.games = json
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    },
    getCurrentYear() {
      return new Date().getFullYear()
    },
    getCurrentMonth() {
      return new Date().getMonth() + 1
    },
    getCurrentDate() {
      return new Date().getDate()
    },
    getMonthlyCalendar() {
      // 火~土(firstWday:2~6)のときは(firstWday-1)回空白をpush
      // 日(firstWday=1)のときは5つ空白をpush
      let weeklyCalendar = []
      if (this.firstWday >= 2) {
        for (let blank = 1; blank < this.firstWday; blank++) {
          weeklyCalendar.push('')
        }
      } else if (this.firstWday === 0) {
        weeklyCalendar.push('', '', '', '', '', '')
      }
      for (let date = 1; date < this.lastDate + 1; date++) {
        weeklyCalendar.push(date)
        if (weeklyCalendar.length % 7 === 0 || date === this.lastDate) {
          this.monthlyCalendar.push(weeklyCalendar)
          weeklyCalendar = []
        }
      }
    },
    formatMonthDate() {
      // 日付を'YYYY-MM-DD'にフォーマット
      const date = `${this.cardYear}-${this.cardMonth}-${this.cardDate}`.split('-')
      if (date[1].length === 1) {
        date.splice(1, 1, `0${date[1]}`)
      }
      if (date[2].length === 1) {
        date.splice(2, 1, `0${date[2]}`)
      }
      return date
    },
    getGameCards(date) {
      this.cardYear = this.calendarYear
      this.cardMonth = this.calendarMonth
      this.cardDate = date

      this.gameCards = this.games.filter((value) => {
        return value.date === this.formatMonthDate().join('-')
      })
    },
    getScore(game_id) {
      this.result = true
      this.selectedGame = this.gameCards.find((value) => {
        return value.id === game_id
      })
    },
    previousMonth() {
      if (this.calendarMonth === 1) {
        this.calendarMonth = 12
        this.calendarYear--
      } else {
        this.calendarMonth--
      }
      this.monthlyCalendar = []
      this.getMonthlyCalendar()
    },
    nextMonth() {
      if (this.calendarMonth === 12) {
        this.calendarMonth = 1
        this.calendarYear++
      } else {
        this.calendarMonth++
      }
      this.monthlyCalendar = []
      this.getMonthlyCalendar()
    },
    oldestMonth() {
      return(
        this.calendarYear === 2021 &&
        this.calendarMonth === 3
      )
    },
    newestMonth() {
      return(
        this.calendarYear === this.currentYear &&
        this.calendarMonth === this.currentMonth
      )
    },
  }
}
</script>
