import Vue from 'vue'
import Vuex from 'vuex'

// ルートを取得して遷移制御を行うため
import router from '../router'

// axiosインスタンスのインポート
import axios from './api/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    userId: -1,
    fromSignUp: false,
    userData: {},
    communityCenterData: {}
  },
  mutations: {
    updateUserId (state, userId) {
      state.userId = userId
    },
    whenSignUp (state, v) {
      state.fromSignUp = v
    },
    updateUserData (state) {
      const userId = state.userId
      if (userId !== -1) {
        axios.get(`/users/${userId}`).then(res => {
          state.userData = res.data
        }).catch(err => {
          console.log(err)
        })
      } else {
        state.userData = {}
      }
    },
    updateCommunityCenterData (state, data) {
      state.communityCenterData = data
    }
  },
  getters: {
    userId: state => state.userId,
    fromSignUp: state => state.fromSignUp,
    userData: state => state.userData,
    communityCenterData: state => state.communityCenterData
  },
  actions: {
    autoLogin ({ commit }) {
      const userId = localStorage.getItem('userId')
      if (!!userId) {
        commit('updateUserId', userId)
        commit('updateUserData')
      }
    },
    signUp ({ commit }, formData) {
      axios.post('/users', {
          "user": {
            name: formData.name,
            email: formData.email,
            password: formData.password
          }
        }
      ).then(res => {
        commit('updateUserId', res.data.id)
        localStorage.setItem('userId', res.data.id)
        commit('updateUserData')
        commit('whenSignUp', true)
        router.push('/')
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    },
    logIn ({ commit }, formData) {
      axios.post('/sessions', {
          email: formData.email,
          password: formData.password
        }
      ).then(res => {
        commit('updateUserId', res.data.id)
        localStorage.setItem('userId', res.data.id)
        commit('updateUserData')
        router.push('/mypage')
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    },
    logOut ({ commit }) {
      commit('updateUserId', -1)
      localStorage.setItem('userId', -1)
      commit('updateUserData')
      commit('updateCommunityCenterData', {})
    },
    newManager({ commit }, formData) {
      axios.post('/community_centers', {
        id: this.getters.userId,
        name: formData.name,
        password: formData.password
      }).then(res => {
        console.log(res)
        commit('updateCommunityCenterData', res.data)
        router.push('/mypage')
      }).catch(err => {
        console.log(err)
      })
    }
  }
})