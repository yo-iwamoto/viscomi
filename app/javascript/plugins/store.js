import Vue  from 'vue'
import Vuex from 'vuex'

import axios  from './api/axios'
import { go, miss } from './store_helper'

Vue.use(Vuex)

let state = {
  // ログアウト状態でgetterからカラムを参照しようとした時にエラーが起きるため、nullでカラムも初期化しておく
  // ログイン中のユーザーのUserデータ
  userData: {
    id: null,
    is_manager: null,
    admin: false,
    following: {
      id: null
    }
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
  updateLoggedIn (state, v) {
    state.loggedIn = v
  },
  updateSignedUp (state, v) {
    state.signedUp = v
  }
}

let getters = {
  userData:        state => state.userData,
  loggedIn:        state => state.loggedIn,
  signedUp:        state => state.signedUp,
  userId:          state => state.userData.id,
  admin:           state => state.userData.admin,
  followingId:     state => {
    if (state.userData) {
      if (state.userData.following) {
        return state.userData.following.id
      }
    }
  }
}

const actions = {
  // main.jsで最初に呼び出され、localStorageにuserDataがあればそれを取り出してログイン状態を作る
  autoLogin ({ commit }) {
    let userId = localStorage.getItem('userId')
    if (userId) {
      axios.get(`/users/${userId}`).then(res => {
        commit('updateUserData', res.data)
        commit('updateLoggedIn', true)
      })
    }
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
  logIn ({ commit }, data) {
    axios.post('/sessions', {
      "email": data.email,
      "password": data.password
    }).then(res => {
      commit('updateUserData', res.data.userData)
      localStorage.setItem('userId', res.data.userData.id)
      commit('updateLoggedIn', true)
      if (res.data.userData.is_manager) {
        go(`/center/${res.data.userData.following.id}`)
      } else {
        go('/')
      }
    }).catch(err => {
      miss(err)
    })
  },
  // localStorageを削除、stateのuserDataをnullで更新し、loggedInはfalseにする
  logOut ({ commit }) {
    localStorage.removeItem('userId')
    let userId = this.getters.userId
    axios.delete(`/sessions/${userId}`)
    commit('updateUserData', {
      id: null,
      is_manager: null,
      admin: false,
      following: {
        id: null
      }
    })
    commit('updateLoggedIn', false)
    go('/')
  },
  // ログイン中のユーザーのパスワードが正しければ、管理者登録を行い、userDataを更新
  newManager ({ commit }, data) {
    axios.post('/community_centers', data).then(res => {
      // is_manager値が変わるため、userDataも受け取る
      commit('updateUserData', res.data.userData)
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
    // RESTにするため便宜上id=1にしているが、バックエンドのセッション情報からユーザーを特定する
    axios.patch('/users/1', data).then(res => {
      commit('updateUserData', res.data.userData)
      go('/mypage')
    })
  },
  editComPage ({ commit }, data) {
    let followingId = this.getters.followingId
    axios.patch('/community_center', data).then(res => {
      commit('updateUserData', res.data.userData)
      go(`/center/${followingId}`)
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