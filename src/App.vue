<template>
  <v-app>
    <v-main v-if="isLogin">
      <SideNav @access="Login($event)"/>
      <router-view />
    </v-main>
    <v-main v-else class="d-flex justify-center align-center">
        <Login @access="Login($event)"/>
    </v-main>
  </v-app>
</template>

<script>
import Login from './components/Login.vue';

export default {
  data() {
    return {
      isLogin: false,
    }
  },
  methods: {
    Login(value){
      this.isLogin = value;
    }
  }
}
</script>
