<template>
    <div class="Toolbar">
        <md-toolbar>
            <md-button class="md-icon-button" @click="toggleLeftSidenav">
                <md-icon>menu</md-icon>
            </md-button>

            <h2 class="md-title" style="flex: 1">Products App</h2>

            <md-button class="md-icon-button">
                <md-icon>star</md-icon>
            </md-button>
        </md-toolbar>

        <md-sidenav class="md-left" ref="leftSidenav" @open="open('Left')" @close="close('Left')">
            <md-toolbar>
                <div class="md-toolbar-container">
                    <h3 class="md-title">Sidenav content</h3>
                </div>
            </md-toolbar>

            <md-list>
                <router-link to="/hello">
                    <md-list-item @click="toggleLeftSidenav">
                        <md-avatar>
                            <img src="https://placeimg.com/40/40/people/5" alt="People">
                        </md-avatar>

                        <span>Home</span>

                        <md-button class="md-icon-button md-list-action">
                            <md-icon class="md-primary">chat_bubble</md-icon>
                        </md-button>
                    </md-list-item>
                </router-link>
                <router-link to="/Products">
                <md-list-item @click="toggleLeftSidenav">
                    <md-avatar>
                        <img src="https://placeimg.com/40/40/people/1" alt="People">
                    </md-avatar>

                    <span>Products</span>

                    <md-button class="md-icon-button md-list-action">
                        <md-icon class="md-primary">chat_bubble</md-icon>
                    </md-button>
                </md-list-item>
                </router-link>
        </md-sidenav>
    </div>
</template>

<script>
export default {
  name: 'toolbar',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
    }
  },
  methods: {
    toggleLeftSidenav() {
      this.$refs.leftSidenav.toggle();
    },
    open(ref) {
      console.log('Opened: ' + ref);
    },
    close(ref) {
      console.log('Closed: ' + ref);
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>