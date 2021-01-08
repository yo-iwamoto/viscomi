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
    fromEdit: false,
    userData: null,
    communityCenterData: null,
    comPageData: null,
    postData: null
  },
  mutations: {
    updateUserId (state, userId) {
      state.userId = userId
    },
    whenSignUp (state, v) {
      state.fromSignUp = v
    },
    whenEdit (state, v) {
      state.fromEdit = v
    },
    updateUserData (state, data) {
      state.userData = data
    },
    updateCommunityCenterData (state, data) {
      state.communityCenterData = data
    },
    updateComPageData (state, data) {
      state.comPageData = data
    },
    updatePostData (state, data) {
      state.postData = data
    }
  },
  getters: {
    userId: state => state.userId,
    fromSignUp: state => state.fromSignUp,
    fromEdit: state => state.fromEdit,
    userData: state => state.userData,
    communityCenterData: state => state.communityCenterData,
    comPageData: state => state.comPageData,
    postData: state => state.postData
  },
  actions: {
    autoLogin ({ commit, dispatch }) {
      const userId = localStorage.getItem('userId')
      if (!!userId) {
        commit('updateUserId', userId)
        axios.get(`/users/${this.getters.userId}`).then(res => {
          commit('updateUserData', res.data)
        })
        dispatch('getComData')
      }
    },
    signUp ({ commit }, formData) {
      axios.post('/users', {
          "user": {
            "name": formData.name,
            "email": formData.email,
            "password": formData.password
          }
        }
      ).then(res => {
        commit('updateUserId', res.data.id)
        localStorage.setItem('userId', res.data.id)
        axios.get(`/users/${this.getters.userId}`).then(res => {
          commit('updateUserData', res.data)
        })
        commit('whenSignUp', true)
        router.push('/')
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    },
    logIn ({ commit, dispatch }, formData) {
      axios.post('/sessions', {
          "email": formData.email,
          "password": formData.password
        }
      ).then(res => {
        commit('updateUserId', res.data.id)
        localStorage.setItem('userId', res.data.id)
        commit('updateUserData', res.data)
        dispatch('getComData')
        router.push('/mypage')
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    },
    logOut ({ commit }) {
      commit('updateUserId', -1)
      localStorage.setItem('userId', -1)
      commit('updateUserData', null)
      commit('updateCommunityCenterData', null)
      commit('updateComPageData', null)
    },
    newManager({ commit }, formData) {
      axios.post('/community_centers', {
        "import {  } from 'module';": this.getters.userId,
        "name": formData.name,
        "password": formData.password
      }).then(res => {
        console.log(res)
        commit('updateCommunityCenterData', res.data)
        axios.get(`/users/${this.getters.userId}`).then(res => {
          commit('updateUserData', res.data)
        })
        router.push('/mypage')
      }).catch(err => {
        console.log(err)
      })
    },
    getComData({ commit }) {
      axios.get(`/community_centers/${this.getters.userId}`).then(res => {
        commit('updateCommunityCenterData', res.data)
      }).catch(err => {
        console.log(err)
      })
    },
    getComPageData({ commit }, comId) {
      axios.get(`/community_centers/page/${comId}`).then(res => {
        commit('updateComPageData', res.data)
      }).catch(err => {
        console.log(err)
      })
    },
    getTimeLineData() {},
    getPostData () {},
    editProfile ({ commit }, userData, img) {
      axios.patch(`/users/${this.getters.userId}`, {
        "name": userData.name,
        "image": img
      }).then(res => {
        commit('updateUserData', res.data)
        commit('whenEdit', true)
        router.push('/mypage')
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    },
    newPost ({ commit }, formData) {
      axios.post('/posts', formData).then(res => {
        commit('updatePostData', res.data)
        router.push(`/mypage`)
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。お手数ですが、入力内容をご確認の上、再度お試しください。')
      })
    }
  }
})