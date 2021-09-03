const ANIMATE_SWITCH = process.argv[2] || 0
const PS_TASK_OVER = +process.env['PS_TASK_OVER'] || NaN
const fun_list = "👻,👾,🎃,💋,👁 ,🥷 ,🧶,🧵,👑,🐰,🦊,🐼,🐨,🐷,🐸,🦋,🐌,🐢,🐙,🦀,🐡,🐠,🐳,🐿 ,🦢,🪵 ,🌵,🍀,🍁,🍄,🌸,🌼,🌏,🔥,☂️ ,🌊,❄️ ,🍋,🍌,🍉,🍓,🍒,🥥,🥝,🥑,🌶 ,🧀,🍿,🍺,⚽️,🏀,🏐,🥊,🎹,🥁,🏖 ,🏔 ,⛺️,💻,💿,☎️ ,📟,⏳,🔋,🧲,🔮,🪣 ,📦,❤️ ,🧡,💛,💚,💙,💜,🖤,🤍,🤎,🇮🇳 ".split(',')
const activity_list = '🎨,🦮,📚,✍️ ,🎸,🛹,🏃🏻‍♂️'.split(',')
const getRandom = arr => arr[arr.length * Math.random() | 0]
const date = new Date()
const now = +`${date.getHours()}${date.getMinutes()<10?'0':''}${date.getMinutes()}`
// now=1910

const timings = [
  // from, duration, emoji, highlight?, unstoppable?
  [0, 500, '🛌', true, true],
  [530, 200, getRandom(activity_list)],
  [800, 200, '🥪', true],
  [1300, 130, '🍛', true],
  [1600, 100, getRandom(activity_list)],
  [1700, 130, getRandom(activity_list), true, true],
  [1900, 200, '🍕', true],
  [2130, 100, getRandom(['🥱', '😴']), false],
  [2230, 100, getRandom(['🥱', '😴']), false, true],
  [2300, 100, '🛌', false, true],
]

let emoji = ''
timings.forEach(([from, duration, e, highlight, unstoppable]) => {
  if (!unstoppable && PS_TASK_OVER /* && now < PS_TASK_OVER + duration */) { return }
  if (now >= from && now < from+duration) {
      emoji += e
    if (highlight && (unstoppable || !PS_TASK_OVER /* || now > PS_TASK_OVER + duration */)) {
      // unstoppable & stoppable + not-stopped
      emoji += +ANIMATE_SWITCH ? `⬅ ` : ` ⬅`
    }
  }
})
if (emoji.length === 0) { emoji = getRandom(fun_list) }

console.log(`${emoji}`)
// process.exit()
