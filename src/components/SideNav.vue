<template>
  <v-toolbar app>
    <v-app-bar-nav-icon class="hidden-lg-and-up" variant="text" @click="drawer = !drawer"></v-app-bar-nav-icon>
    <v-toolbar-title>{{ header }}</v-toolbar-title>
  </v-toolbar>
  <v-navigation-drawer app v-model="drawer">
    <v-list>
      <v-list-item prepend-avatar="../assets/images/logo.png" title="BARANGAY STA. CRUZ"></v-list-item>
    </v-list>
    <v-divider></v-divider>
    <v-list v-for="list in lists" :key="list.text">
      <v-list-item class="navigationsIcons" :prepend-icon="list.icon" :title="list.text" :to="list.route"
        min-height="50" @click="overlay = !overlay">
      </v-list-item>
    </v-list>
    <v-divider></v-divider>
    <v-list>
      <v-list-item class="navigationsIcons" prepend-icon="mdi-arrow-left-box" title="Log out" min-height="50" to="/Login" @click="logout"></v-list-item>

      <v-overlay :model-value="overlay" class="align-center justify-center">
        <v-progress-circular color="primary" size="100" indeterminate></v-progress-circular>
        <img class="logo" src="/src/assets/images/logo.png" alt="logo.png">
      </v-overlay>
    </v-list>
  </v-navigation-drawer>
</template>

<style scoped>
.navigationsIcons:hover {
  background-color: #3A53A5;
  color: white;
}

.logo {
  position: absolute;
  opacity: 90%;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 90%;
}
</style>

<script>
export default {
  data() {
    return {
      overlay: false,
      header: 'FILE REPORT DATABASE SYSTEM',
      drawer: true,
      rail: true,
      lists: [
        { icon: 'mdi mdi-database', text: 'Dashboard', route: '/Data' },
        { icon: 'mdi mdi-list-box', text: 'Form', route: '/Form' },
      ]
    }
  },
  methods: {
    getHeader(value) {
      this.header = value;
    },
    logout(){
      this.$emit('access', false);
    }
  },
  watch: {
    overlay(val) {
      val && setTimeout(() => {
        this.overlay = false
      }, 1000)
    },
  },
}
</script>