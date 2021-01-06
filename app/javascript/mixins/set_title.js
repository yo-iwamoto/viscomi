// ルートタイトルを設定する関数
export const setTitle = title => {
  const siteTitle = 'ビズコミ'
  const pageTitle = !title ? siteTitle : title + '|' + siteTitle
  return (window.document.title = pageTitle)
}

export const globalMixins = {
  methods: {
    setTitle
  }
}