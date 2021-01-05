// authentication利用時用のaxiosインスタンスを生成
import axios from 'axios'

export default axios.create({
  baseURL: '/api/v1'
})
