import Vue  from 'vue'
import Vuex from 'vuex'

import axios  from './api/axios'
import { go, miss } from './store_helper'

Vue.use(Vuex)

const state = {
  // ログイン中のユーザーのUserデータ
  userData: {
    id: null,
    is_manager: null
  },
  // ログイン中のユーザーが管理者ユーザーの場合、CommunityCenterデータが入る
  comData: {
    id: null,
    user_id: null
  },
  // いずれかのユーザーがログインしているか
  loggedIn: false,
  // メール認証を求めるモーダル表示用（VueXを使わなくて済むよう要修正）
  signedUp: false
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
  userData:  state => state.userData,
  comData:   state => state.comData,
  loggedIn:  state => state.loggedIn,
  signedUp:  state => state.signedUp,
  // gettersに記述すると、初期ロードでエラーになるため先にnullだけ代入し、
  // 参照する値がある場合にのみ正しい式を代入する。
  userId:    state => state.userData.id,
  comId:     state => state.comData.id,
  comUserId: state => state.comData.user_id
}

const actions = {
  // main.jsで最初に呼び出され、localStorageにuserDataがあればそれを取り出してログイン状態を作る
  // userDataが管理者ユーザーの場合、community_centers#findよりcomDataを取得
  autoLogin ({ commit }) {
    const userData = localStorage.getItem('userData')
    if (userData) {
      commit('updateUserData', userData)
      commit('updateLoggedIn', true)
      if (userData.is_manager === true) {
        axios.get(`/community_centers/${userData.id}`).then(res => {
          commit('updateComData', res.data)
        })
      }
    }
  },
  // メール認証が送信されるため、responseは無し
  signUp ({ commit }, data) {
    axios.post('/users', {
      user: {
        name: data.name,
        email: data.email,
        password: data.password
      }
    }).then(() => {
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
      localStorage.setItem('userData', res.data.userData)
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
    localStorage.removeItem('userData')
    commit('updateUserData', null)
    commit('updateComData', null)
    commit('updateLoggedIn', false)
    go('/')
  },
  // ログイン中のユーザーのパスワードが正しければ、管理者登録を行い、
  // userDataとcomDataを受け取って更新する。
  newManager ({ commit }, data) {
    const userId = this.getters.userId
    axios.post('/community_centers', {
      "userId": userId,
      "name": data.name,
      "password": data.password
    }).then(res => {
      // is_manager値が変わるため、userDataも受け取る
      commit('updateUserData', res.data.userData)
      commit('updateComData', res.data.comData)
      go('/mypage')
    }).catch(err => {
      // 409 Conflictのとき
      if (err.data.status === 409) {
        alert('お使いのメールアドレスは既に管理者登録済みです。')
      }
    })
  },
  editProfile ({ commit }, data) {
    const userId = this.getters.userId
    axios.patch(`/users/${userId}`, {
      "name": data.name
    }).then(res => {
      commit('updateUserData', res.data.userData)
      go('/mypage')
    })
  }
}

export default new Vuex.Store({
  state,
  mutations,
  getters,
  actions
})