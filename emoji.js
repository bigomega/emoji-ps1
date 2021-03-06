const ANIMATE_SWITCH = process.argv[2] || 0
const PS_TASK_OVER = +process.env['PS_TASK_OVER'] || NaN
const fun_list = "๐ป,๐พ,๐,๐,๐ ,๐ฅท ,๐งถ,๐งต,๐,๐ฐ,๐ฆ,๐ผ,๐จ,๐ท,๐ธ,๐ฆ,๐,๐ข,๐,๐ฆ,๐ก,๐ ,๐ณ,๐ฟ ,๐ฆข,๐ชต ,๐ต,๐,๐,๐,๐ธ,๐ผ,๐,๐ฅ,โ๏ธ ,๐,โ๏ธ ,๐,๐,๐,๐,๐,๐ฅฅ,๐ฅ,๐ฅ,๐ถ ,๐ง,๐ฟ,๐บ,โฝ๏ธ,๐,๐,๐ฅ,๐น,๐ฅ,๐ ,๐ ,โบ๏ธ,๐ป,๐ฟ,โ๏ธ ,๐,โณ,๐,๐งฒ,๐ฎ,๐ชฃ ,๐ฆ,โค๏ธ ,๐งก,๐,๐,๐,๐,๐ค,๐ค,๐ค,๐ฎ๐ณ ".split(',')
const activity_list = '๐จ,๐ฆฎ,๐,โ๏ธ ,๐ธ,๐น,๐๐ปโโ๏ธ'.split(',')
const getRandom = arr => arr[arr.length * Math.random() | 0]
const date = new Date()
const now = +`${date.getHours()}${date.getMinutes()<10?'0':''}${date.getMinutes()}`
// now=1910

const timings = [
  // from, duration, emoji, highlight?, unstoppable?
  [0, 500, '๐', true, true],
  [530, 200, getRandom(activity_list)],
  [800, 200, '๐ฅช', true],
  [1300, 130, '๐', true],
  [1600, 100, getRandom(activity_list)],
  [1700, 130, getRandom(activity_list), true, true],
  [1900, 200, '๐', true],
  [2130, 100, getRandom(['๐ฅฑ', '๐ด']), false],
  [2230, 100, getRandom(['๐ฅฑ', '๐ด']), false, true],
  [2300, 100, '๐', false, true],
]

let emoji = ''
timings.forEach(([from, duration, e, highlight, unstoppable]) => {
  if (!unstoppable && PS_TASK_OVER /* && now < PS_TASK_OVER + duration */) { return }
  if (now >= from && now < from+duration) {
      emoji += e
    if (highlight && (unstoppable || !PS_TASK_OVER /* || now > PS_TASK_OVER + duration */)) {
      // unstoppable & stoppable + not-stopped
      emoji += +ANIMATE_SWITCH ? `โฌ ` : ` โฌ`
    }
  }
})
if (emoji.length === 0) { emoji = getRandom(fun_list) }

console.log(`${emoji}`)
// process.exit()
