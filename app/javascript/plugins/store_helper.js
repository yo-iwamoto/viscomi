import router from '../router'

// viewをリダイレクトする
export const go = (path) => {
  router.push(path)
}

// エラーをログし、alertを表示
export const miss = (err) => {
  console.log(err)
  alert('エラーが発生しました。ご確認の上、再度お試しください。')
}