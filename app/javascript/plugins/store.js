import Vue from 'vue'
import Vuex from 'vuex'

// ルートを取得して遷移制御を行うため
import router from '../router'

// axiosインスタンスのインポート
import axios from './api/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    userId: null
  },
  mutations: {
    updateUserId (state, userId) {
      state.userId = userId
    }
  },
  getters: {
    userId: state => state.userId
  },
  actions: {
    autoLogin ({ commit }) {
      const userId = localStorage.getItem('userId')
      if (!userId) return
      commit('updateUserId', userId)
    },
    signUp ({ commit }, formData) {
      axios.post(
        '/users',
        {
          "user": {
            name: formData.name,
            email: formData.email,
            password: formData.password
          }
        }
      ).then(res => {
        commit('updateUserId', res.data.id)
        localStorage.setItem('userId', res.data.id)
        router.push('/mypage')
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    },
    logIn ({ commit }, formData) {
      axios.post(
        '/sessions',
        {
          "user": {
            email: formData.email,
            password: formData.password
          }
        }
      ).then(res => {
        commit('updateUserId', res.data.id)
        localStorage.setItem('userId', res.data.id)
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    },
    logOut ({ commit }) {
      commit('updateUserId', null)
      localStorage.setItem('userId', null)
    }
  }
})