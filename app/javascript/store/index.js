import Vue  from 'vue'
import Vuex from 'vuex'

import router from '../router'
import axios  from '../plugins/axios'

axios.interceptors.request.use(
  config => {
    let accessToken = localStorage.getItem('Access-Token')
    config.headers.common['Access-Token'] = accessToken
    return config
  }
)

Vue.use(Vuex)

const state = {
  // ログアウト状態でgetterからカラムを参照しようとした時にエラーが起きるため、nullでカラムも初期化しておく
  // ログイン中のユーザーのUserデータ
  userData: {
    id: null,
    is_manager: null,
    following: {
      id: null
    },
    mute_contact: false
  },
  // いずれかのユーザーがログインしているか
  loggedIn: false,
  // メール認証を求めるモーダル表示用（VueXを使わなくて済むよう要修正）
  signedUp: false,
  isLoading: false,
  modalState: false
}

const mutations = {
  updateUserData  (state, v) {
    state.userData = v
  },
  updateLoggedIn  (state, v) {
    state.loggedIn = v
  },
  updateSignedUp  (state, v) {
    state.signedUp = v
  },
  updateIsLoading (state, v) {
    state.isLoading = v
  },
  updateModalState (state, v) {
    state.modalState = v
  }
}

const getters = {
  userData:        state => state.userData,
  loggedIn:        state => state.loggedIn,
  signedUp:        state => state.signedUp,
  userId:          state => state.userData.id,
  isLoading:       state => state.isLoading,
  modalState:      state => state.modalState,
  isManager:       state => state.userData.is_manager,
  followingId:     state => {
    if (state.userData) {
      if (state.userData.following) {
        return state.userData.following.id
      }
    }
  }
}

const actions = {
  // hello_vue.jsで最初に呼び出され、localStorageにuserDataがあればそれを取り出してログイン状態を作る
  autoLogin ({ commit }) {
    let accessToken = localStorage.getItem('Access-Token')
    if (accessToken) {
      commit('updateLoggedIn', true)
      axios.get(`/users/1`).then(res => {
        commit('updateUserData', res.data)
      }).catch(() => {
        commit('updateLoggedIn', false)
      })
    }
  },
  signUp ({ commit, dispatch }, data) {
    commit('updateIsLoading', true)
    axios.post('/users', data).then(() => {
      commit('updateSignedUp', true)
      dispatch('logIn', data.user)
    }).catch(err => {
      commit('updateIsLoading', false)
      // 409 Conflictのとき
      if (err.response.status === 409) {
        alert('登録済みのメールアドレスです。ログインしてください。')
      } else {
        alert('認証に失敗しました。')
      }
    })
  },
  logIn ({ commit }, data) {
    let signedUp = this.getters.signedUp
    axios.post('/sessions', {
      "email": data.email,
      "password": data.password
    }).then(res => {
      localStorage.setItem('Access-Token', res.headers['access-token'])
      commit('updateUserData', res.data.userData)
      commit('updateLoggedIn', true)
      commit('updateIsLoading', false)
      if (res.data.userData.is_manager) {
        router.push({ path: 'center', query: { cid: res.data.userData.following.id } })
      } else if (signedUp) {
        commit('updateSignedUp', false)
        router.push('/guide')
      } else {
        router.push('/')
      }
    }).catch(() => {
      commit('updateIsLoading', false)
      alert('メールアドレスかパスワードが間違っています。ご入力内容を再度お確かめください。')
    })
  },
  // localStorageを削除、stateのuserDataをnullで更新し、loggedInはfalseにする
  logOut ({ commit }) {
    localStorage.removeItem('Access-Token')
    commit('updateUserData', {
      id: null,
      is_manager: null,
      admin: false,
      following: {
        id: null
      }
    })
    commit('updateLoggedIn', false)
    // NavigationDuplicatedを避けるためreplaceを使用
    router.replace('/')
  },
  // ログイン中のユーザーのパスワードが正しければ、管理者登録を行い、userDataを更新
  newManager ({ commit }, data) {
    axios.post('/community_centers', data).then(res => {
      commit('updateUserData', res.data.userData)
      router.push('/mypage')
    }).catch(err => {
      // 409 Conflictのとき
      if (err.status === 409) {
        alert('お使いのメールアドレスは既に管理者登録済みです。')
      } else {
        alert('エラーが発生しました。入力内容をお確かめの上、再度お試しください。')
      }
    })
  },
  editProfile ({ commit }, data) {
    let userId = this.getters.userId
    axios.patch(`/users/${userId}`, data).then(res => {
      commit('updateUserData', res.data.userData)
      router.push('/mypage')
    }).catch(() => {
      alert('エラーが発生しました')
    })
  },
  editComPage ({ commit }, data) {
    let followingId = this.getters.followingId
    axios.patch('/community_centers/1', {
      name: data.name,
      comment: data.comment
    }).then(res => {
      axios.post('/community_center_image', data.image).then(() => {
        commit('updateUserData', res.data.userData)
        router.push({ path: 'center', query: { cid: followingId } })
      }).catch(err => {
        alert(err)
      })
    }).catch(err => {
      alert(err)
    })
  }
}

export default new Vuex.Store({
  state,
  mutations,
  getters,
  actions
})