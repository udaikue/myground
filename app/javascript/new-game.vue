<template>
  <div id='diaries'>
    <section>
      <h2>試合結果</h2>
        <p v-if='!gameCards.length && !result'>いつの日記を書きますか？</p>
        <p v-if='gameCards.length && !result'>どの試合について書きますか？</p>
      <div class='columns is-mobile'>
        <table class='table is-fullwidth' v-if='gameCards.length && !result' id='game-cards'>
          <thead>
            <tr>
              <th></th>
              <th>{{ cardMonth }}月 {{ cardDate }}日</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for='game in gameCards' :key='game.id' @click='getScore(game.id)'>
              <td>{{ getTeamName(game.team_home_id) }}</td>
              <td>{{ game.score_home }} - {{ game.score_visitor }}</td>
              <td>{{ getTeamName(game.team_visitor_id) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class='columns is-mobile' v-if='!result'>
        <div class='column is-one-quarter-mobile' v-if='!oldestMonth()' @click='previousMonth'>前の月</div>
        <div class='column is-one-quarter-mobile'>{{ calendarYear }}年{{ calendarMonth }}月</div>
        <div class='column is-one-quarter-mobile' v-if='!newestMonth()' @click='nextMonth'>次の月</div>
      </div>
      <div class='columns is-mobile'>
        <table class='table is-fullwidth' v-if='!result' id='calendar'>
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
            <tr v-for='week in monthlyCalendar' :key='week.id'>
              <td v-for='date in week.value' :key='date.key' @click='getGameCards(date.date)'>{{ date.date }}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class='columns is-mobile'>
        <table class='table is-fullwidth' v-if='result'>
          <thead>
            <tr>
              <th ></th>
              <th v-for='score in displayScores' :key='score.id'>{{ score.inning }}</th>
              <th>計</th>
              <th>安</th>
              <th>失</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>{{ getTeamName(selectedGame.team_visitor_id) }}</td>
              <td v-for='score in displayScores' :key='score.id'>{{ score.visitor }}</td>
              <td>{{ selectedGame.score_visitor }}</td>
              <td>{{ selectedGame.hits_visitor }}</td>
              <td>{{ selectedGame.errors_visitor }}</td>
            </tr>
            <tr>
              <td>{{ getTeamName(selectedGame.team_home_id) }}</td>
              <td v-for='score in displayScores' :key='score.id'>{{ score.home }}</td>
              <td>{{ selectedGame.score_home }}</td>
              <td>{{ selectedGame.hits_home }}</td>
              <td>{{ selectedGame.errors_home }}</td>
            </tr>
          </tbody>
        </table>
      </div>
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
      <button v-if='!result' class='button is-light' type='button' onclick='history.back()'>キャンセル</button>
    </section>
    <NewForm v-if='result' :game='selectedGame' :diariesPath='diariesPath'></NewForm>
  </div>
</template>
<script>
import NewForm from './new-form.vue'

export default {
  components: {
    NewForm
  },
  props: {
    diariesPath: { type: String, required: true }
  },
  data() {
    return {
      games: [],
      scores: [],
      currentYear: this.getCurrentYear(),
      currentMonth: this.getCurrentMonth(),
      cardYear: this.getCurrentYear(),
      cardMonth: this.getCurrentMonth(),
      cardDate: this.getCurrentDate(),
      calendarYear: this.getCurrentYear(),
      calendarMonth: this.getCurrentMonth(),
      calendarDate: this.getCurrentDate(),
      gameCards: [],
      displayScores: [],
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
      fetch('/api/games', {
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
          this.games = json
          this.getTodayCards()
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    },
    getGameScores(game_id) {
      fetch('/api/scores', {
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
          this.scores = json
          this.getDisplayScores(game_id)
        })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    },
    getTeamName(team_id) {
      switch(team_id) {
        case 1:
          return '巨人'
        case 2:
          return 'ヤクルト'
        case 3:
          return 'DeNA'
        case 4:
          return '中日'
        case 5:
          return '阪神'
        case 6:
          return '広島'
        case 7:
          return '日本ハム'
        case 8:
          return '楽天'
        case 9:
          return '西武'
        case 10:
          return 'ロッテ'
        case 11:
          return 'オリックス'
        case 12:
          return 'ソフトバンク'
      }
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
    getTodayCards() {
      this.gameCards = this.games.filter((value) => {
        return value.date === this.formatMonthDate().join('-')
      })
    },
    getDisplayScores(game_id) {
      let selectedScores = this.scores.filter((value) => {
        return value.game_id === game_id
      })

      for (let id = 1; id <= selectedScores.length; id++) {
        selectedScores.forEach(element => {
          if (element.inning === id) {
            this.displayScores.push({ id: id, inning: id, home: element.home, visitor: element.visitor })
          }
        })
      }
      // コールドゲーム(9回未満)のときもスコアは9回まで表示する
      if (selectedScores.length < 9) {
        for (let id = selectedScores.length + 1 ; id <= 9; id++) {
          this.displayScores.push({ id: id, inning: id })
        }
      }
    },
    getMonthlyCalendar() {
      // { id: 1, value: {{ key: 0 }, { key: 1 }, { key: 2, date: 1 }, ... }
      // { id: 2, value: { ... }}
      // 空白のときはvalueにはkeyのみ入る。上記は水曜はじまりの例

      let value = []
      let key = 0
      let id = 1
      if (this.firstWday >= 2) {
        for (let blank = 1; blank < this.firstWday; blank++) {
          value.push({ key: key })
          key++
        }
      } else if (this.firstWday === 0) {
        for (key = 0; key < 6; key++) {
          value.push({ key: key })
        }
      }
      for (let date = 1; date < this.lastDate + 1; date++) {
        value.push({ key: key, date: date })
        key++
        if (value.length % 7 === 0 || date === this.lastDate) {
          this.monthlyCalendar.push({ id: id, value: value })
          value = []
          id++
          key = 0
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
      // this.gameCards.forEach((value, index) => {
      //   console.log(value.replace(1, 1))
      // })
    },
    getScore(game_id) {
      this.result = true
      this.selectedGame = this.gameCards.find((value) => {
        return value.id === game_id
      })
      this.getGameScores(game_id)
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
