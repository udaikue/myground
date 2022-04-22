<template>
  <div id='diaries' class='diary'>
    <div class='diary__items'>
      <div class='container'>
        <div class='diary__item'  v-if='gameCards.length && !result'>
          <h2 class='diary__item-title' v-if='gameCards.length && !result'>どの試合について書きますか？</h2>
          <div class='game-card-selector' id='game-cards'>
            <header class='game-card-selector__header'>
              <h3 class='game-card-selector__title'>{{ cardMonth }}月{{ cardDate }}日に行われた試合</h3>
            </header>
            <div class='game-card-selector__rows'>
              <div class='game-card-selector__row' v-for='game in gameCards' :key='game.id' @click='getScore(game.id)'>
                <div class='game-card-selector__column'>{{ getTeamName(game.team_home_id) }}</div>
                <div class='game-card-selector__column' id='game-card'>{{ game.score_home }} - {{ game.score_visitor }}</div>
                <div class='game-card-selector__column'>{{ getTeamName(game.team_visitor_id) }}</div>
              </div>
            </div>
          </div>
        </div>

        <div class='diary__item' v-if='!result'>
          <h2 class='diary__item-title' v-if='!gameCards.length && !result'>いつの日記を書きますか？</h2>
          <h2 class='diary__item-title' v-if='gameCards.length && !result'>日にちを変更する</h2>
          <div class='calendar-date-selector'>
            <div class='calendar-month-selector'>
              <div class='calendar-month-selector__item'><div v-if='!oldestMonth()' @click='previousMonth'>前の月</div></div>
              <div class='calendar-month-selector__item'><div>{{ calendarYear }}年{{ calendarMonth }}月</div></div>
              <div class='calendar-month-selector__item'><div v-if='!newestMonth()' @click='nextMonth'>次の月</div></div>
            </div>
            <div class='calendar-day-selector'>
              <table class='calendar-day-selector__table table is-fullwidth' id='calendar'>
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
                    <td v-for='date in week.value' :key='date.key' @click='getGameCards(date.date)'>
                      <div :class='linkDecoration(date.date)'>{{ date.date }}</div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <div class='diary-header diary-header__title' v-if='result'>{{ cardMonth }}月{{ cardDate }}日の試合</div>
        <div class='diary__item' v-if='result'>
          <h2 class='diary__item-title'>スコア</h2>
          <table class='table game-result-table score-board-table is-fullwidth is-bordered' id='score-board'>
            <thead>
              <tr>
                <th class='score-team-name'></th>
                <th v-for='score in displayScores' :key='score.id'>{{ score.inning }}</th>
                <th>計</th>
                <th>安</th>
                <th>失</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th class='score-element'>{{ getTeamName(selectedGame.team_visitor_id) }}</th>
                <td class='score-element' v-for='score in displayScores' :key='score.id'>{{ score.visitor }}</td>
                <td class='score-element'>{{ selectedGame.score_visitor }}</td>
                <td class='score-element'>{{ selectedGame.hits_visitor }}</td>
                <td class='score-element'>{{ selectedGame.errors_visitor }}</td>
              </tr>
              <tr>
                <th class='score-element'>{{ getTeamName(selectedGame.team_home_id) }}</th>
                <td class='score-element' v-for='score in displayScores' :key='score.id'>{{ score.home }}</td>
                <td class='score-element'>{{ selectedGame.score_home }}</td>
                <td class='score-element'>{{ selectedGame.hits_home }}</td>
                <td class='score-element'>{{ selectedGame.errors_home }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class='diary__item' v-if='result'>
          <h2 class='diary__item-title'>責任投手</h2>
          <table class='table game-result-table is-fullwidth is-bordered'>
            <tbody>
              <tr>
                <th class='record-element'>勝利投手</th>
                <td class='record-element'>{{ selectedGame.winning_pitcher }}</td>
              </tr>
              <tr>
                <th class='record-element'>敗戦投手</th>
                <td class='record-element'>{{ selectedGame.losing_pitcher }}</td>
              </tr>
              <tr>
                <th class='record-element'>セーブ</th>
                <td class='record-element'>{{ selectedGame.saving_pitcher }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class='diary__item' v-if='result'>
          <h2 class='diary__item-title'>本塁打</h2>
          <table class='table game-result-table is-fullwidth is-bordered'>
            <tbody>
              <tr>
                <th class='record-element'>{{ getTeamName(selectedGame.team_visitor_id) }}</th>
                <td class='record-element'>{{ selectedGame.homerun_visitor }}</td>
              </tr>
              <tr>
                <th class='record-element'>{{ getTeamName(selectedGame.team_home_id) }}</th>
                <td class='record-element'>{{ selectedGame.homerun_home }}</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class='diary__item' v-if='!result'>
          <button class='button is-gray-light is-small' type='button' onclick='history.back()'>キャンセル</button>
        </div>

      </div>
    </div>
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
      gamesForCalendarMonth: [],
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
          this.gamesForCalendarMonth = json
          this.getGamesForDisplayMonth()
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
        return value.date === `${this.cardYear}-${this.twoDigitsFormatter(this.cardMonth)}-${this.twoDigitsFormatter(this.cardDate)}`
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
    twoDigitsFormatter(digit) {
      return digit.toString().length === 1 ? `0${digit}` : digit
    },
    getGameCards(date) {
      this.cardYear = this.calendarYear
      this.cardMonth = this.calendarMonth
      this.cardDate = date

      this.gameCards = this.games.filter((value) => {
        return value.date === `${this.cardYear}-${this.twoDigitsFormatter(this.cardMonth)}-${this.twoDigitsFormatter(this.cardDate)}`
      })
      this.gameCards.sort(function(a, b) {
        if(a.team_home_id < b.team_home_id) return -1
        if(a.team_home_id < b.team_home_id) return 1
        return 0
      })
    },
    getScore(game_id) {
      this.result = true
      this.selectedGame = this.gameCards.find((value) => {
        return value.id === game_id
      })
      this.getGameScores(game_id)
    },
    getGamesForDisplayMonth() {
      let year = this.calendarYear
      let month = this.calendarMonth
      this.gamesForDisplayMonth.filter((value) => {
        return value.date.includes(`${year}-${this.twoDigitsFormatter(month)}`)
      })
    },
    linkDecoration(date) {
      let todaysGame = []
      if (date !== undefined) {
        let month = this.calendarMonth
        todaysGame = this.gamesForCalendarMonth.filter((value) => {
          return value.date.includes(`${this.twoDigitsFormatter(month)}-${this.twoDigitsFormatter(date)}`)
        })
      }
      if (todaysGame.length > 0) {
        return 'game-date'
      }
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
