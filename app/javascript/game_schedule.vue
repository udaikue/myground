<template>
  <div id="gameSchedule">
    <ul>
      <li v-for='game in games' :key='game.id'>
        {{ game.team_home }} VS {{ game.team_visitor }}
      </li>
    </ul>
    <div class='columns is-mobile'>
      <div class='column is-one-quarter-mobile' v-if='!oldestMonth()' @click='previousMonth'>前の月</div>
      <div class='column is-one-quarter-mobile'>{{ calendarYear }}年{{ calendarMonth }}月</div>
      <div class='column is-one-quarter-mobile' v-if='!newestMonth()' @click='nextMonth'>次の月</div>
    </div>
    <table class='table'>
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
          <td v-for='date in monthlyCalendar[0]' :key='date.id'>{{ date }}</td>
        </tr>
        <tr>
          <td v-for='date in monthlyCalendar[1]' :key='date.id'>{{ date }}</td>
        </tr>
        <tr>
          <td v-for='date in monthlyCalendar[2]' :key='date.id'>{{ date }}</td>
        </tr>
        <tr>
          <td v-for='date in monthlyCalendar[3]' :key='date.id'>{{ date }}</td>
        </tr>
        <tr v-if='monthlyCalendar[4]'>
          <td v-for='date in monthlyCalendar[4]' :key='date.id'>{{ date }}</td>
        </tr>
        <tr v-if='monthlyCalendar[5]'>
          <td v-for='date in monthlyCalendar[5]' :key='date.id'>{{ date }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
export default {
  data() {
    return {
      games: [],
      currentYear: this.getCurrentYear(),
      currentMonth: this.getCurrentMonth(),
      calendarYear: this.getCurrentYear(),
      calendarMonth: this.getCurrentMonth(),
      monthlyCalendar: [],
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
    },
    getCurrentYear() {
      return new Date().getFullYear()
    },
    getCurrentMonth() {
      return new Date().getMonth() + 1
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
