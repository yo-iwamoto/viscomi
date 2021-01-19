import Vue  from 'vue'
import Vuex from 'vuex'

import axios  from './api/axios'
import { go, miss } from './store_helper'

Vue.use(Vuex)

const state = {
  // ログアウト状態でgetterからカラムを参照しようとした時にエラーが起きるため、nullでカラムも初期化しておく
  // ログイン中のユーザーのUserデータ
  userData: {
    id: null,
    is_manager: null,
    following_center: {
      id: 1
    }
  },
  // ログイン中のユーザーが管理者ユーザーの場合、CommunityCenterデータが入る
  comData: {
    id: null,
    user_id: null
  },
  // いずれかのユーザーがログインしているか
  loggedIn: false,
  // メール認証を求めるモーダル表示用（VueXを使わなくて済むよう要修正）
  signedUp: false,
}

const mutations = {
  updateUserData (state, v) {
    state.userData = v
  },
  updateComData (state, v) {
    state.comData = v
  },
  updateLoggedIn (state, v) {
    state.loggedIn = v
  },
  updateSignedUp (state, v) {
    state.signedUp = v
  }
}

let getters = {
  userData:        state => state.userData,
  comData:         state => state.comData,
  loggedIn:        state => state.loggedIn,
  signedUp:        state => state.signedUp,
  userId:          state => state.userData.id,
  userFollowingId: state => {
    if (state.userData) {
      if (state.userData.following_center) {
        return state.userData.following_center.id
      }
    }
  },
  comId:           state => state.comData.id,
  comUserId:       state => state.comData.user_id
}

const actions = {
  // main.jsで最初に呼び出され、localStorageにuserDataがあればそれを取り出してログイン状態を作る
  // userDataが管理者ユーザーの場合、community_centers#findよりcomDataを取得
  autoLogin ({ commit, dispatch }) {
    let userId = localStorage.getItem('userId')
    if (userId) {
      axios.get(`/users/${userId}`).then(res => {
        commit('updateUserData', res.data)
        commit('updateLoggedIn', true)
        if (res.data.is_manager) {
          dispatch('getComData', res.data.community_center_id)
        }
      })
    }
  },
  getComData ({ commit }, comId) {
    axios.get(`/community_centers/${comId}`).then(res => {
      commit('updateComData', res.data)
    })
  },
  // メール認証が送信されるため、responseは無し
  signUp ({ commit }, data) {
    axios.post('/users', data).then(() => {
      commit('updateSignedUp', true)
      go('/')
    }).catch(err => {
      // 409 Conflictのとき
      if (err.status === 409) {
        alert('登録済みのメールアドレスです。ログインしてください。')
      miss(err)
      }
    })
  },
  // sessions#createでpasswordを確認し、合っていればuserDataを返す
  // 更に管理者ユーザーの場合、comDataも返す
  logIn ({ commit }, data) {
    axios.post('/sessions', {
      "email": data.email,
      "password": data.password
    }).then(res => {
      commit('updateUserData', res.data.userData)
      localStorage.setItem('userId', res.data.userData.id)
      if (res.data.comData) {
        commit('updateComData', res.data.comData)
      }
      commit('updateLoggedIn', true)
      go('/mypage')
    }).catch(err => {
      miss(err)
    })
  },
  // localStorageを削除、stateのuserData, comDataをnullで更新し、loggedInはfalseにする
  logOut ({ commit }) {
    localStorage.removeItem('userId')
    commit('updateUserData', {
      id: null,
      is_manager: null
    })
    commit('updateComData', {
      id: null,
      user_id: null
    })
    commit('updateLoggedIn', false)
    go('/')
  },
  // ログイン中のユーザーのパスワードが正しければ、管理者登録を行い、
  // userDataとcomDataを受け取って更新する。
  newManager ({ commit }, data) {
    axios.post('/community_centers', data).then(res => {
      // is_manager値が変わるため、userDataも受け取る
      commit('updateUserData', res.data.userData)
      commit('updateComData', res.data.comData)
      go('/mypage')
    }).catch(err => {
      // 409 Conflictのとき
      if (err.status === 409) {
        alert('お使いのメールアドレスは既に管理者登録済みです。')
      }
      miss(err)
    })
  },
  editProfile ({ commit }, data) {
    let userId = this.getters.userId
    axios.patch(`/users/${userId}`, {
      "name": data.name
    }).then(res => {
      commit('updateUserData', res.data.userData)
      go('/mypage')
    })
  },
  editComPage ({ commit }, data) {
    let comId = this.getters.comId
    axios.patch(`/community_centers/${comId}`, data).then(res => {
      commit('updateComData', res.data.comData)
      go(`/center/${comId}`)
    }).catch(err => {
      miss(err)
    })
  }
}

export default new Vuex.Store({
  state,
  mutations,
  getters,
  actions
})